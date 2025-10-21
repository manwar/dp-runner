#!use/bin/env perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok('DesignPattern::Runner')  || print "Bail out!\n";
}

diag( "Testing DesignPattern::Runner $DesignPattern::Runner::VERSION, Perl $], $^X" );

done_testing;
