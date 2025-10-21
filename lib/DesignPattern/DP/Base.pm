package DesignPattern::DP::Base;

use Class;
use Test::More;
use Test::Deep;

sub BUILD {
    my ($self, $args) = @_;
    die "Missing require key 'path'.\n"
        unless (exists $self->{path});
}

sub test {
    my ($self, $type) = @_;
    die "test method must be implemented by subclass";
}

sub benchmark {
    my ($self, $type) = @_;
    die "benchmark method must be implemented by subclass";
}

1;
