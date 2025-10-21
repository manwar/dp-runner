package DesignPattern::DP::Memento;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Caretaker;
    require Originator;
    my $originator = Originator->new(state => 'State1');
    my $caretaker  = Caretaker->new();
    is($originator->state, 'State1');
    $caretaker->add_memento($originator->save_state);
    $originator->set_state('State2');
    is($originator->state, 'State2');
    $originator->restore_state($caretaker->get_memento);
    is($originator->state, 'State1');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Caretaker;
            require Originator;
            my $originator = Originator->new(state => 'State1');
            my $caretaker  = Caretaker->new();
            $originator->state;
            $caretaker->add_memento($originator->save_state);
            $originator->set_state('State2');
            $originator->state;
            $originator->restore_state($caretaker->get_memento);
            $originator->state;
        }
    });
}

1;
