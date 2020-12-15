#!/usr/bin/perl

$m = shift || 1;
@i = <>;

foreach (split /,/, $i[0]) {
  chomp;
  next unless $_;
  $p[$_] = ++$t;
  $l = $_;
}

$c = 2020 if $m == 1;
$c = 30000000 unless defined($c);

while($t < $c) {
  if($p[$l]) {
    $n = $t - $p[$l];
  } else {
    $n = 0;
  }
  $p[$l] = $t++;
  $l = $n;
}

warn "$t - $l";
