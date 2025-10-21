package DesignPattern::DP::ChainOfResponsibility;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require WordHandler;
    require NumberHandler;
    require DefaultHandler;
    my $number = NumberHandler->new;
    $number->next(WordHandler->new)
           ->next(DefaultHandler->new);
    is($number->handle('123'),   'NumberHandler processed request: 123');
    is($number->handle('hello'), 'WordHandler processed request: hello');
    is($number->handle('45abc'), 'DefaultHandler handled everything else: 45abc');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require WordHandler;
            require NumberHandler;
            require DefaultHandler;
            my $number = NumberHandler->new;
            $number->next(WordHandler->new)
                   ->next(DefaultHandler->new);
            $number->handle('123');
            $number->handle('hello');
            $number->handle('45abc');
        }
    });
}

1;
