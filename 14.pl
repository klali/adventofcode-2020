#!/usr/bin/perl

$m = shift || 1;

sub masks {
  my @m = split(//, shift);
  my $n = shift;
  my (@p, @f);
  foreach (0..$#m) {
    push @f, $_ and next if $m[$_] eq 'X';
    $m[$_] |= ($n >> ($#m - $_) & 0x01);
  }
  my $m = join("", @m);
  foreach $i (0..oct("0b" . "1" x scalar(@f))) {
    foreach $j (0..$#f) {
      substr($m, $f[$j], 1) = (($i >> ($#f - $j)) & 0x01);
    }
    push(@p, "0b$m");
  }
  @p;
}

while(<>) {
  ($c,$a,$v) = m/^(?:(mask)|(?:mem\[(\d+)\])) = ([\dX]+)$/;
  if($m == 1) {
    if($c eq 'mask') {
      $ma = "0b" . $v =~ tr/X/1/r,
      $mo = "0b" . $v =~ tr/X/0/r,
    } else {
      $p{$a} = ($v | oct($mo)) & oct($ma);
    }
  } else {
    if($c eq 'mask') {
      $mask = $v;
    } else {
      foreach (masks($mask, $a)) {
        $p{($a | oct($_)) & oct($_)} = $v;
      }
    }
  }
}

foreach (values(%p)) {
  $s += $_;
}
warn $s;
