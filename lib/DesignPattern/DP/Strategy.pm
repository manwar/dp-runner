package DesignPattern::DP::Strategy;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require TextFormatter;
    require UpperCaseFormatter;
    require LowerCaseFormatter;
    my $upper_strategy = UpperCaseFormatter->new;
    my $lower_strategy = LowerCaseFormatter->new;
    my $formatter = TextFormatter->new(strategy => $upper_strategy);
    is($formatter->publish("Hello World"), "HELLO WORLD");
    $formatter->strategy($lower_strategy);
    is($formatter->publish("Hello World"), "hello world");
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require TextFormatter;
            require UpperCaseFormatter;
            require LowerCaseFormatter;
            my $upper_strategy = UpperCaseFormatter->new;
            my $lower_strategy = LowerCaseFormatter->new;
            my $formatter = TextFormatter->new(strategy => $upper_strategy);
            $formatter->publish("Hello World");
            $formatter->strategy($lower_strategy);
            $formatter->publish("Hello World");
        }
    });
}

1;
