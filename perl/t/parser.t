use strict;
use warnings;

use Test::More;

use_ok 'Parser';

my $parser = Parser->new( filename => '../sample_data/log.ltsv' );
isa_ok $parser, 'Parser';

my $parsed = $parser->parse;

isa_ok $parsed->[0], 'Log';
isa_ok $parsed->[1], 'Log';
isa_ok $parsed->[2], 'Log';

is_deeply $parsed->[0]->to_hash, {
    'status' => '200',
    'time' => '2013-07-01T15:59:50',
    'size' => '2326',
    'uri' => 'http://127.0.0.1/apache_pb.gif',
    'user' => 'frank',
    'method' => 'GET',
    'referer' => 'http://www.hatena.ne.jp/'
};
is_deeply $parsed->[1]->to_hash, {
    'status' => '200',
    'time' => '2013-07-02T19:46:30',
    'size' => '1234',
    'uri' => 'http://127.0.0.1/apache_pb.gif',
    'user' => 'john',
    'method' => 'GET',
    'referer' => 'http://b.hatena.ne.jp/hotentry'
};
is_deeply $parsed->[2]->to_hash, {
    'status' => '503',
    'time' => '2013-07-03T23:33:10',
    'method' => 'GET',
    'referer' => 'http://www.example.com/start.html',
    'size' => '9999',
    'uri' => 'http://127.0.0.1/apache_pb.gif'
};

done_testing();
