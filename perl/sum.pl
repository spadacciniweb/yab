use strict;
use warnings;

$| = 1;

my $i = 0;
my $final = 1_000_000_000;
my $step = $final/10;
while ($i < $final) {
    $i++;
    if ($i % $step == 1) {
        printf("\r%.1f%%", $i/$final*100);
    }
}
print "\n",$i, ' end';
