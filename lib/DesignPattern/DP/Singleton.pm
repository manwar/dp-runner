package DesignPattern::DP::Singleton;

use Class;
extends qw/DesignPattern::DP::Base/;

our $SINGLETON_COUNTER = 0;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require SingleObject;
    is(SingleObject->instance->counter, ++$SINGLETON_COUNTER);
    is(SingleObject->instance->counter, ++$SINGLETON_COUNTER);
    is(SingleObject->instance->counter, ++$SINGLETON_COUNTER);
    is(SingleObject->instance->counter, ++$SINGLETON_COUNTER);
    is(SingleObject->instance->counter, ++$SINGLETON_COUNTER);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require SingleObject;
            SingleObject->instance->counter;
            SingleObject->instance->counter;
            SingleObject->instance->counter;
            SingleObject->instance->counter;
            SingleObject->instance->counter;
        }
    });
}

1;
