#!/usr/bin/perl

my $m = shift || 1;

$d = 90;
@w = (1,10);

while(<>) {
  ($l,$i) = /(\w)(\d+)/;

  if($m == 2) {
    if($l eq 'F') {
      $p[0] += $w[0] * $i;
      $p[1] += $w[1] * $i;
    }
    $i = -$i if $l eq 'L' or $l eq 'S' or $l eq 'W';
    if ($l eq 'E' or $l eq 'W') {
      $w[1] += $i;
    } elsif ($l eq 'N' or $l eq 'S') {
      $w[0] += $i;
    } elsif ($d == 180) {
      $w[0] = -$w[0];
      $w[1] = -$w[1];
    } elsif ($l eq 'L' or $l eq 'R') {
      $s = $i / 90;
      if($s == 2 or $s == -2) {
        $w[0] = -$w[0];
        $w[1] = -$w[1];
      } elsif($s == 1 or $s == -3) {
        $a = $w[1];
        $w[1] = $w[0];
        $w[0] = -$a;
      } elsif($s == -1 or $s == 3) {
        $a = $w[0];
        $w[0] = $w[1];
        $w[1] = -$a;
      } else {
        die "$l $i";
      }
    }
  }

  if($m == 1) {
    if ($l eq 'F') {
      $l = 'N' if $d == 0;
      $l = 'E' if $d == 90;
      $l = 'S' if $d == 180;
      $l = 'W' if $d == 270;
    }
    $i = -$i if $l eq 'L' or $l eq 'S' or $l eq 'W';
    if ($l eq 'L' or $l eq 'R') {
      $d += $i;
      $d %= 360;
    } elsif ($l eq 'E' or $l eq 'W') {
      $p[1] += $i;
    } elsif ($l eq 'N' or $l eq 'S') {
      $p[0] += $i;
    }
  }
}

warn abs($p[0]) + abs($p[1]);
