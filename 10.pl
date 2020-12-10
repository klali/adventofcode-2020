#!/usr/bin/perl

while(<>) {
  push(@p, $_);
}

@p = sort { $a <=> $b } @p;
unshift(@p, 0);
push(@p, $p[-1] + 3);

foreach $i (0..$#p) {
  @q[$p[$i] - $p[$i-1]]++ if $i > 0;
  foreach $j ($i+1..$#p) {
    last if $p[$j] > $p[$i] + 3;
    push(@{$s{$p[$i]}}, [$p[$j],-1]);
  }
}

sub count {
  my $c;
  foreach(@_) {
    $c += 1 if $_->[0] == $p[-1];
    $_->[1] = count(@{$s{$_->[0]}}) if $_->[1] == -1;
    $c += $_->[1];
  }
  $c;
}

warn $q[1] * $q[3];
warn count(@{$s{0}});
