use strict;
use warnings;

use Time::HiRes 'time';
use Config::Tiny;

$| = 1;
my $config = Config::Tiny->read( 'etc/main.conf' );
printf "Perl (increment)%s...\n",
       $config->{global}->{DEBUG} ? ' in DEBUG mode' : '';

my ($i, $l_inc) = (0, 0);
my ($step, $final) = ($config->{increment}->{STEP}, $config->{increment}->{FINAL});
my $t0 = time;

while ($i < $final) {
    if ($i % $step == 0) {
        printf("\rincrementing... %.1f%%", $i*100/$final);
    }
    $l_inc += length($i);
    $i++;
}

printf "\nincrement %d times, total length %d\n",
    $final, $l_inc;

printf "time total: %.3f seconds\n", time - $t0;
