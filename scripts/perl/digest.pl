use strict;
use warnings;

use Digest::MD5 qw(md5_hex);
use Digest::SHA qw(sha1_hex sha256_hex sha384_hex sha512_hex);
use Time::HiRes 'time';
use Config::Tiny;

$| = 1;
my $config = Config::Tiny->read( '../etc/main.conf' );

my $str = 'a' x $config->{digest}->{STR_SIZE};
my $s_digest_md5 =  md5_hex $str;
my $s_digest_sha1 = sha1_hex $str;
my $s_digest_sha256 = sha256_hex $str;
my $s_digest_sha384 = sha384_hex $str;
my $s_digest_sha512 = sha512_hex $str;

printf "Perl (Digest::MD5 and Digest::SHA)%s...%s\n",
       $config->{global}->{DEBUG} ? ' in DEBUG mode' : '',
       $config->{global}->{DEBUG} ? '' : ' please wait';

my ($t0, $l_digest_md5) = (time, 0);
for (1 .. $config->{digest}->{TRIES}) {
    $l_digest_md5 += length md5_hex $str;
    printf "\rmd5 hashing... %.1f%%", $_*100 / $config->{digest}->{TRIES}
        if $config->{global}->{DEBUG};
}
my $t_digest_md5 = time - $t0;
printf "\n"
    if $config->{global}->{DEBUG};

my ($t1, $l_digest_sha1) = (time, 0);
for (1 .. $config->{digest}->{TRIES}) {
    $l_digest_sha1 += length sha1_hex $str;
    printf "\rsha1 hashing... %.1f%%", $_*100 / $config->{digest}->{TRIES}
        if $config->{global}->{DEBUG};
}
my $t_digest_sha1 = time - $t1;
printf "\n"
    if $config->{global}->{DEBUG};

my ($t2, $l_digest_sha256) = (time, 0);
for (1 .. $config->{digest}->{TRIES}) {
    $l_digest_sha256 += length sha256_hex $str;
    printf "\rsha256 hashing... %.1f%%", $_*100 / $config->{digest}->{TRIES}
        if $config->{global}->{DEBUG};
}
my $t_digest_sha256 = time - $t2;
printf "\n"
    if $config->{global}->{DEBUG};

my ($t3, $l_digest_sha384) = (time, 0);
for (1 .. $config->{digest}->{TRIES}) {
    $l_digest_sha384 += length sha384_hex $str;
    printf "\rsha384 hashing... %.1f%%", $_*100 / $config->{digest}->{TRIES}
        if $config->{global}->{DEBUG};
}
my $t_digest_sha384 = time - $t3;
printf "\n"
    if $config->{global}->{DEBUG};

my ($t4, $l_digest_sha512) = (time, 0);
for (1 .. $config->{digest}->{TRIES}) {
    $l_digest_sha512 += length sha512_hex $str;
    printf "\rsha512 hashing... %.1f%%", $_*100 / $config->{digest}->{TRIES}
        if $config->{global}->{DEBUG};
}
my $t_digest_sha512 = time - $t4;
printf "\n"
    if $config->{global}->{DEBUG};

printf "md5 digest %s... to %s...: %d total length, %.2f seconds\n",
    substr($str, 0, 6), substr($s_digest_md5, 0, 6),
    $l_digest_md5, $t_digest_md5;

printf "sha1 digest %s... to %s...: %d total length, %.2f seconds\n",
    substr($str, 0, 6), substr($s_digest_sha1, 0, 6),
    $l_digest_sha1, $t_digest_sha1;

printf "sha256 digest %s... to %s...: %d total length, %.2f seconds\n",
    substr($str, 0, 6), substr($s_digest_sha256, 0, 6),
    $l_digest_sha256, $t_digest_sha256;

printf "sha384 digest %s... to %s...: %d total length, %.2f seconds\n",
    substr($str, 0, 6), substr($s_digest_sha384, 0, 6),
    $l_digest_sha384, $t_digest_sha384;

printf "sha512 digest %s... to %s...: %d total length, %.2f seconds\n",
    substr($str, 0, 6), substr($s_digest_sha512, 0, 6),
    $l_digest_sha512, $t_digest_sha512;

printf "time total: %.3f seconds\n", $t_digest_md5 + $t_digest_sha1 + $t_digest_sha256 +
                                     $t_digest_sha384 +  $t_digest_sha512;
