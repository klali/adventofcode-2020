#!/usr/bin/perl

my $m = shift || 1;

while(<>) {
  chomp;
  if($_ eq "") {
    @f = map { @$_ } @p;
    $j += grep { @{[join('', @f) =~ /$_/g]} eq @p } keys %{{map { $_ => 1 } @f}} if $m eq 2;
    $j += keys(%{{map { $_ => 1 } @f}}) if $m eq 1;
    @p = ();
  } else {
    splice @p, 1, 0, \@{[(split//)]};
  }
}

warn $j;
