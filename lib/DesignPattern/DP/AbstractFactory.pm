package DesignPattern::DP::AbstractFactory;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require FactoryProducer;
    my $factoryProducer = FactoryProducer->new;
    my $shapeFactory1 = $factoryProducer->getFactory(0);
    my $shape1 = $shapeFactory1->getShape("RECTANGLE");
    is($shape1->draw, 'Inside Shape::Rectangle::draw()');
    my $shape2 = $shapeFactory1->getShape("SQUARE");
    is($shape2->draw, 'Inside Shape::Square::draw()');
    my $shapeFactory2 = $factoryProducer->getFactory(1);
    my $shape3 = $shapeFactory2->getShape("RECTANGLE");
    is($shape3->draw, 'Inside Shape::RoundedRectangle::draw()');
    my $shape4 = $shapeFactory2->getShape("SQUARE");
    is($shape4->draw, 'Inside Shape::RoundedSquare::draw()');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require FactoryProducer;
            my $factoryProducer = FactoryProducer->new;
            my $shapeFactory1 = $factoryProducer->getFactory(0);
            my $shape1 = $shapeFactory1->getShape("RECTANGLE");
            $shape1->draw;
            my $shape2 = $shapeFactory1->getShape("SQUARE");
            $shape2->draw;
            my $shapeFactory2 = $factoryProducer->getFactory(1);
            my $shape3 = $shapeFactory2->getShape("RECTANGLE");
            $shape3->draw;
            my $shape4 = $shapeFactory2->getShape("SQUARE");
            $shape4->draw;
         }
     });
}

1;
