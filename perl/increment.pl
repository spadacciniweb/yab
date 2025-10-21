use strict;
use warnings;

use Time::HiRes 'time';
use Config::Tiny;

$| = 1;
my $config = Config::Tiny->read( 'etc/main.conf' );
use Data::Dumper;
printf "Perl (increment)%s...\n",
       $config->{global}->{DEBUG} ? ' in DEBUG mode' : '';

my ($i, $step, $final) = (0, $config->{increment}->{STEP}, $config->{increment}->{FINAL});
my $t0 = time;

while ($i < $final) {
    if ($i % $step == 0) {
        printf("\rincrementing... %.1f%%", $i/$final*100);
    }
    $i++;
}

printf "\nincrement %d times\n",
    $final;

printf "time total: %.3f seconds\n", time - $t0;
