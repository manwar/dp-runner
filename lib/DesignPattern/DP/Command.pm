package DesignPattern::DP::Command;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Light;
    require LightOnCommand;
    require LightOffCommand;
    require RemoteControl;
    my $light     = Light->new;
    my $light_on  = LightOnCommand->new(light => $light);
    my $light_off = LightOffCommand->new(light => $light);
    my $remote    = RemoteControl->new;
    $remote->set_command($light_on);
    $remote->press_button;
    is($light->status, 'ON');
    $remote->set_command($light_off);
    $remote->press_button;
    is($light->status, 'OFF');
    $remote->undo;
    is($light->status, 'ON');
    $remote->undo;
    is($light->status, 'OFF');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Light;
            require LightOnCommand;
            require LightOffCommand;
            require RemoteControl;
            my $light     = Light->new;
            my $light_on  = LightOnCommand->new(light => $light);
            my $light_off = LightOffCommand->new(light => $light);
            my $remote    = RemoteControl->new;
            $remote->set_command($light_on);
            $remote->press_button;
            $light->status;
            $remote->set_command($light_off);
            $remote->press_button;
            $light->status;
            $remote->undo;
            $light->status;
            $remote->undo;
            $light->status;
        }
    });
}

1;
