#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  push(@p, [split //]);
}

sub v {
  $_->[0] >= 0 && $_->[0] <= $#p && $_->[1] >= 0 && $_->[1] <= $#{$p[0]};
}

sub a {
  my ($x, $y) = @_;
  @a = (
    [$x-1, $y-1],[$x-1,$y],[$x-1,$y+1],
    [$x,$y-1],[$x,$y+1],
    [$x+1,$y-1],[$x+1,$y],[$x+1,$y+1]
  );
  if($m == 2) {
    foreach $_ (@a) {
      while($p[$_->[0]]->[$_->[1]] eq '.') {
        last unless v($_);
        $_->[0]-- if $_->[0] < $x;
        $_->[0]++ if $_->[0] > $x;
        $_->[1]-- if $_->[1] < $y;
        $_->[1]++ if $_->[1] > $y;
      }
    }
  }
  return grep { v($_) } @a;
}

sub mutate {
  my $s;
  for $i (0..$#p) {
    for $j (0..$#{$p[$i]}) {
      $q[$i]->[$j] = '.' and next if $p[$i]->[$j] eq '.';
      $o = grep { $p[$_->[0]]->[$_->[1]] eq '#'  } a($i,$j);
      $q[$i]->[$j] = '#' and $s++ if $p[$i]->[$j] eq 'L' and $o == 0;
      $q[$i]->[$j] = 'L' and $s++ if $p[$i]->[$j] eq '#' and $o >= 3 + $m;
    }
  }
  @p = map {[@$_] } @q;
  $s;
}

while($s = mutate()) { }

warn scalar(grep { $_ eq '#' } map { @$_ } @p);
