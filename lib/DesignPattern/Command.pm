package DesignPattern::Command;

use Class;

sub BUILD {
    my ($self, $args) = @_;

    for (qw/dp path/) {
        die "Missing required key '$_'.\n" unless (exists $self->{$_});
    }
}

sub execute { ... }

sub _get_dp_class_name {
    my ($self, $pattern_name) = @_;

    my $registry = $DesignPattern::Runner::PATTERN_REGISTRY{$pattern_name};
    return "DesignPattern::DP::$registry->{class}" if $registry;
}

1;
