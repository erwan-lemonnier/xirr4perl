Module Version: 0.10   Source 

## NAME

Finance::Math::IRR - Calculate the internal rate of return of a cash flow

## SYNOPSIS

    use Finance::Math::IRR;

    # we provide a cash flow
    my %cashflow = (
        '2001-01-01' => 100,
        '2001-03-15' => 250.45,
        '2001-03-20' => -50,
        '2001-06-23' => -763.12,  # the last transaction should always be <= 0
    );

    # and get the internal rate of return for this cashflow
    # we want a precision of 0.1%
    my $irr = xirr(%cashflow, precision => 0.001);

    # or simply: my $irr = xirr(%cashflow);

    if (!defined $irr) {
        die "ERROR: xirr() failed to calculate the IRR of this cashflow\n";
    }
    
## DESCRIPTION

The internal rate of return (IRR) is a powerfull tool when evaluating the behaviour of a cashflow. It is typically used to assess whether an investment will yield profit. But since you are reading those lines, I assume you already know what an IRR is about.

In this module, the internal rate of return is calculated in a similar way as in the function XIRR present in both Excell and Gnumeric. This means that cash flows where transactions come at irregular intervals are well supported, and the rate is a yearly rate.

An IRR is obtained by finding the root of a polynomial where each coefficient is the amount of one transaction in the cash flow, and the power of the corresponding coefficient is the number of days between that transaction and the first transaction divided by 365 (one year). Note that it isn't a polynomial in the traditional meaning since its powers may have decimals or be less than 1.

There is no universal way to solve this equation analytically. Instead, we have to find the polynomial's root with various root finding algorithms. That's where the fun starts...

The approach of Finance::Math::IRR is to try to approximate one of the polynomial's roots with the secant method. If it fails, Brent's method is tried. However, Brent's method requires to know of an interval such that the polynomial is positive on one end of the interval and negative on the other. Finance::Math::IRR searches for such an interval by trying systematically a sequence of points. But it may fail to find such an interval and therefore fail to approximate the cashflow's IRR:

## API

xirr(%cashflow, precision => $float)
Calculates an approximation of the internal rate of return (IRR) of the provided cashflow. The returned IRR will be within $float of the exact IRR. The cashflow is a hash with the following structure:

    my %cashflow = (
        # date => transaction_amount
        '2006-01-01' => 15,
        '2006-01-15' => -5,
        '2006-03-15' => -8,
    );
To get the IRR in percent, multiply xirr's result by 100.

If precision is omitted, it defaults to 0.001, yielding 0.1% precision on the resulting IRR.

xirr may fail to find the IRR, in which case it returns undef.

xirr will croak if you feed it with junk.

xirr removes all transactions with amount 0 from the cashflow. If the resulting cashflow is empty, an irr of 0% is returned. If the resulting cashflow contains only one non 0 transaction, undef is returned.

## DISCUSSION

Finding the right strategy to solve the IRR equation is tricky. Finance::Math::IRR uses a slightly different technique than the corresponding XIRR function in Gnumeric.

Gnumeric uses first Newton's method to approximate the IRR. If it fails, it evaluates the polynomial on a sequence of points ( '-1 + 10/(i+9)' and 'i' with i from 1 to 1024), hoping to find 2 points where the polynomial is respectively positive and negative. If it finds 2 such points, gnumeric's XIRR then uses the bisection method on their interval.

Finance::Math::IRR has a slightly different strategy. It uses the secant method instead of Newton's, and Brent's method instead of the bisection. Both methods are believed to be superior to their Gnumeric counterparts. Finance::Math::IRR performs additional controls to guaranty the validity of the result, such as controlling that the root candidate returned by Secant and Brent really are roots.

## DEBUG

To display debug information, set in your code:

    local $Finance::Math::IRR::DEBUG = 1;

## BUGS AND LIMITATIONS

This module has been used in recquiring production environments and thoroughly tested. It is therefore believed to be robust.

Yet, the method used in xirr may fail to find the IRR even on cashflows that do have an IRR. If you happen to find such an example, please email it to the author at <erwan@cpan.org>.

## REPOSITORY

The source of Finance::Math::IRR is hosted at sourceforge as part of the xirr4perl project. You can access it at https://sourceforge.net/projects/xirr4perl/.

## SEE ALSO

See Math::Polynom, Math::Function::Roots.

## THANKS

Kind thanks to Gautam Satpathy (gautam@satpathy.in) who provided me with his port of Gnumeric's XIRR to Java. Its source can be found at http://www.satpathy.in/jxirr/index.html.

Thanks to the team of Gnumeric for releasing their implementation of XIRR in open source. For the curious, the code for XIRR is available in the sources of Gnumeric in the file 'plugins/fn-financial/functions.c' (as of Gnumeric 1.6.3).

More thanks to Nicholas Caratzas for his efficient help and sharp financial and mathematical insight!

## AUTHOR

Erwan Lemonnier <erwan@cpan.org>, as part of the Pluto developer group at the Swedish Premium Pension Authority.

## LICENSE

This code was developed at the Swedish Premium Pension Authority as part of the Authority's software development activities. This code is distributed under the same terms as Perl itself. We encourage you to help us improving this code by sending feedback and bug reports to the author(s).

This code comes with no warranty. The Swedish Premium Pension Authority and the author(s) decline any responsibility regarding the possible use of this code or any consequence of its use.
