use strict;
use warnings;
use File::Slurp;
use List::Util qw/ uniq /;
use Text::ASCIITable;

my @log_files = glob("*/output_*.log");

my %benchmark;
my %benchmark_quick;

my $language = '';
foreach my $filepath (@log_files) {
    ($language) = split /\//, $filepath;
    die("Error: $!")
        if length($language) < 1;

    my @lines = read_file($filepath);
    my $script = '';
    foreach my $line (@lines) {
        $script = $2
            if $line =~ /^# run (quick )?(\w+)\.{3}/;
        my $quick = $1 ? 1 : 0;
        if ($line =~ /^time total: (\d+\.\d{3}) seconds/) {
            die("Error: $!")
                if length($script) < 1;
            if ($quick) {
                $benchmark_quick{ $script }{ $language } = $1;
            } else {
                $benchmark{ $script }{ $language } = $1;
            }
        }
    }
}

my @scripts = keys %benchmark;

my @languages = uniq
                map { keys %{$benchmark{$_}} }
                  keys %benchmark;

my %global_benchmark;
foreach my $script (@scripts) {
    foreach my $language (@languages) {
        $global_benchmark{$script}{$language} = sprintf "%s%s",
                                                $benchmark_quick{ $script }{ $language }
                                                    ? (sprintf "%s / ",  $benchmark_quick{ $script }{ $language })
                                                    : '',
                                                $benchmark{ $script }{ $language }
                                                    ? $benchmark{ $script }{ $language }
                                                : '-';
    }
}

my $t = Text::ASCIITable->new({ headingText => 'YABenchmark' });
$t->setCols( 'script\lang', map { ucfirst lc $_ } @languages );
foreach my $script (@scripts) {
    $t->addRow($script, map { $global_benchmark{$script}{$_} } @languages );
}
$t->addRowLine();
print $t;

=head
$t->addRow('','Total',57.9);
=cut

exit 0;

sub getCols {
    my $langs = shift;
    return sprintf "'%s'", join "','", @$langs;
}
