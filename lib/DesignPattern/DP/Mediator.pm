package DesignPattern::DP::Mediator;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    use Test::Deep;
    require User;
    require ChatRoom;
    my $chat  = ChatRoom->new;
    my $alice = User->new(name => 'Alice');
    my $bob   = User->new(name => 'Bob');
    my $carol = User->new(name => 'Carol');
    $chat->register_user($alice);
    $chat->register_user($bob);
    $chat->register_user($carol);
    $alice->send("Hello everyone!");
    $bob->send("Hi Alice!");
    is_deeply($alice->received_messages, ['Bob: Hi Alice!']);
    is_deeply($bob->received_messages,   ['Alice: Hello everyone!']);
    is_deeply($carol->received_messages, ['Alice: Hello everyone!', 'Bob: Hi Alice!']);
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require User;
            require ChatRoom;
            my $chat  = ChatRoom->new;
            my $alice = User->new(name => 'Alice');
            my $bob   = User->new(name => 'Bob');
            my $carol = User->new(name => 'Carol');
            $chat->register_user($alice);
            $chat->register_user($bob);
            $chat->register_user($carol);
            $alice->send("Hello everyone!");
            $bob->send("Hi Alice!");
            $alice->received_messages;
            $bob->received_messages;
            $carol->received_messages;
        }
    });
}

1;
