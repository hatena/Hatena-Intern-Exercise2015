use strict;
use warnings;

use Test::More;

use_ok 'LogCounter';

use Parser;
use LogCounter;

my $parser = Parser->new( filename => '../sample_data/log.ltsv' );
my $counter = LogCounter->new($parser->parse);
is $counter->count_error, 2;
is_deeply $counter->group_by_user, {
    'john' => [
        {
            'epoch' => '1372794390',
            'req' => 'GET /apache_pb.gif HTTP/1.0',
            'status' => '200',
            'user' => 'john',
            'referer' => 'http://b.hatena.ne.jp/hotentry',
            'size' => '1234',
            'host' => '127.0.0.1'
        }
    ],
    'frank' => [
        {
            'epoch' => '1372694390',
            'req' => 'GET /apache_pb.gif HTTP/1.0',
            'status' => '200',
            'user' => 'frank',
            'referer' => 'http://www.hatena.ne.jp/',
            'size' => '2326',
            'host' => '127.0.0.1'
        },
        {
            'epoch' => '1372694390',
            'req' => 'GET /apache_pb.gif HTTP/1.0',
            'status' => '500',
            'user' => 'frank',
            'referer' => 'http://www.hatena.ne.jp/',
            'size' => '2326',
            'host' => '127.0.0.1'
        },
        {
            'epoch' => '1372794395',
            'req' => 'GET /notfound.gif HTTP/1.0',
            'status' => '404',
            'user' => 'frank',
            'size' => '100',
            'host' => '127.0.0.1'
        }
    ],
    'guest' => [
        {
            'epoch' => '1372894390',
            'req' => 'GET /apache_pb.gif HTTP/1.0',
            'status' => '503',
            'referer' => 'http://www.example.com/start.html',
            'size' => '9999',
            'host' => '127.0.0.1'
        }
    ]
};

done_testing();
