package DesignPattern::DP::Bridge;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    use Test::Exception;
    require Shape::Circle;
    require Shape::Circle::Red;
    require Shape::Circle::Blue;
    require Shape::Circle::Green;

    dies_ok( sub { Shape::Circle->new } );
    dies_ok( sub { Shape::Circle->new(x => 1) } );
    dies_ok( sub { Shape::Circle->new(x => 1, y => 2) } );
    dies_ok( sub { Shape::Circle->new(x => 1, y => 2, radius => 3) } );

    my $greenCircle = Shape::Circle->new(
        x => 10, y => 10, radius => 20,
        drawAPI => Shape::Circle::Green->new,
    );
    is($greenCircle->draw, 'drawCircle(color = green; radius = 20; x = 10; y = 10)');
    my $blueCircle = Shape::Circle->new(
        x => 5, y => 5, radius => 15,
        drawAPI => Shape::Circle::Blue->new,
    );
    is($blueCircle->draw, 'drawCircle(color = blue; radius = 15; x = 5; y = 5)');
    my $redCircle = Shape::Circle->new(
        x => 20, y => 20, radius => 10,
        drawAPI => Shape::Circle::Red->new,
    );
    is($redCircle->draw, 'drawCircle(color = red; radius = 10; x = 20; y = 20)');
    is($redCircle->x, 20);
    is($redCircle->y, 20);
    is($redCircle->radius, 10);
    ok($redCircle->drawAPI->isa('Shape::Circle::Red'));
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Shape::Circle;
            require Shape::Circle::Red;
            require Shape::Circle::Blue;
            require Shape::Circle::Green;
            Shape::Circle->new(
                x => 10, y => 10, radius => 20,
                drawAPI => Shape::Circle::Green->new,
            )->draw;
            Shape::Circle->new(
                x => 5, y => 5, radius => 15,
                drawAPI => Shape::Circle::Blue->new,
            )->draw;
            Shape::Circle->new(
                x => 20, y => 20, radius => 10,
                drawAPI => Shape::Circle::Red->new,
            )->draw;
        }
    });
}

1;
