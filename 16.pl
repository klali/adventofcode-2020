#!/usr/bin/perl

$m = shift || 1;

O: while(<>) {
  chomp;
  next unless $_;
  $s++ and next if /ticket/;
  if($s == 0) {
    /^([^:]+): (\d+)-(\d+) or (\d+)-(\d+)$/;
    $r{$1} = [$2, $3, $4, $5];
  } else {
    @f = split /,/;
    @t = @f and next if $s == 1;
    my %kt;
    o: foreach $i (0..$#f) {
      $v=0;
      foreach $k (keys(%r)) {
        $col{$k}++;
        if (($f[$i] >= $r{$k}->[0] and $f[$i] <= $r{$k}->[1]) or
          ($f[$i] >= $r{$k}->[2] and $f[$i] <= $r{$k}->[3])) {
          $v = 1;
          next o if $m == 1;
        } elsif ($m == 2) {
          $kt{$k} = $i;
        }
      }
      $t += $f[$i] and next if $m == 1;
      next O if $v == 0;
    }
    grep { $c[$kt{$_}]->{$_}++ } keys(%kt);
  }
}

die $t if $m == 1;

while(keys(%col)) {
  foreach $i (0..$#c) {
    @k = grep { !exists($c[$i]->{$_}) } keys(%col);
    next if scalar(@k) != 1;
    $col[$i] = $k[0];
    delete $col{$k[0]};
  }
}

$t = 1;
grep { $t *= $t[$_] if $col[$_] =~ /^departure/ } (0..$#col);
warn $t;
