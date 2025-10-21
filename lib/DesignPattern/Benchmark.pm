package DesignPattern::Benchmark;

use Class;
extends qw/DesignPattern::Command/;

sub BUILD {
    my ($self, $args) = @_;
    $self->{count} = $args->{count} || 1_000_000;
}

sub execute {
    my ($self, $type) = @_;

    local @INC = (@INC, "$self->{path}/$type/lib");

    my $dp_handler = $self->_get_dp_handler();
    $dp_handler->benchmark($type, $self->{count});
}

sub _get_dp_handler {
    my ($self) = @_;

    my $dp_class = $self->_get_dp_class_name($self->{dp});

    eval "require $dp_class"
        or die "ERROR: Cannot load design pattern handler $dp_class: $@";
    return $dp_class->new(path => $self->{path});
}

1;
