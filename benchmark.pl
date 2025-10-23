use strict;
use warnings;
use Data::Dumper;
use File::Slurp;
use List::Util qw/ uniq /;

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

print Dumper(\%benchmark);
my @scripts = keys %benchmark;

my @languages = uniq
                map { keys %{$benchmark{$_}} }
                  keys %benchmark;
print Dumper(\@languages);

exit 0;

=head
sub uniq_langs {

@dedup = grep !$seen{$_}++ @orig_array;
}
=cut
