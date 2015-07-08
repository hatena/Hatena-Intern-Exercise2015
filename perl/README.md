Hatena-Intern-Exercise
========================================

以下基本的な教材は Hatena::Textbook など

# Perl 課題

## 課題 Perl-1

["はじめに"の項](../README.md)にあった LTSV の1レコードを表す Log クラスを実装して下さい。
(Perl のオブジェクト指向については Hatena::Textbook などを参考にして下さい。)

Log クラスは以下のメソッドを持ちます。
* `req` の値に含まれている HTTP メソッド名を返す `method` メソッド
* `req` の値に含まれているリクエストパスを返す `path` メソッド
* `req` の値に含まれているプロトコル名を返す `protocol` メソッド
* `host` と `req` の値からリクエストされた uri を組み立てて返す `uri` メソッド
* `epoch` が表している時刻を `YYYY-MM-DDThh:mm:ss` というフォーマットの文字列に変換して返す `time` メソッド
    * 日付を扱うモジュールを用いてかまいません
    * タイムゾーンは GMT として下さい


* main.pl

```perl
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
```

```shell
$ perl -Ilib main.pl
```

* 出力

```perl
$ perl -Ilib main.pl
GET
/apache_pb.gif
HTTP/1.0
http://127.0.0.1/apache_pb.gif
2013-07-01T15:59:50
```

また、後述するリポジトリに含まれているテストを実行して、課題が正しく動作していることを確認してください。

```shell
$ prove -lvr t/log.t
(中略)
Result: PASS
```

* Perl のテストの実行に関して、詳しくは [Hatena-Textbook](https://github.com/hatena/Hatena-Textbook/blob/master/oop-for-perl.md#-58) を参照して下さい。

## 課題 Perl-2

["はじめに"の項](../README.md)にあった LTSV フォーマットのログファイルを読み込み、以下のLog オブジェクトの配列を返すパーザーを Parser クラスとして実装してください

* main2.pl

```perl
use strict;
use warnings;

use Data::Dumper;

use Parser;

my $parser = Parser->new( filename => '../sample_data/log.ltsv' );
warn Dumper $parser->parse;
```

```shell
$ perl -Ilib main2.pl
```

* 出力フォーマット

```perl
$VAR1 = [
          bless( {
                   'epoch' => '1372694390',
                   'req' => 'GET /apache_pb.gif HTTP/1.0',
                   'status' => '200',
                   'user' => 'frank',
                   'referer' => 'http://www.hatena.ne.jp/',
                   'size' => '2326',
                   'host' => '127.0.0.1'
                 }, 'Log' ),
          ...
        ];
```

実装に関しては、以下の条件を守って下さい。

* LTSV をパースするCPANモジュールを用いないこと
* LTSVでは値が定義されていない場合は`host:-`のように値に`-`が入ります。値が定義されていなかった場合には、そのラベルをハッシュリファレンスに含めないようにして下さい
* map や grep といった関数を積極的に利用するとよいでしょう (必須ではない)


課題 Perl-1 と同じように、テストを実行して正しく動作していることを確認して下さい


* Perl でファイルを読み込む方法はいろいろあって混乱しやすいため、以下にサンプルコードを載せておきます

```perl
open my $fh, '<', 'log.ltsv' or die $!;
my $line = <$fh>; # スカラーコンテキストなので一行読み込む
my @lines = <$fh>; # リストコンテキストなので(残りの)すべての行を配列として読み込む
print $line;
print "----\n";
print @lines;
```

## 課題 Perl-3

Log を集計する LogCounter クラスを実装して下さい
LogCounter は、HTTP サーバーエラー (500番台) の数を数える `count_error` とユーザーごとにログをまとめる `group_by_user` メソッドを持ちます。

* main3.pl

```perl
my $parser = Parser->new( filename => '../sample_data/log.ltsv' );
my $counter = LogCounter->new($parser->parse);
print 'total error size: ' . $counter->count_error . "\n";
print Dumper $counter->group_by_user;
```

```shell
$ perl -Ilib main3.pl
```

* 出力

```perl
$VAR1 = {
          'guest' => [
                       bless( {
                                'epoch' => '1372894390',
                                'req' => 'GET /apache_pb.gif HTTP/1.0',
                                'status' => '503',
                                'referer' => 'http://www.example.com/start.html',
                                'size' => '9999',
                                'host' => '127.0.0.1'
                              }, 'Log' )
                     ],
          'frank' => [
                       bless( {
                                'epoch' => '1372694390',
                                'req' => 'GET /apache_pb.gif HTTP/1.0',
                                'status' => '200',
                                'user' => 'frank',
                                'referer' => 'http://www.hatena.ne.jp/',
                                'size' => '2326',
                                'host' => '127.0.0.1'
                              }, 'Log' ),
                       ...
                     ],
          ...
        };
```

* List::Util や List::UtilsBy といった便利なモジュールがありますが、今回は利用せずに実装してみましょう
* user の値がない(値が `-` である)場合は `guest` という名前にして集計して下さい
* いろいろな集計処理が考えられます。余裕があれば自分で考えて実装し、テストも追加してみて下さい。



## 課題 Perl-4 (応用編)

課題 Perl-3 までで作った LTSV パーザーを用いてこれまでに使ったデータより大きなデータから可視化を行い、標準出力にダイアグラム (グラフ) を出力してください。

サンプルデータは `../sample_data/large_log.ltsv` にあるのでこれを利用してください。

様々なデータの可視化が考えられます。

例:

* 日毎のリクエスト URI の分布
* リクエスト URI 毎のステータスコード (`status`) の分布

ダイアグラムの例:

```
/
---:        100       200
200:=================*
403:==*
404:===*
500:=*

/bookmark
---:        100       200
200:=================*
403:==*
404:=======*
500:===*
```

上記の例に限らず、自由に可視化の対象・方法を考えてみてください。
