package DesignPattern::DP::Visitor;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Circle;
    require Rectangle;
    require AreaCalculator;
    my $circle     = Circle->new(radius => 2);
    my $rectangle  = Rectangle->new(width => 3, height => 4);
    my $calculator = AreaCalculator->new;
    is($circle->accept($calculator), 12.5664);
    is($rectangle->accept($calculator), 12);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Circle;
            require Rectangle;
            require AreaCalculator;
            my $circle     = Circle->new(radius => 2);
            my $rectangle  = Rectangle->new(width => 3, height => 4);
            my $calculator = AreaCalculator->new;
            $circle->accept($calculator);
            $rectangle->accept($calculator);
        }
    });
}

1;
