#!/usr/bin/perl

my $m = shift || 1;
my $r = 0;
my @p = ({s=>3});
splice(@p, 1, 0, ({s=>1},{s=>5},{s=>7},{s=>1,r=>2})) if $m == 2;

while(<>) {
  my @s = split(//);
  foreach (@p) {
    next if defined(${$_}{'r'}) and $r % ${$_}{'r'} != 0;
    ${$_}{'h'}++ if $s[${$_}{'p'} % $#s] eq '#';
    ${$_}{'p'}+=${$_}{'s'};
  }
  $r++;
}

my $j = $p[0]{'h'};
if($m==2) {
  foreach(@p[1..$#p]) {
    $j*=${$_}{'h'};
  }
}
warn $j;
