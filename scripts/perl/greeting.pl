use strict;
use warnings;

use Time::HiRes 'time';
use Config::Tiny;

$| = 1;
my $config = Config::Tiny->read( '../etc/main.conf' );
my $DEBUG = $config->{global}->{DEBUG};

printf "Perl (greeting)%s...%s\n",
       $DEBUG ? ' in DEBUG mode' : '',
       $DEBUG ? '' : ' please wait';

my ($i, $l_greeting) = (0, 0);
my $greeting = $config->{greeting}->{GREETING};
my $final = $config->{greeting}->{FINAL};
my $t0 = time;

while ($i < $final) {
    printf "\r%s...", $greeting;
    $DEBUG and printf " %.1f%%", $i*100/$final;
    $l_greeting += length($greeting);
    $i++;
}
print "\n";

printf "'%s' %d times, total length %d\n",
    $greeting, $final, $l_greeting;

printf "time total: %.3f seconds\n", time - $t0;
