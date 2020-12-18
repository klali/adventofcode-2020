#!/usr/bin/perl

$m = shift || 1;

sub calc {
  my $t = shift;
  while() {
    @_ = $t =~ m/(\d+) ([\+\*]) (\d+)/ or last;
    $c = $1 * $3 if $2 eq '*';
    $c = $1 + $3 if $2 eq '+';
    $i = index($t, "$1 $2 $3");
    substr($t, $i, length("$1 $2 $3")) = $c;
  }
  $t;
}

sub calc2 {
  my $t = shift;
  return calc($t) if $m == 1;
  while() {
    @_ = $t =~ m/(\d+) \+ (\d+)/ or last;
    $c = $1 + $2;
    $i = index($t, "$1 + $2");
    substr($t, $i, length("$1 + $2")) = $c;
  }
  calc($t);
}

while(<>) {
  chomp;
  $s = $_;
  while() {
    @_ = $s =~ m/\(([^()]+)\)/g or last;
    foreach $t (@_) {
      $c = calc2($t);
      $i = index($s, "($t)");
      substr($s, $i, length("($t)")) = $c;
    }
  }
  $r += calc2($s);
}

warn $r;
