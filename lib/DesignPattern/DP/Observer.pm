package DesignPattern::DP::Observer;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Subject;
    require Observer::HexaObserver;
    require Observer::OctalObserver;
    require Observer::BinaryObserver;
    my $subject = Subject->new;
    my $hexO = Observer::HexaObserver->new(subject => $subject);
    $subject->attach($hexO);
    my $octO = Observer::OctalObserver->new(subject => $subject);
    $subject->attach($octO);
    my $binO = Observer::BinaryObserver->new(subject => $subject);
    $subject->attach($binO);
    my $tests = {
        14 => ['Hexa string: e.', 'Octal string: 16.','Binary string: 1110.' ],
        16 => ['Hexa string: 10.','Octal string: 20.','Binary string: 10000.'],
    };
    foreach my $state (sort { $a <=> $b } keys %$tests) {
        is_deeply($subject->setState($state), $tests->{$state});
    }
    $subject->detach($binO);
    $subject->detach($octO);
    is_deeply($subject->setState(11), ['Hexa string: b.']);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Subject;
            require Observer::HexaObserver;
            require Observer::OctalObserver;
            require Observer::BinaryObserver;
            my $subject = Subject->new;
            my $hexO = Observer::HexaObserver->new(subject => $subject);
            $subject->attach($hexO);
            my $octO = Observer::OctalObserver->new(subject => $subject);
            $subject->attach($octO);
            my $binO = Observer::BinaryObserver->new(subject => $subject);
            $subject->attach($binO);
            $subject->setState(14);
            $subject->setState(16);
            $subject->detach($binO);
            $subject->detach($octO);
            $subject->setState(11);
        }
    });
}

1;
