package DesignPattern::DP::FactoryMethod;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require ShapeFactory;
    my $shapeFactory = ShapeFactory->new;
    my $shape1 = $shapeFactory->getShape('CIRCLE');
    is($shape1->draw, 'Inside Shape::Circle::draw()');
    my $shape2 = $shapeFactory->getShape('SQUARE');
    is($shape2->draw, 'Inside Shape::Square::draw()');
    my $shape3 = $shapeFactory->getShape('RECTANGLE');
    is($shape3->draw, 'Inside Shape::Rectangle::draw()');
    my $shape4 = $shapeFactory->getShape('rectangle');
    is($shape4->draw, 'Inside Shape::Rectangle::draw()');
    my $no_shape = $shapeFactory->getShape('TRIQUETRA');
    ok(!defined $no_shape);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require ShapeFactory;
            my $shapeFactory = ShapeFactory->new;
            $shapeFactory->getShape('CIRCLE')->draw;
            $shapeFactory->getShape('SQUARE')->draw;
            $shapeFactory->getShape('RECTANGLE')->draw;
            $shapeFactory->getShape('rectangle')->draw;
            $shapeFactory->getShape('TRIQUETRA');
        }
    });
}

1;
