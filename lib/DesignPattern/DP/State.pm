package DesignPattern::DP::State;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Context;
    require State::StartState;
    require State::StopState;
    my $context = Context->new;
    my $start   = State::StartState->new;
    $start->doAction($context);
    is($context->state->toString, 'Start State');
    my $stop    = State::StopState->new;
    $stop->doAction($context);
    is($context->state->toString, 'Stop State');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Context;
            require State::StartState;
            require State::StopState;
            my $context = Context->new;
            my $start   = State::StartState->new;
            $start->doAction($context);
            $context->state->toString;
            my $stop    = State::StopState->new;
            $stop->doAction($context);
            $context->state->toString;
        }
    });
}

1;
