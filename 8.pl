#!/usr/bin/perl

while(<>) {
  /(\w+) ([+-]\d+)/;
  push(@p, [$1, $2]);
}

%m = (
  acc => sub { ($_[1] + 1, $_[2] + $_[0]) },
  jmp => sub { ($_[1] + $_[0], $_[2]) },
  nop => sub { ($_[1] + 1, $_[2]) },
);

sub run {
  my ($j, $r, @s);

  while() {
    return ('i',$j) if $s[$r]++;
    ($r, $j) = $m{$_[$r]->[0]}->($_[$r]->[1], $r, $j);
    last if $r eq @_;
  }
  return ('f',$j);
}

($r,$j) = run(@p);
warn "1: $j";

foreach (@p) {
  ($r,$j) = run(@p) if($_->[0] =~ tr/jmno/nojm/);
  last if $r eq 'f';
  $_->[0] =~ tr/jmno/nojm/;
}
warn "2; $j";
