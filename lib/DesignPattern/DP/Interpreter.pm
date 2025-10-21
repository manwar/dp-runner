package DesignPattern::DP::Interpreter;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Add;
    require Number;
    my $expr = Add->new(
        left  => Number->new(value => 15),
        right => Number->new(value => 10),
    );
    is($expr->interpret, 25);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Add;
            require Number;
            my $expr = Add->new(
                left  => Number->new(value => 15),
                right => Number->new(value => 10),
            );
            $expr->interpret;
        }
    });
}

1;
