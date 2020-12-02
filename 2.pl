#!/usr/bin/perl

my $m = shift || 1;
my $j = 0;

while(<>) {
  m/(\d+)\-(\d+) (\w): (\w+)/;
  if($m == 1) {
    my @s = ($1, $2, $3, $4);
    my $i = 0;
    while(${s[3]} =~ m/${s[2]}/g) {
      $i++;
    }
    $j++ if $i >= $s[0] && $i <= $s[1];
  } else {
    my @w = split(//, $4);
    $j++ if $w[$1-1] eq $3 xor $w[$2-1] eq $3;
  }
}
warn $j;
