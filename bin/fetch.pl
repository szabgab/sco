use strict;
use warnings;

use Cwd qw(abs_path);
use File::Basename qw(dirname);

use lib 'lib';

use MetaCPAN::SCO::Fetch;
MetaCPAN::SCO::Fetch->run( dirname(dirname(abs_path(__FILE__))));

