package DesignPattern::DP::Adapter;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    use Test::Exception;
    require Player::Media::Audio;
    require Player::AdvancedMedia::MP4;
    require Player::AdvancedMedia::VLC;
    is(Player::Media::Audio->new(audio_type => 'mp3')->play, 'Playing MP3.');
    is(Player::Media::Audio->new(audio_type => 'mp4')->play, 'Playing MP4.');
    is(Player::Media::Audio->new(audio_type => 'vlc')->play, 'Playing VLC.');
    dies_ok( sub { Player::Media::Adapter->new(audio_type => 'invalid') }  );
    is(Player::AdvancedMedia::VLC->new->playVLC, 'Playing VLC.');
    is(Player::AdvancedMedia::MP4->new->playMP4, 'Playing MP4.');
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Player::Media::Audio;
            require Player::AdvancedMedia::MP4;
            require Player::AdvancedMedia::VLC;
            Player::Media::Audio->new(audio_type => 'mp3')->play;
            Player::Media::Audio->new(audio_type => 'mp4')->play;
            Player::Media::Audio->new(audio_type => 'vlc')->play;
            eval { Player::Media::Adapter->new(audio_type => 'invalid') };
            Player::AdvancedMedia::VLC->new->playVLC;
            Player::AdvancedMedia::MP4->new->playMP4;
        }
    });
}

1;
