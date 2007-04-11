#!/usr/local/bin/perl
#################################################################
#
#   $Id: 06_test_eval.t,v 1.1 2007-04-11 08:52:34 erwan_lemonnier Exp $
#
#   @author       erwan lemonnier
#   @description  test method eval
#   @system       pluto
#   @function     base
#   @function     vf
#

use strict;
use warnings;
use Test::More tests => 54;
use lib "../lib/";

use_ok('Math::Polynom');

sub test_eval {
    my($p,@tests) = @_;
    while (@tests) {
	my $value = shift @tests;
	my $want  = shift @tests;

	is($p->eval($value),$want,"eval($value) on [".$p->stringify."]");

	if ($want ne 'nan') {
	    if ($want > 0) {	
		is($p->xpos, $value, "xpos set to value");
		is($p->xneg, undef,  "xneg stays undef");
	    } elsif ($want < 0) {	
		is($p->xpos, undef,  "xpos stays undef");
		is($p->xneg, $value, "xneg set to value");
	    } else {
		is($p->xpos, undef,  "xpos stays undef");
		is($p->xneg, undef,  "xneg stays undef");
	    }
	}

	$p->xpos(undef);
	$p->xneg(undef);
    }
}


# empty polynom
my $p = Math::Polynom->new();
test_eval($p,
	  0 => 0,
	  12 => 0,
	  );

# constant polynom
$p = Math::Polynom->new(0 => 5);
test_eval($p,
	  -5 => 5,
	  2 => 5,
	  654321 => 5,
	  );

# a simple square
$p = Math::Polynom->new(2 => 1);
test_eval($p,
	  -5 => 25,
	  2 => 4,
	  14 => 196,
	  0 => 0,
	  );

# a more complex one
$p = Math::Polynom->new(2 => 3, .5 => 5.2);
test_eval($p,
	  -5 => 'nan', # should crash!
	  4  =>  58.4,
	  0 => 0,
	  );

# negative power
$p = Math::Polynom->new(-1 => 10);
test_eval($p,
	  1 => 10,
	  10 => 1,
	  5 => 2,
	  -5 => -2,
	  );

# fault handling
eval { $p->eval(undef); };
ok((defined $@ && $@ =~ /got undefined/),"eval(undef)");

eval { $p->eval(); };
ok((defined $@ && $@ =~ /got wrong number of arguments/), "eval()");

eval { $p->eval(1,2); };
ok((defined $@ && $@ =~ /got wrong number of arguments/), "eval(1,2)");

eval { $p->eval([]); };
ok((defined $@ && $@ =~ /is not numeric/),"eval([])");

eval { $p->eval({}); };
ok((defined $@ && $@ =~ /is not numeric/),"eval({})");

eval { $p->eval('abc'); };
ok((defined $@ && $@ =~ /is not numeric/),"eval('abc')");

eval { $p->eval('+-32'); };
ok((defined $@ && $@ =~ /is not numeric/),"eval('+-32')");