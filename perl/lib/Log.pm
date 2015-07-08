package Log;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub protocol {
}

sub method {
}

sub path {
}

sub uri {
}

sub time {
}

1;
