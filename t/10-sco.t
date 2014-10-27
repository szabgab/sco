use strict;
use warnings;

use Test::More;
use Test::WWW::Mechanize;

plan tests => 2;
my $w = Test::WWW::Mechanize->new;

my $url = 'http://search.cpan.org/';

subtest home => sub {
    $w->get_ok($url);
    $w->title_is('The CPAN Search Site - search.cpan.org');
    $w->submit_form_ok( {
        form_number => 1,
        fields => {
            query => 'sz',
            mode => 'author',
        },
       }, 'search for "sz" in authors');
    $w->content_contains('Arpad Szasz');
    $w->content_lacks('Szabo');
};

subtest authors => sub {
    $w->follow_link_ok( {text => 'Authors'}, 'Authors link');
    $w->title_is('The CPAN Search Site - search.cpan.org');
    $w->follow_link_ok( { text => 'A' });
    $w->content_contains('Andy Adler');
};

