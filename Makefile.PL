#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DesignPattern::Runner',
    AUTHOR              => q{Mohammad Sajid Anwar <mohammad.anwar@yahoo.com>},
    LICENSE             => 'artistic_2',
    EXE_FILES           => [ 'script/dp-runner' ],
    MIN_PERL_VERSION    => 5.042,
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'DesignPattern-Runner-*'    },
);
