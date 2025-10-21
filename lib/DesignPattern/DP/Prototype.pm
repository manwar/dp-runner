package DesignPattern::DP::Prototype;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    use Test::Exception;
    require ShapeCache;
    my $cache = ShapeCache->new;
    is($cache->getShape(1)->id, 1);
    is($cache->getShape(1)->type, 'Circle');
    is($cache->getShape(1)->draw, 'Inside Shape::Circle::draw()');
    is($cache->getShape(2)->id, 2);
    is($cache->getShape(2)->type, 'Square');
    is($cache->getShape(2)->draw, 'Inside Shape::Square::draw()');
    is($cache->getShape(3)->id, 3);
    is($cache->getShape(3)->type, 'Rectangle');
    is($cache->getShape(3)->draw, 'Inside Shape::Rectangle::draw()');
    dies_ok(sub { Shape::Circle->new();    });
    dies_ok(sub { Shape::Square->new();    });
    dies_ok(sub { Shape::Rectangle->new(); });
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require ShapeCache;
            my $cache = ShapeCache->new;
            $cache->getShape(1)->id;
            $cache->getShape(1)->type;
            $cache->getShape(1)->draw;
            $cache->getShape(2)->id;
            $cache->getShape(2)->type;
            $cache->getShape(2)->draw;
            $cache->getShape(3)->id;
            $cache->getShape(3)->type;
            $cache->getShape(3)->draw;
        }
    });
}

1;
