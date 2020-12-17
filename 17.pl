#!/usr/bin/perl

$m = shift || 1;

$z = 7;
$y = $max = 7;

while(<>) {
  chomp;
  $x = $max;
  $y++;
  foreach(split(//)) {
    $g[$z][$y][$x++] = $_ and next if $m == 1;
    $g[$z][$max][$y][$x++] = $_;
  }
}
$max = $y;

sub c1 {
  my ($z,$y,$x) = @_;
  my $c= 0;
  foreach $tz ($z-1..$z+1) {
    foreach $ty ($y-1..$y+1) {
      foreach $tx ($x-1..$x+1) {
        next if $tz == $z and $ty == $y and $tx == $x;
        $c++ if $g[$tz]->[$ty]->[$tx] eq '#';
      }
    }
  }
  $c;
}

sub mut1 {
  my @r;
  foreach $z (1..$#g+1) {
    foreach $y (1..$max) {
      foreach $x (1..$max) {
        $c = c1($z,$y,$x);
        if ($g[$z]->[$y]->[$x] eq '#') {
          if ($c == 2 or $c == 3) {
            $r[$z]->[$y]->[$x] = '#';
          } else {
            $r[$z]->[$y]->[$x] = '.';
          }
        } elsif ($c == 3) {
          $r[$z]->[$y]->[$x] = '#';
        }
      }
    }
  }
  $max++;
  @r;
}

sub c_all1 {
  my $c;
  foreach $z (0..$#g) {
    foreach $y (0..$max) {
      foreach $x (0..$max) {
        $c++ if $g[$z]->[$y]->[$x] eq '#';
      }
    }
  }
  $c;
}

sub c2 {
  my ($z,$w,$y,$x) = @_;
  my $c= 0;
  foreach $tz ($z-1..$z+1) {
    foreach $tw ($w-1..$w+1) {
      foreach $ty ($y-1..$y+1) {
        foreach $tx ($x-1..$x+1) {
          next if $tz == $z and $ty == $y and $tw == $w and $tx == $x;
          $c++ if $g[$tz]->[$tw]->[$ty]->[$tx] eq '#';
        }
      }
    }
  }
  $c;
}

sub mut2 {
  my @r;
  foreach $z (1..$#g+1) {
    foreach $w (1..$max) {
      foreach $y (1..$max) {
        foreach $x (1..$max) {
          $c = c2($z,$w,$y,$x);
          if ($g[$z]->[$w]->[$y]->[$x] eq '#') {
            if ($c == 2 or $c == 3) {
              $r[$z]->[$w]->[$y]->[$x] = '#';
            } else {
              $r[$z]->[$w]->[$y]->[$x] = '.';
            }
          } elsif ($c == 3) {
            $r[$z]->[$w]->[$y]->[$x] = '#';
          }
        }
      }
    }
  }
  $max++;
  @r;
}

sub c_all2 {
  my $c;
  foreach $z (0..$#g) {
    foreach $w (0..$max) {
      foreach $y (0..$max) {
        foreach $x (0..$max) {
          $c++ if $g[$z]->[$w]->[$y]->[$x] eq '#';
        }
      }
    }
  }
  $c;
}

foreach (0..5) {
  @g = mut1() and next if $m == 1;
  @g = mut2();
}

warn c_all1() if $m == 1;
warn c_all2() if $m == 2;
