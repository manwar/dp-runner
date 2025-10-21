package DesignPattern::DP::Facade;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require ShapeMaker;
    my $shape = ShapeMaker->new;
    is($shape->drawCircle,    'Inside Shape::Circle::draw()');
    is($shape->drawSquare,    'Inside Shape::Square::draw()');
    is($shape->drawRectangle, 'Inside Shape::Rectangle::draw()');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require ShapeMaker;
            my $shape = ShapeMaker->new;
            $shape->drawCircle;
            $shape->drawSquare;
            $shape->drawRectangle;
        }
    });
}

1;
