#!/usr/bin/perl

$m = shift || 1;

sub c2 {
  my $t = shift;
  my $ops = shift;
  while() {
    $t =~ m/(\d+ $ops \d+)/ or last;
    $c = eval "$1";
    $t =~ s/\Q$1/$c/;
  }
  $t;
}

sub c {
  return c2($_[0], qr/[\+\*]/) if $m == 1;
  c2(c2($_[0], qr/[\+]/), qr/[\*]/);
}

while(<>) {
  while() {
    m/\(([^()]+)\)/g or last;
    $c = c($1);
    s/\Q($1)/$c/;
  }
  $r += c($_);
}

warn $r;
