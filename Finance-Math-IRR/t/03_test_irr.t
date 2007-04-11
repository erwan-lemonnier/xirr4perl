#!/usr/local/bin/perl
#################################################################
#
#   $Id: 03_test_irr.t,v 1.1 2007-04-11 12:22:52 erwan_lemonnier Exp $
#
#   @author       erwan lemonnier
#   @description  test Finance::Math::IRR against a number of cashflows verified in excell
#   @system       pluto
#   @function     base
#   @function     vf
#

use strict;
use warnings;
use Test::More tests => 9;
use lib "../lib/";

use_ok('Finance::Math::IRR');

#local $Math::Polynom::DEBUG = 1;
#local $Finance::Math::IRR::DEBUG = 1;

my $count = 0;

sub test_xirr {
    my($expect,%args) = @_;
    my $v = xirr(%args);
    my $p = $args{precision} || 0.001;

    $count++;

    if (defined $expect) {
	if (defined $v) {
	    ok(abs($v - $expect) < $p, "cashflow $count has IRR=$v, which is whithin $p of $expect");
	} else {
	    ok(0,"cashflow $count has IRR=undef, while expectin $expect");
	}
    } else {
	is($v, undef, "cashflow $count has IRR=undef as expected");
    }
}

test_xirr(1, 'precision' => 1.32,
	  '2001-01-01' => 10,
	  '2002-01-01' => -20,
	  );

# a real life example:
test_xirr(-0.019632, precision => 0.00001,
	  '1995-01-28' =>  13.50,
	  '1995-02-28' =>  13.50,
	  '1995-03-28' =>  13.50,
	  '1995-04-28' =>  13.50,
	  '1995-05-28' =>  13.50,
	  '1995-06-28' =>  13.50,
	  '1995-07-28' =>  13.50,
	  '1995-08-28' =>  13.50,
	  '1995-09-28' =>  13.50,
	  '1995-10-28' =>  13.50,
	  '1995-11-28' =>  13.50,
	  '1995-12-28' =>  13.50,
	  '1997-01-28' =>  131.50,
	  '1997-02-28' =>  131.50,
	  '1997-03-28' =>  131.50,
	  '1997-04-28' =>  131.50,
	  '1997-05-28' =>  131.50,
	  '1997-06-28' =>  131.50,
	  '1997-07-28' =>  131.50,
	  '1997-08-28' =>  131.50,
	  '1997-09-28' =>  131.50,
	  '1997-10-28' =>  131.50,
	  '1997-11-28' =>  131.50,
	  '1997-12-28' =>  131.50,
	  '1998-01-28' => -64.33,
	  '1998-02-28' => -64.33,
	  '1998-03-28' => -64.33,
	  '1998-04-28' => -64.33,
	  '1998-05-28' => -64.33,
	  '1998-06-28' => -64.33,
	  '1998-07-28' => -64.33,
	  '1998-08-28' => -64.33,
	  '1998-09-28' => -64.33,
	  '1998-10-28' => -64.33,
	  '1998-11-28' => -64.33,
	  '1998-12-28' => -64.33,
	  '1999-01-28' =>  23.17,
	  '1999-02-28' =>  23.17,
	  '1999-03-28' =>  23.17,
	  '1999-04-28' =>  23.17,
	  '1999-05-28' =>  23.17,
	  '1999-06-28' =>  23.17,
	  '1999-07-28' =>  23.17,
	  '1999-08-28' =>  23.17,
	  '1999-09-28' =>  23.17,
	  '1999-10-28' =>  23.17,
	  '1999-11-28' =>  23.17,
	  '1999-12-28' =>  23.17,
	  '2001-03-15' =>  -4.00,
	  '2001-03-22' =>  44.03,
	  '2001-07-12' =>  -8.00,
	  '2001-08-16' =>  -8.00,
	  '2001-09-13' =>  -8.00,
	  '2001-10-11' =>  -8.00,
	  '2001-11-15' =>  -8.00,
	  '2001-12-13' =>  -8.00,
	  '2002-01-15' =>  -6.00,
	  '2002-02-13' =>  -6.00,
	  '2002-03-13' =>  -6.00,
	  '2002-04-18' =>  -6.00,
	  '2002-04-24' =>  -1091.59,
	  );

test_xirr(-0.1243234, precision => 0.00001,
	  '2002-01-01' =>     1161.91,
	  '2002-01-15' =>       -6.00,
	  '2002-02-13' =>       -6.00,
	  '2002-03-13' =>       -6.00,
	  '2002-04-18' =>       -6.00,
	  '2002-04-24' =>    -1091.59,
	  );

# that one has no solution: no intervals on which brent is negative
test_xirr(undef, precision => 0.00001,
	  '2001-01-01' =>      705.57,
	  '2001-03-22' =>      563.43,
	  '2001-12-31' =>        0.00,
	  );

# only 0 transactions implies irr=0
test_xirr(0, precision => 0.00001,
	  '2001-01-01' =>        0.00,
	  '2001-12-31' =>        0.00,
	  );

# a real life exemple
test_xirr(-0.047480, precision => 0.00001,
	  '2003-01-28' =>        67.67,
	  '2003-02-28' =>        67.67,
	  '2003-03-28' =>        67.67,
	  '2003-04-28' =>        67.67,
	  '2003-05-28' =>        67.67,
	  '2003-06-28' =>        67.67,
	  '2003-07-28' =>        67.67,
	  '2003-08-28' =>        67.67,
	  '2003-09-28' =>        67.67,
	  '2003-10-28' =>        67.67,
	  '2003-11-28' =>        67.67,
	  '2003-12-28' =>        67.67,
	  '2005-02-03' =>        -5.00,
	  '2005-03-03' =>        -4.00,
	  '2005-04-03' =>        -4.00,
	  '2005-04-15' =>      -732.65,
);

# another real life example, on which secant is known to fail because converging to a non root
test_xirr(0.0166307306, precision => 0.001,
	 '1997-07-28' => '25216.6666666667',
	  '1999-04-28' => '29291.6666666667',
	  '2004-10-28' => '43000',
	  '1996-11-28' => '28400',
	  '2000-09-28' => '35683.3333333333',
	  '2002-06-28' => '39583.3333333333',
	  '2004-03-28' => '43000',
	  '1996-04-28' => '28400',
	  '1998-01-28' => '25100',
	  '2001-10-28' => '36808.3333333333',
	  '1999-08-28' => '29291.6666666667',
	  '2001-03-28' => '36808.3333333333',
	  '1998-12-28' => '25100',
	  '1995-01-28' => '25983.3333333333',
	  '2004-07-28' => '43000',
	  '1996-08-28' => '28400',
	  '1998-05-28' => '25100',
	  '2003-11-28' => '42475',
	  '1995-12-28' => '25983.3333333333',
	  '2001-07-28' => '36808.3333333333',
	  '2003-04-28' => '42475',
	  '1995-05-28' => '25983.3333333333',
	  '2005-01-28' => '45683.3333333333',
	  '1997-02-28' => '25216.6666666667',
	  '2000-11-28' => '35683.3333333333',
	  '1998-09-28' => '25100',
	  '2000-04-28' => '35683.3333333333',
	  '2005-12-28' => '45683.3333333333',
	  '2002-01-28' => '39583.3333333333',
	  '1999-10-28' => '29291.6666666667',
	  '2003-08-28' => '42475',
	  '1995-09-28' => '25983.3333333333',
	  '2005-05-28' => '45683.3333333333',
	  '1997-06-28' => '25216.6666666667',
	  '1999-03-28' => '29291.6666666667',
	  '2002-12-28' => '39583.3333333333',
	  '1996-10-28' => '28400',
	  '2000-08-28' => '35683.3333333333',
	  '2002-05-28' => '39583.3333333333',
	  '2004-02-28' => '43000',
	  '1996-03-28' => '28400',
	  '2005-09-28' => '45683.3333333333',
	  '1999-07-28' => '29291.6666666667',
	  '2001-02-28' => '36808.3333333333',
	  '1998-11-28' => '25100',
	  '2002-09-28' => '39583.3333333333',
	  '2004-06-28' => '43000',
	  '1996-07-28' => '28400',
	  '1998-04-28' => '25100',
	  '2003-10-28' => '42475',
	  '1995-11-28' => '25983.3333333333',
	  '2001-06-28' => '36808.3333333333',
	  '2003-03-28' => '42475',
	  '1995-04-28' => '25983.3333333333',
	  '1997-01-28' => '25216.6666666667',
	  '2000-10-28' => '35683.3333333333',
	  '1998-08-28' => '25100',
	  '2000-03-28' => '35683.3333333333',
	  '2005-11-28' => '45683.3333333333',
	  '1997-12-28' => '25216.6666666667',
	  '2003-07-28' => '42475',
	  '1995-08-28' => '25983.3333333333',
	  '2005-04-28' => '45683.3333333333',
	  '1997-05-28' => '25216.6666666667',
	  '1999-02-28' => '29291.6666666667',
	  '2002-11-28' => '39583.3333333333',
	  '2000-07-28' => '35683.3333333333',
	  '2002-04-28' => '39583.3333333333',
	  '2004-01-28' => '43000',
	  '1996-02-28' => '28400',
	  '2005-08-28' => '45683.3333333333',
	  '1997-09-28' => '25216.6666666667',
	  '1999-06-28' => '29291.6666666667',
	  '2004-12-28' => '43000',
	  '2001-01-28' => '36808.3333333333',
	  '1998-10-28' => '25100',
	  '2002-08-28' => '39583.3333333333',
	  '2007-01-30' => '-4996365',
	  '2004-05-28' => '43000',
	  '1996-06-28' => '28400',
	  '1998-03-28' => '25100',
	  '2001-12-28' => '36808.3333333333',
	  '1995-10-28' => '25983.3333333333',
	  '2001-05-28' => '36808.3333333333',
	  '2003-02-28' => '42475',
	  '1995-03-28' => '25983.3333333333',
	  '2004-09-28' => '43000',
	  '1998-07-28' => '25100',
	  '2000-02-28' => '35683.3333333333',
	  '2005-10-28' => '45683.3333333333',
	  '1997-11-28' => '25216.6666666667',
	  '2001-09-28' => '36808.3333333333',
	  '2003-06-28' => '42475',
	  '1995-07-28' => '25983.3333333333',
	  '2005-03-28' => '45683.3333333333',
	  '1997-04-28' => '25216.6666666667',
	  '1999-01-28' => '29291.6666666667',
	  '2002-10-28' => '39583.3333333333',
	  '2000-06-28' => '35683.3333333333',
	  '2002-03-28' => '39583.3333333333',
	  '1999-12-28' => '29291.6666666667',
	  '1996-01-28' => '28400',
	  '2005-07-28' => '45683.3333333333',
	  '1997-08-28' => '25216.6666666667',
	  '1999-05-28' => '29291.6666666667',
	  '2004-11-28' => '43000',
	  '1996-12-28' => '28400',
	  '2002-07-28' => '39583.3333333333',
	  '2004-04-28' => '43000',
	  '1996-05-28' => '28400',
	  '1998-02-28' => '25100',
	  '2001-11-28' => '36808.3333333333',
	  '1999-09-28' => '29291.6666666667',
	  '2001-04-28' => '36808.3333333333',
	  '2003-01-28' => '42475',
	  '1995-02-28' => '25983.3333333333',
	  '2004-08-28' => '43000',
	  '1996-09-28' => '28400',
	  '1998-06-28' => '25100',
	  '2003-12-28' => '42475',
	  '2000-01-28' => '35683.3333333333',
	  '1997-10-28' => '25216.6666666667',
	  '2001-08-28' => '36808.3333333333',
	  '2003-05-28' => '42475',
	  '1995-06-28' => '25983.3333333333',
	  '2005-02-28' => '45683.3333333333',
	  '1997-03-28' => '25216.6666666667',
	  '2000-12-28' => '35683.3333333333',
	  '2000-05-28' => '35683.3333333333',
	  '2002-02-28' => '39583.3333333333',
	  '1999-11-28' => '29291.6666666667',
	  '2003-09-28' => '42475',
	  '2005-06-28' => '45683.3333333333',
	  );

# another real life example, on which xirr returned a huge number when didn't filter away 0 transactions
test_xirr(-0.31488067035146, precision => 0.000001,
	  '1999-12-28' => '12800',
	  '1997-07-28' => '0',
	  '1999-04-28' => '12800',
	  '1997-08-28' => '0',
	  '1999-05-28' => '12800',
	  '1997-01-28' => '0',
	  '1997-10-28' => '0',
	  '1997-09-28' => '0',
	  '1999-06-28' => '12800',
	  '1997-02-28' => '0',
	  '1997-11-28' => '0',
	  '1999-07-28' => '12800',
	  '1997-03-28' => '0',
	  '1997-12-28' => '0',
	  '1999-08-28' => '12800',
	  '1997-04-28' => '0',
	  '1999-01-28' => '12800',
	  '1999-09-28' => '12800',
	  '1999-10-28' => '12800',
	  '1997-05-28' => '0',
	  '1999-02-28' => '12800',
	  '1999-11-28' => '12800',
	  '1997-06-28' => '0',
	  '1999-03-28' => '12800',
	  '2006-12-31' => '-9156',
	);

# this 
