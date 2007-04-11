#!/usr/local/bin/perl
use strict;
use warnings;
use lib "lib/";
use Finance::Math::IRR;

my $tag = "VERSION_".$Finance::Math::IRR::VERSION;
$tag =~ s/\.//;
print "-> tagging files with tag [$tag]\n";

`cat MANIFEST | grep -v META.yml | xargs cvs tag $tag`;
