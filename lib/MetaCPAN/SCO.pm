package MetaCPAN::SCO;
use strict;
use warnings;

our $VERSION = '0.01';

use Plack::Request;
use Plack::Builder;
use Template;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

=head1 NAME

MetaCPAN::SCO - search.cpan.org clone

=cut

sub run {
    my $app = sub {
        my $env = shift;

        my $request = Plack::Request->new($env);
        if ($request->path_info eq '/') {
            return template('index');
        }
        return [ 404, [ 'Content-Type' => 'text/html' ], ['404 Not Found'] ];

    };

    my $root = root();

    builder {
        enable 'Plack::Middleware::Static',
            path => qr{^/(favicon.ico|robots.txt)},
            root => "$root/static/";
        $app;
    }
}

sub root {
    return dirname(dirname(dirname(abs_path(__FILE__))));
}

sub template {
    my ($file) = @_;


    my $root = root();

    my $tt = Template->new(
        INCLUDE_PATH => "$root/tt",
        INTERPOLATE  => 0,
        POST_CHOMP   => 1,
        EVAL_PERL    => 0,
        START_TAG    => '<%',
        END_TAG      => '%>',
        PRE_PROCESS  => 'incl/header.tt',
        POST_PROCESS => 'incl/footer.tt',
    );

    my $out;
    $tt->process( "$file.tt", {}, \$out) || die $tt->error();

    return [ 200, [ 'Content-Type' => 'text/html' ], [$out] ];
}

1;

