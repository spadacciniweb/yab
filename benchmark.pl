use strict;
use warnings;
use File::Slurp;
use List::Util qw/ uniq /;
use Text::ASCIITable;

my @log_files = glob("*/output_*.log");

my %benchmark;

my $language = '';
foreach my $filepath (@log_files) {
    ($language) = split /\//, $filepath;
    die("Error: $!")
        if length($language) < 1;

    my @lines = read_file($filepath);
    my $script = '';
    foreach my $line (@lines) {
        $script = $1
            if $line =~ /^# run (\w+)\.{3}/;
        if ($line =~ /^time total: (\d+\.\d{3}) seconds/) {
            die("Error: $!")
                if length($script) < 1;
            $benchmark{ $script }{ $language } = $1;
        }
    }
}

my @scripts = keys %benchmark;

my @languages = uniq
                map { keys %{$benchmark{$_}} }
                  keys %benchmark;


my $t = Text::ASCIITable->new({ headingText => 'My benchmark' });
$t->setCols( 'script\lang', map { ucfirst lc $_ } @languages );
foreach my $script (@scripts) {
    $t->addRow($script, map { $benchmark{$script}{$_} ? $benchmark{$script}{$_} : '-' } @languages );
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
