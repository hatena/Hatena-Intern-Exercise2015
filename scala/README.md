# Scala 課題

### 準備編(sbtの簡単な使い方)

この課題では [sbt](http://www.scala-sbt.org/) を使用します。お手元の環境にinstallしてください。brewが利用できる環境であれば、`brew install sbt` で手軽にinstallできます。

以下この課題で必要だと思われるsbtの簡単な使い方を説明します。

#### sbtの設定

Scala課題用のsbtの設定がすでにセットアップされています。

`scala/project/Build.scala` に設定が記述されているので、使いたいライブラリなどがあればここに追記しても構いません。

#### sbtの起動

sbtの起動は本READMEが置いてあるディレクトリで`sbt`と打つと実行できます。

#### コンパイル

ソースコードをコンパイルするにはsbtを起動し、`compile` と打つと実行されます。

このとき、テストコードはコンパイルされません。テストコードも含めてコンパイルする場合は、`test:compile`としてください。

#### テストの実行

本課題では、実装の結果はすべてテストにより確認する必要があります。テストの実行は、sbtを起動し、`test`と打ってください。すべてのテストが実行されます。

ある特定のテストのみ実行する場合は`testOnly`を使います。例えば、課題1のテストを実行する場合は `testOnly hatena.intern.exercise1.Exercise1Spec` となります。

この課題では、テスティングフレームワークは[ScalaTest](http://www.scalatest.org/)を使っています。

#### コンソールでの動作確認

課題の実装中、自分の書いたメソッドを実際に動かして確認したい場合はsbt consoleを使います。

sbt起動時に、`console` と打ってください。sbt上でScalaの[REPL](http://www.ne.jp/asahi/hishidama/home/tech/scala/scala.html)が起動し、自分が定義したクラスやメソッドを実行できます。

例えば、課題1のLogクラスのメソッドを呼びたい場合は以下のようになります。

```
scala> import hatena.intern._
import hatena.intern._

scala> val log = Log(
     |     host    = "127.0.0.1",
     |     user    = "frank",
     |     epoch   = 1372694390,
     |     req     = "GET /apache_pb.gif HTTP/1.0",
     |     status  = 200,
     |     size    = 2326,
     |     referer = "http://www.hatena.ne.jp/"
     | )
log: hatena.intern.Log = Log(127.0.0.1,frank,1372694390,GET /apache_pb.gif HTTP/1.0,200,2326,http://www.hatena.ne.jp/)

scala> log.method
```

consoleを終了してsbtに戻る場合は`ctrl+D`で戻ります。

### 課題 Scala-1

["はじめに"の項](../README.md)にあった LTSV の1レコードを表す Log クラスを実装して下さい。

Log クラスは以下のメソッドを持ちます。
* `req` の値に含まれている HTTP メソッド名を返す `method` メソッド
* `req` の値に含まれているリクエストパスを返す `path` メソッド
* `req` の値に含まれているプロトコル名を返す `protocol` メソッド
* `host` と `req` の値からリクエストされた uri を組み立てて返す `uri` メソッド
* `epoch` が表している時刻を `YYYY-MM-DDThh:mm:ss` というフォーマットの文字列に変換して返す `time` メソッド
    * 日付を扱うモジュールを用いてかまいません
    * タイムゾーンは GMT として下さい

できあがったクラスは以下のように実行できます。


```scala
val log = Log(
    host    = "127.0.0.1",
    user    = "frank",
    epoch   = 1372694390,
    req     = "GET /apache_pb.gif HTTP/1.0",
    status  = 200,
    size    = 2326,
    referer = "http://www.hatena.ne.jp/"
)

println(log.method)
println(log.path)
println(log.protocol)
println(log.uri)
println(log.time)
```

* 出力

```
GET
/apache_pb.gif
HTTP/1.0
http://127.0.0.1/apache_pb.gif
2013-07-01T15:59:50
```

実装は`src/main/scala/hatena/intern/Exercise1.scala`で行ってください。クラスの雛形があらかじめ用意されていますが、この形式に合わせなくてもかまいません。sbt上で以下のようにテストを実行して、課題が正しく動作していることを確認してください。

```
scala> testOnly hatena.intern.Exercise1Spec
```


### 課題 Scala-2

["はじめに"の項](../README.md)にあった LTSV フォーマットのログファイルを読み込み、以下のLog オブジェクトの配列を返すパーザーを LtsvParser オブジェクトとして実装してください

ファイルはリポジトリ内の`sample_data/log.ltsv`を読み込んでください。

ファイル読み込みには Build.scala でScala IOを使えるようにしていますが、他のライブラリを使っても構いません


実装に関しては、以下の条件を守って下さい。

* LTSV をパースするライブラリを用いないこと
* 今回のログでは、userとrefererに値がない場合に、"-"がセットされます。この２つの項目をOption[String]に変更し、ログの中身が"-"だった場合はNoneになるように変更してください。また、それにあわせて課題-1のテストも修正してください。
* LTSVの各項目は必ず同じ順番で並んでいるとは限りません。それぞれの項目がどの順番で並んでいてもパースできるように実装してください。

実装は`src/main/scala/hatena/intern/Exercise2.scala`で行ってください。クラスの雛形があらかじめ用意されていますが、この形式に合わせなくてもかまいません。 以下のようにsbtでテストを実行して正しく動作していることを確認して下さい。

```
scala> testOnly hatena.intern.Exercise2Spec
```

また、このテストは十分ではないため、`src/test/scala/hatena/intern/Exercise2.scala`を変更してテストを追加してみてください(コード内に指示があります)。


### 課題 Scala-3

Log を集計する LogCounter クラスを実装して下さい
LogCounter は、HTTP サーバーエラー (500番台) の数を数える `countError` とユーザーごとにログをまとめる `groupByUser` メソッドを持ちます。


* user の値がない(値が `-` である)場合は `guest` という名前にして集計して下さい
* いろいろな集計処理が考えられます。余裕があれば自分で考えて実装し、テストも追加してみて下さい。

実装は`src/main/scala/hatena/intern/Exercise3.scala`で行ってください。 以下のようにsbtでテストを実行して正しく動作していることを確認して下さい。

```
scala> testOnly hatena.intern.Exercise3Spec
```

ここまでの課題と同様に`src/test/scala/hatena/intern/Exercise3.scala`を変更してテストを追加してみてください。クラスの雛形があらかじめ用意されていますが、この形式に合わせなくてもかまいません。


## 応用編 Scala-4

課題 Scala-3 までで作った LTSV パーザーを用いてこれまでに使ったデータより大きなデータから可視化を行い、標準出力にダイアグラム (グラフ) を出力してください。

サンプルデータは `sample_data/large_log.ltsv` にあるのでこれを利用してください。

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
