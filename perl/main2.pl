use strict;
use warnings;

use Data::Dumper;

use Parser;

my $parser = Parser->new( filename => '../sample_data/log.ltsv' );
warn Dumper $parser->parse;
