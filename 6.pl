#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  chomp;
  if($_ eq "") {
    $n = $p{num};
    delete $p{num};
    $j += grep { (values(%p))[$_] eq $n } 0..(keys(%p)) if $m eq 2;
    $j += keys(%p) if $m eq 1;
    %p = ();
  } else {
    %p = (%p, map { $_ => $p{$_} + 1 } split//);
    $p{num}++;
  }
}

warn $j;
