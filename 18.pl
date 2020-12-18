#!/usr/bin/perl

$m = shift || 1;

sub c2 {
  my $t = shift;
  while() {
    $t =~ m/(\d+) ($_[0]) (\d+)/ or last;
    $c = $2 eq '+' ? $1 + $3 : $1 * $3;
    $t =~ s/\Q$1 $2 $3/$c/;
  }
  $t;
}

sub c {
  return c2($_[0], qr/[\+\*]/) if $m == 1;
  c2(c2($_[0], qr/[\+]/), qr/[\*]/);
}

while(<>) {
  while() {
    m/\(([^()]+)\)/ or last;
    $c = c($1);
    s/\Q($1)/$c/;
  }
  $r += c($_);
}

warn $r;
