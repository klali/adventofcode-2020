#!/usr/bin/perl

my $m = shift || 1;
my $j = 0;

while(<>) {
  my @s = m/(\d+)\-(\d+) (\w): (\w+)/;
  if($m == 1) {
    my @i = $4 =~ m/($3)/g;
    $j++ if scalar(@i) >= $s[0] && scalar(@i) <= $s[1];
  } else {
    my @w = split(//, $4);
    $j++ if $w[$1-1] eq $3 xor $w[$2-1] eq $3;
  }
}
warn $j;
