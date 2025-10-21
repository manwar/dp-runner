package DesignPattern::Runner;

our $VERSION = '0.01';

use Class;
use Test::More;
use File::Spec;

our @PATTERN_ORDER = (
    # Creational Patterns
    'abf','bld','fam','prt','sng',
    # Structural Patterns
    'adp','brg','com','flt','dec','fac','prx',
    # Behavioural Patterns
    'cor','com','int','itr','med','mem','obs','sta','str','tem','vis',
);

our %PATTERN_REGISTRY = (
    # Creational Patterns
    'abf' => { name => 'Abstract Factory',        class => 'AbstractFactory' },
    'bld' => { name => 'Builder',                 class => 'Builder'         },
    'fam' => { name => 'Factory Method',          class => 'FactoryMethod'   },
    'prt' => { name => 'Prototype',               class => 'Prototype'       },
    'sng' => { name => 'Singleton',               class => 'Singleton'       },
    # Structural Patterns
    'adp' => { name => 'Adapter',                 class => 'Adapter'         },
    'brg' => { name => 'Bridge',                  class => 'Bridge'          },
    'cmp' => { name => 'Composite',               class => 'Composite'       },
    'flt' => { name => 'Filter',                  class => 'Filter'          },
    'dec' => { name => 'Decorator',               class => 'Decorator'       },
    'fac' => { name => 'Facade',                  class => 'Facade'          },
    'prx' => { name => 'Proxy',                   class => 'Proxy'           },
    # Behavioural Patterns
    'cor' => { name => 'Chain of Responsibility', class => 'ChainOfResponsibility' },
    'com' => { name => 'Command',                 class => 'Command'         },
    'int' => { name => 'Interpreter',             class => 'Interpreter'     },
    'itr' => { name => 'Iterator',                class => 'Iterator'        },
    'med' => { name => 'Mediator',                class => 'Mediator'        },
    'mem' => { name => 'Memento',                 class => 'Memento'         },
    'obs' => { name => 'Observer',                class => 'Observer'        },
    'sta' => { name => 'State',                   class => 'State'           },
    'str' => { name => 'Strategy',                class => 'Strategy'        },
    'tem' => { name => 'Template',                class => 'Template'        },
    'vis' => { name => 'Visitor',                 class => 'Visitor'         },
);

sub BUILD {
    my ($self, $args) = @_;
    $self->{mode}  //= 'both';
    $self->{count} //= 1_000_000;
    $self->{dp}    //= 'abf';
    $self->{_types}  = undef;
}

sub run {
    my ($self) = @_;

    my $dp_name = $self->resolve_dp_name($self->{dp});
    die "ERROR: Unknown design pattern '$self->{dp}'\n" .
        "Use --list to see available patterns.\n"
        unless $dp_name;

    my $types = $self->_detect_available_types;
    die "ERROR: No valid types found in path $self->{path}\n" unless @$types;

    if ($self->{mode} eq 'both') {
        $self->_run($dp_name, $types, 'test');
        $self->_run($dp_name, $types, 'benchmark');
    }
    else {
        $self->_run($dp_name, $types, $self->{mode});
    }
}

sub _run {
    my ($self, $dp_name, $types, $mode) = @_;

    my $handler_class = "DesignPattern::" .
        ($mode eq 'benchmark' ? 'Benchmark' : 'UnitTest');
    eval "require $handler_class"
        or die "ERROR: Cannot load $handler_class: $@";

    my $handler = $handler_class->new(
        path  => $self->{path},
        dp    => $self->{dp},
        count => $self->{count},
    );

    print ucfirst($mode) . "ing: $dp_name\n";
    foreach my $type (sort @$types) {
        print "Type: $type...\n" if ($mode eq 'test');
        $handler->execute($type);
    }

    if ($mode eq 'test') {
        done_testing;
    }
}

sub resolve_dp_name {
    my ($self, $input) = @_;

    return undef unless $input;

    return $PATTERN_REGISTRY{$input}->{name}
        if exists $PATTERN_REGISTRY{lc $input};

    return undef;
}

sub get_available_patterns {
    my ($self) = @_;

    my $ordered_registry;
    foreach my $abbr (@PATTERN_ORDER) {
        push @$ordered_registry, {
            abbr  => $abbr,
            name  => $PATTERN_REGISTRY{$abbr}->{name},
            class => $PATTERN_REGISTRY{$abbr}->{class},
        };
    }

    return $ordered_registry;
}

sub _detect_available_types {
    my ($self) = @_;

    return $self->{_types} if $self->{_types};

    my @detected_types;
    my $path = $self->{path};

    if (opendir(my $dh, $path)) {
        while (my $entry = readdir($dh)) {
            next if $entry =~ /^\.\.?$/;

            my $full_path = "$path/$entry";
            if (-d $full_path && -d "$full_path/lib") {
                push @detected_types, $entry;
            }
        }
        closedir($dh);
    } else {
        die "Cannot open directory $path: $!\n";
    }

    $self->{_types} = \@detected_types;
    return $self->{_types};
}

1;
