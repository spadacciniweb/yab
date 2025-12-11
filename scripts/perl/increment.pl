use strict;
use warnings;

use Time::HiRes 'time';
use Config::Tiny;

$| = 1;
my $config = Config::Tiny->read( '../etc/main.conf' );
my $DEBUG = $config->{global}->{DEBUG};

printf "Perl (increment)%s...%s\n",
       $DEBUG ? ' in DEBUG mode' : '',
       $DEBUG ? '' : ' please wait';

my ($i, $l_inc) = (0, 0);
my ($step, $final) = ($config->{increment}->{STEP}, $config->{increment}->{FINAL});
my $t0 = time;

while ($i < $final) {
    $DEBUG and ($i % $step == 0) and printf("\rincrementing... %.1f%%", $i*100/$final);
    $l_inc += length($i);
    $i++;
}
print "\n"
    if $DEBUG;

printf "increment %d times, total length %d\n",
    $final, $l_inc;

printf "time total: %.3f seconds\n", time - $t0;
