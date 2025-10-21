package DesignPattern::DP::Proxy;

use Class;
extends qw/DesignPattern::DP::Base/;

sub unit_test {
    my ($self, $type) = @_;

    use Test::More;
    require Image::ProxyImage;
    local *STDOUT;
    open STDOUT, '>', File::Spec->devnull or die "Can't redirect STDOUT: $!";
    my $image;
    {
        local *STDOUT;
        my $output;
        open(STDOUT, '>', \$output);
        $image = Image::ProxyImage->new(filename => 'dummy.png');
        $image->display;
        is($output, "Loading dummy.png ...Displaying dummy.png ...");
    }
    {
        local *STDOUT;
        my $output;
        open(STDOUT, '>', \$output);
        $image->display;
        is($output, "Displaying dummy.png ...");
    }
}

sub benchmark {
    my ($self, $type, $count) = @_;

    use Benchmark;
    timethese($count, {
        $type => sub {
            require Image::ProxyImage;
            local *STDOUT;
            open STDOUT, '>', File::Spec->devnull or die "Can't redirect STDOUT: $!";
            my $image;
            {
                $image = Image::ProxyImage->new(filename => 'dummy.png');
                $image->display;
            }
            {
                $image->display;
            }
        }
    });
}

1;
