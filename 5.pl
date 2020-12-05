#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  tr/FBLR/0101/;
  $p{oct("0b" . $_)} = 1;
}
@p = sort {$a <=> $b} keys(%p);
($j) = grep(!$p{$_}, (8..$#p)) if $m eq 2;
$j = $p[$#p] if $m eq 1;

warn $j;
