#!/usr/bin/perl

$m = shift || 1;

@p = <>;
@t = split /,/, $p[1];

if($m == 1) {
  foreach (@t) {
    next if $_ eq 'x';
    $m = $p[0] % $_;
    $n{$_ - $m} = $_;
  }
  @f = sort( { $a <=> $b } keys(%n));
  warn $f[0] * $n{$f[0]};
} else {
  ($f,$s) = (1,1);
  foreach $i (0..$#t) {
    next if $t[$i] eq 'x';
    while($f += $s) {
      last if (($f + $i) % $t[$i] == 0);
    }
    $s *= $t[$i];
  }
  warn $f;
}
