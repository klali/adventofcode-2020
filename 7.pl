#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  my @n = /((?:\w+ \w+)|(?:\d+ \w+ \w+)) bag/g;
  foreach (@n[1..$#n]) {
    next unless /(\d+) (\w+ \w+)/;
    push(@{$p{$2}}, $n[0]);
    push(@{$q{$n[0]}}, [$1, $2]);
  }
}

sub t1 {
  my @r = map { t1(@{$p{$_}}) } @_;
  return (@r, @_);
}

sub t2 {
  my $r;
  foreach (@_) {
    $r += $_->[0] + t2(@{$q{$_->[1]}}) * $_->[0];
  }
  return $r;
}

$j = keys %{{map { $_ => 1 } t1(@{$p{'shiny gold'}})}} if $m eq 1;
$j = t2(@{$q{'shiny gold'}}) if $m eq 2;

warn $j;
