package Perinci::Easy;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(defsub);

our %SPEC;

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Some easy shortcuts for Perinci',
};

$SPEC{defsub} = {
    v       => 1.1,
    summary => 'Define a subroutine',
    description => <<'_',

This is just a shortcut to define subroutine and meta together so instead of:

    our %SPEC;
    $SPEC{foo} = {
        v => 1.1,
        summary => 'Blah ...',
    };
    sub foo {
        ...
    }

you write:

    defsub name=>'foo', summary=>'Blah ...',
        code=>sub {
            ...
        };

_
};
sub defsub(%) {
    my %args = @_;
    my $name = $args{name} or die "Please specify subroutine's name";
    my $code = $args{code} or die "Please specify subroutine's code";

    my $spec = {%args};
    delete $spec->{code};
    $spec->{v} //= 1.1;

    no strict 'refs';
    my ($callpkg, undef, undef) = caller;
    ${$callpkg . '::SPEC'}{$name} = $spec;
    *{$callpkg . "::$name"} = $code;
}

sub defvar {
}

sub defpkg {
}

sub defclass {
}

1;
# ABSTRACT:

=for Pod::Coverage (defvar|defpkg|defclass)

=head1 SYNOPSIS

 use Perinci::Easy qw(defsub);

 # define subroutine, with metadata
 defsub
     name        => 'myfunc',
     summary     => 'Does foo to bar',
     description => '...',
     args        => {
         ...
     },
     code        => sub {
         my %args = @_;
         ...
     };


=head1 DESCRIPTION

This module provides some easy shortcuts.


=head1 SEE ALSO

L<Perinci>
