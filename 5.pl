#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  tr/FBLR/0101/;
  $d = oct("0b" . $_);
  $j = $d if $d > $j;
  $p{$d} = 1;
}
($j) = grep(!$p{$_}, (8..$j)) if $m eq 2;

warn $j;
