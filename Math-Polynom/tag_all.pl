#!/usr/bin/perl
use strict;
use warnings;
use lib "lib/";
use Math::Polynom;

my $tag = "VERSION_".$Math::Polynom::VERSION;
$tag =~ s/\.//;
print "-> tagging files with tag [$tag]\n";

`cat MANIFEST | grep -v META.yml | xargs cvs tag $tag`;
