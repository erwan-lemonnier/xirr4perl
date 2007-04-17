
#################################################################
#
#   $Id: 13_test_error_codes.t,v 1.2 2007-04-17 19:25:46 erwan_lemonnier Exp $
#
#   @author       erwan lemonnier
#   @description  test error codes
#   @system       pluto
#   @function     base
#   @function     vf
#

use strict;
use warnings;
use Test::More tests => 4;
use lib "../lib/";
use Math::Polynom;

is(Math::Polynom::NO_ERROR,            0, "check NO_ERROR");
is(Math::Polynom::ERROR_NAN,           1, "check ERROR_NAN");
is(Math::Polynom::ERROR_MAX_DEPTH,     2, "check ERROR_MAX_DEPTH");
is(Math::Polynom::ERROR_EMPTY_POLYNOM, 3, "check ERROR_EMPTY_POLYNOM");
