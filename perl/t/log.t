use strict;
use warnings;

use Test::More;

use_ok 'Log';

my $log = Log->new(
    host    => '127.0.0.1',
    user    => 'frank',
    epoch   => '1372694390',
    req     => 'GET /apache_pb.gif HTTP/1.0',
    status  => '200',
    size    => '2326',
    referer => 'http://www.hatena.ne.jp/',
);
is $log->method, 'GET';
is $log->path, '/apache_pb.gif';
is $log->protocol, 'HTTP/1.0';
is $log->uri, 'http://127.0.0.1/apache_pb.gif';
is $log->time, '2013-07-01T15:59:50';

done_testing();
