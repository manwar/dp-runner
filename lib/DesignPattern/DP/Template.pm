package DesignPattern::DP::Template;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Game::Cricket;
    require Game::Football;
    my $game;
    {
        local *STDOUT;
        my $output;
        open(STDOUT, '>', \$output);
        $game = Game::Cricket->new;
        $game->play;
        is($output, 'Cricket: initialise.Cricket: start play.Cricket: end play.');
    }
    {
        local *STDOUT;
        my $output;
        open(STDOUT, '>', \$output);
        $game = Game::Football->new;
        $game->play;
        is($output, 'Football: initialise.Football: start play.Football: end play.');
    }
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Game::Cricket;
            require Game::Football;
            my $game;
            {
                local *STDOUT;
                my $output;
                open(STDOUT, '>', \$output);
                $game = Game::Cricket->new;
                $game->play;
            }
            {
                local *STDOUT;
                my $output;
                open(STDOUT, '>', \$output);
                $game = Game::Football->new;
                $game->play;
            }
        }
    });
}

1;
