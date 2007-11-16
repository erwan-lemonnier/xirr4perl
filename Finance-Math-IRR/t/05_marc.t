#
# $Id: 05_marc.t,v 1.1 2007-11-16 06:59:31 erwan_lemonnier Exp $
#
# this example provided by Marc Chafiian in october 2007
#

use strict;
use warnings;
use Test::More;
use lib "../lib/";
use Finance::Math::IRR;

eval "use Date::Calc qw(Add_Delta_Days);";
plan skip_all => "Date::Calc required for testing continuity" if $@;

plan tests => 1;

my %cashflow = (
    '2005-12-16' => 46000000,
    '2006-01-06' => 15000000,
    '2006-01-26' =>  5000000,
    '2006-02-02' =>  5000000,
    '2006-03-17' =>   217756,
    '2006-03-20' =>  1572788,
    '2006-03-22' =>  1209456,
    '2006-03-31' =>  3000000,
    '2006-04-13' =>  5000000,
    '2006-05-05' =>  7000000,
    '2006-05-23' =>  5000000,
    '2006-06-08' => 10000000,
    '2006-06-26' => 10000000,
    '2006-08-04' =>  4000000,
    '2006-08-21' =>  8000000,
    '2006-10-05' =>  7000000,
    '2007-06-14' => 10000000,
#    '2007-09-30' => 52000000,
		);

# test with different end amounts in the cashflow
my $irr1 = xirr(%cashflow, '2007-09-30' => -92000000);
my $irr2 = xirr(%cashflow, '2007-09-30' => -93000000);
my $irr3 = xirr(%cashflow, '2007-09-30' => -52000000);
my $irr4 = xirr(%cashflow, '2007-09-30' => -42000000);
my $irr5 = xirr(%cashflow, '2007-09-30' =>        -1);

use Data::Dumper;
print Dumper($irr1,$irr2,$irr3,$irr4,$irr5);

ok(1);
