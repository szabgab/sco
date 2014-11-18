package MetaCPAN::SCO::Fetch;
use strict;
use warnings;

use LWP::Simple qw(get);
use JSON qw(to_json from_json);
use Path::Tiny qw(path);

sub run {
    my ($self, $root) = @_;

    my %totals;
    foreach my $name (qw(author distribution module)) {
        my $json = get "http://api.metacpan.org/v0/$name/_search?size=0";
        my $data = from_json $json;
        $totals{$name} = $data->{hits}{total};
    }
    


    path("$root/totals.json")->spew_utf8(to_json \%totals);
}

1;
