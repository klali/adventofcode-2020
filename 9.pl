#!/usr/bin/perl

while(<>) {
  chomp;
  push(@p, $_);
  next if @p <= 25;
  $j = $_ unless ${{map { $q = $_; map { $q + $_ => 1 } @p[$#p-26..$#p-1] } @p[$#p-26..$#p-1]}}{$_};
}

warn $j;

foreach $q (0..$#p) {
  $sum = 0;
  foreach $r ($q..$#p) {
    last if ($sum += $p[$r]) > $j;
    die eval join '+', (sort(@p[$q..$r]))[0,$r-$q] if $sum == $j;
  }
}
