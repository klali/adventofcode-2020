#!/usr/bin/perl

while(<>) {
  chomp;
  $rule = rules($r1[0], 0) and next unless $_;
  $r1[$1] = $2 and next if /^(\d+): ((?:"[\w]+")|(?:[\d\s\|]+))$/;
  $match++ if m/^$rule$/;
}

warn $match;

sub rules {
  my ($r, $index) = @_;
  my @r;
  if ($r =~ /\|/) {
    @r = split /\| /, $r;
  } elsif ($r =~ m/^[\d\s]+$/) {
    push(@r, $r);
  } elsif ($r =~ m/^"(\w)"/) {
    return $1;
  }

  my $str;
  foreach my $rule (@r) {
    my $str2;
    foreach (split / /, $rule) {
      $str2 .= "#" and next if $_ == $index;
      $str2 .= rules($r1[$_], $_);
    }
    if($str2 =~ /#$/) {
      $str2 =~ s/#//;
      $str2 = "(?:$str2)+";
    } elsif ($str2 =~ /#/) {
      @strs = split /#/, $str2;
      $str2 = "";
      foreach (2..4) {
        $str2 .= '|' if $str2;
        $str2 .= "(?:".$strs[0]."{$_}".$strs[1]."{$_})";
      }
    }
    $str = "(?:$str|$str2)" and next if $str and $str2;
    $str = $str2;
  }
  return $str;
}

