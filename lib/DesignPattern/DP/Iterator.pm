package DesignPattern::DP::Iterator;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Container::NameRepository;
    my $repository = Container::NameRepository->new(
        names => [ qw(A B C D E) ]
    );
    my $iterator = $repository->getIterator;
    is($iterator->next, 'A');
    is($iterator->next, 'B');
    is($iterator->next, 'C');
    is($iterator->next, 'D');
    is($iterator->next, 'E');
    is($iterator->has_next, '');
    is(!!$iterator->next, '',);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Container::NameRepository;
            my $repository = Container::NameRepository->new(
                names => [ qw(A B C D E) ]
            );
            my $iterator = $repository->getIterator;
            $iterator->next;
            $iterator->next;
            $iterator->next;
            $iterator->next;
            $iterator->next;
            $iterator->has_next;
            !!$iterator->next;
        }
    });
}

1;
