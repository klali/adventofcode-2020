#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  $d = oct("0b" . tr/FBLR/0101/r);
  $j = $d if $d > $j;
  $p{$d} = 1;
}
($j) = grep(!$p{$_}, (8..$j)) if $m eq 2;

warn $j;
