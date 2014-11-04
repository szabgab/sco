package MetaCPAN::SCO;
use strict;
use warnings;

our $VERSION = '0.01';

use Plack::Request;

=head1 NAME

MetaCPAN::SCO - search.cpan.org clone

=cut

sub run {
    return sub {
        my $env = shift;

        my $request = Plack::Request->new($env);
        if ($request->path_info eq '/') {
            return [ 200, [ 'Content-Type' => 'text/plain' ], ['Hello'] ];
        }
        return [ 404, [ 'Content-Type' => 'text/html' ], ['404 Not Found'] ];

    };
}

1;

