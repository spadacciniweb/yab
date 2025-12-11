use strict;
use warnings;

use MIME::Base64 qw(encode_base64 decode_base64);
use Time::HiRes 'time';
use Config::Tiny;

$| = 1;
my $config = Config::Tiny->read( '../etc/main.conf' );
my $DEBUG = $config->{global}->{DEBUG};

my $str = 'a' x $config->{base64}->{STR_SIZE};
my $s_encoded =  encode_base64 $str;
my $s_decoded = decode_base64 $s_encoded;

printf "Perl (MIME::Base64)%s...%s\n",
       $DEBUG ? ' in DEBUG mode' : '',
       $DEBUG ? '' : ' please wait';

my ($t0, $l_encoded) = (time, 0);
for (1 .. $config->{base64}->{TRIES}) {
    $l_encoded += length encode_base64 $str;
    $DEBUG and printf "\rencoding... %.1f%%", $_*100 / $config->{base64}->{TRIES};
}
my $t_encoded = time - $t0;
printf "\n"
    if $DEBUG;

my ($t1, $l_decoded) = (time, 0);
for (1 .. $config->{base64}->{TRIES}) {
    $l_decoded += length decode_base64 $s_encoded;
    $DEBUG and printf "\rdecoding... %.1f%%", $_*100 / $config->{base64}->{TRIES};
}
my $t_decoded = time - $t1;
printf "\n"
    if $DEBUG;

printf "encode %s... to %s...: %d total length, %.2f seconds\n",
    substr($str, 0, 6), substr($s_encoded, 0, 6),
    $l_encoded, $t_encoded;

printf "decode %s... to %s...: %d total length, %.2f seconds\n",
    substr($s_encoded, 0, 6), substr($s_decoded, 0, 6),
    $l_decoded, $t_decoded;

printf "time total: %.3f seconds\n", $t_encoded + $t_decoded;
