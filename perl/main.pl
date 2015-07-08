use strict;
use warnings;

use Log;

my $log = Log->new(
    host    => '127.0.0.1',
    user    => 'frank',
    epoch   => '1372694390',
    req     => 'GET /apache_pb.gif HTTP/1.0',
    status  => '200',
    size    => '2326',
    referer => 'http://www.hatena.ne.jp/',
);
print $log->method . "\n";
print $log->path . "\n";
print $log->protocol . "\n";
print $log->uri . "\n";
print $log->time . "\n";
