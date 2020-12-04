#!/usr/bin/perl

my $m = shift || 1;
my $j = 0;
my %p;
my %v = (
  byr => qr/^(19[2-9]\d|200[0-2])$/,
  iyr => qr/^20((1\d)|(20))$/,
  eyr => qr/^20((2\d)$|(30))$/,
  hgt => qr/^((1(([5-8]\d)|(9[0-3]))cm)|((59|6\d|7[0-6])in))$/,
  hcl => qr/^#[0-9a-f]{6}$/,
  ecl => qr/^(amb|blu|brn|gry|grn|hzl|oth)$/,
  pid => qr/^\d{9}$/,
);

while(<>) {
  chomp;
  if($_ eq "") {
    $j++ if scalar(grep { $p{$_} } keys(%v)) == scalar(keys(%v));
    %p = ();
  }
  foreach(split(/ /)) {
    my @f = split(/:/);
    next if $f[0] eq 'cid';
    $p{$f[0]} = $f[1] if $m eq 1 or $f[1] =~ $v{$f[0]};
  }
}

warn $j;
