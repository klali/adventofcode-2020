#!/usr/bin/perl

while(<>) {
  /(\w+) ([+-]\d+)/;
  push(@p, [$1, $2]);
}

sub run {
  my @s;
  my $j, $r;

  while() {
    return ('i',$j) if $s[$r]++;
    if($_[$r]->[0] eq 'acc') {
      $j = eval "$j " . $_[$r++]->[1];
    } elsif($_[$r]->[0] eq 'jmp') {
      $r = eval "$r " . $_[$r]->[1];
    } elsif($_[$r]->[0] eq 'nop') {
      $r++;
    }
    last if $r eq @_;
    $r %= @_;
  }
  return ('f',$j);
}

($r,$j) = run(@p);
warn "1: $j";

foreach (@p) {
  if($_->[0] =~ tr/jmno/nojm/) {
    ($r,$j) = run(@p);
    last if $r eq 'f';
    $_->[0] =~ tr/jmno/nojm/;
  }
}
warn "2; $j";
