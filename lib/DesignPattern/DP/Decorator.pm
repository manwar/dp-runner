package DesignPattern::DP::Decorator;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Shape::Circle;
    require ShapeDecorator::Red;
    require ShapeDecorator::Filled;
    my $circle          = Shape::Circle->new;
    my $redCircle       = ShapeDecorator::Red->new(shape => $circle);
    my $filledCircle    = ShapeDecorator::Filled->new(shape => $circle);
    my $redFilledCircle = ShapeDecorator::Filled->new(shape => $redCircle);
    my $filledRedCircle = ShapeDecorator::Red->new(shape => $filledCircle);
    is($redCircle->draw,       'A circle with a red border');
    is($filledCircle->draw,    'A circle filled');
    is($redFilledCircle->draw, 'A circle with a red border filled');
    is($filledRedCircle->draw, 'A circle filled with a red border');
    { package MyClass { sub new { bless {}, $_[0] } } }
    ok ! eval { ShapeDecorator::Red->new(shape => MyClass->new) };
    like $@, qr/Invalid shape/;
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Shape::Circle;
            require ShapeDecorator::Red;
            require ShapeDecorator::Filled;
            my $circle       = Shape::Circle->new;
            my $redCircle    = ShapeDecorator::Red->new(shape => $circle);
            my $filledCircle = ShapeDecorator::Filled->new(shape => $circle);
            my $redFilledCircle = ShapeDecorator::Filled->new(shape => $redCircle);
            my $filledRedCircle = ShapeDecorator::Red->new(shape => $filledCircle);
            $redCircle->draw;
            $filledCircle->draw;
            $redFilledCircle->draw;
            $filledRedCircle->draw;
        }
    });
}

1;
