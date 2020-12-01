#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  foreach my $a (@_) {
    die $_ * $a if $m eq 1 and $_ + $a eq 2020;
    foreach my $b (@_) {
      die $_ * $a * $b if $m eq 2 and $_ + $a + $b eq 2020;
    }
  }
  push @_, $_;
}
