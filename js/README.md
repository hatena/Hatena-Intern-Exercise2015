# JavaScript 課題

この課題は、JavaScript の基礎と簡単な DOM 操作 (DOM 操作とは、HTML 文書の構造などをプログラムで変更するもので、web 開発においては主にユーザーインターフェイスの動的な変更のために使用されます) の理解を確かめるものです。
JavaScript の処理系として [Node.js](http://nodejs.org/) なども存在しますが、ここでは
[Firefox](http://www.mozilla.jp/firefox/) や [Chrome](http://www.google.co.jp/intl/ja/chrome/browser/) といった最近のブラウザを使用するようにしてください。
(クロスブラウザについて考慮する必要はありません。 Firefox や Chrome といった最近のブラウザの最新バージョンで動作するようにしてください。)

## 基礎編

基礎課題 (課題 JS-3 まで) では、JavaScript を使って Web サーバーのアクセスログ (を模した文字列) を解析し、HTML ドキュメント上にアクセスログの表を表示する、という処理を実装していきます。
これらの課題の解答には、外部ライブラリを使用しないようにしてください。

### 課題 JS-0 (課題準備)

各自、自分が主に使用しているブラウザにおける開発者用のツールを使ってみてください。
Firefox や Chorome がおすすめですが、Opera や Internet Explorer (10 以降)、Safari といったブラウザでも大丈夫です。
多くの開発者用のツールでは、次のような機能があります。

* ページの HTML 文書構造を動的に表示する
* JavaScript 用のコンソールで JavaScript 実行時のエラーを確認する
* デバッガで JavaScript の処理を対話形式で進める
  * その際、スコープ内の変数の値を確認できる
* イベント発火に対してブレイクポイントを設定する

使いこなせるようになる必要はありませんが、少なくとも JavaScript のエラーが発生しているのかどうかを確認できるようになっていれば、課題を進めやすいと思います。

例として Firefox や Chrome に付属している Web 開発用のツールを紹介します。

* Firefox では、メニューバーの 「ツール」 中の 「Web 開発」 から、web 開発向けの便利なツールを開くことができます。
  * Web コンソール: [Web コンソール - Tools | MDN](https://developer.mozilla.org/ja/docs/Tools/Web_Console)
  * デバッガ: [デバッガ - Tools | MDN](https://developer.mozilla.org/ja/docs/Tools/Debugger)
  * また、Firefox 拡張機能として [Firebug](https://addons.mozilla.org/ja/firefox/addon/firebug/) というものもあります
* Chrome には、デベロッパー ツールという開発者向けのツールが付属しています。
  * [Chrome DevTools — Google Developers](https://developers.google.com/chrome-developer-tools/)
  * メニューバーの「表示」->「開発/管理」->「デベロッパーツール」など

### 課題 JS-1

Web サーバーへのアクセスログを表す LTSV 形式の文字列を引数として受け取り、その文字列をパースしてオブジェクトの配列にして返す関数 `parseLTSVLog` を `js/main.js` ファイルに記述してください。
アクセスログを表す LTSV 形式の文字列の例を次に示します。

注意) タブがスペースになっています。

```
path:/	epoch:200000
path:/bookmark	epoch:123456
```

1 行が 1 つのリクエストに対応しています。
1 行を 1 つの JavaScript のオブジェクトにし、アクセスログ中のラベルと値をプロパティとして持たせるようにしてください。
基本的に、アクセスログ中の値は文字列としてプロパティの値にすれば良いですが、`epoch` というラベルの値についてのみは数値にしてください。

すなわち、

```javascript
var logStr =
    "path:/\tepoch:200000\n" +
    "path:/help\tepoch:300000\n" +
    "path:/\tepoch:250000\n";
```

という文字列を引数として受け取り、

```javascript
[
  { path: "/",     epoch: 200000 },
  { path: "/help", epoch: 300000 },
  { path: "/",     epoch: 250000 },
]
```

という構造の配列を返すように `parseLTSVLog` 関数を実装してください。

実際のアクセスログには様々なデータが含まれますが、課題では簡単のため `path` というラベルと `epoch` というラベルのみを考慮すればよいものとします。
`path` というラベルの値には、URL として有効な文字列が与えられます。
`epoch` というラベルの値としては、整数値とみなせる文字列が与えられます。

課題で指定されていない仕様は、自由に決めてよいものとします。
例えば、引数が与えられずに関数が呼び出された場合は、例外を送出しても良いですし、空の配列を返すようにしても構いません。

なお、この関数のテストは、`js/test.html`、`js/test.js` に記述されています。
ブラウザで `js/test.html` を表示すると、自動的にテストが走るようになっています。
最低限、最初から書かれているテストに通過するように `parseLTSVLog` 関数を実装してください。
余裕があれば、最初から書かれているテストにさらにテストを追加してみてください。
(例えば、予期せぬ値が引数として渡された場合に関するテストなど。)
テスト用のフレームワークとして [QUnit](http://qunitjs.com/) を使用しています。

### 課題 JS-2

次の 2 つの値を引数として受け取り、

* 第 1 引数: `div` 要素を表す DOM オブジェクト
* 第 2 引数: 課題 JS-1 で作成した関数 `parseLTSVLog` の返り値と同じ形式の配列

次のような表を (DOM 操作によって) 第 1 引数の `div` 要素の直下に生成する関数 `createLogTable` を js/main.js ファイルに記述してください。

```html
<table>
  <thead><tr><th>path</th><th>epoch</th></tr></thead>
  <tbody>
    <tr><td>/</td><td>200000</td></tr>
    <tr><td>/help</td><td>300000</td></tr>
    <tr><td>/</td><td>250000</td></tr>
  </tbody>
</table>
```

`tbody` 要素内の `tr` 要素は、引数として受け取った配列の各要素に対応します。
表は 2 カラムにして、最初のカラムには `path` の値を、次のカラムには `epoch` の値を表示するようにしてください。

また、引数として受け取った配列の最初の要素から順に、表の上から表示するようにしてください。

```javascript
// `createLogTable` 関数の使用例
var containerElem = document.getElementById("table-container"); // table-container という ID の div 要素が HTML ドキュメント中にあるとする
createLogTable(containerElem, [
    { path: "/",     epoch: 200000 },
    { path: "/help", epoch: 300000 },
    { path: "/",     epoch: 250000 }
]);
```

課題 JS-1 と同じく、この関数のテストも `js/test.html`、`js/test.js` に記述されています。
最低限、最初から書かれているテストを通過するように実装し、余裕があれば新たにテストを追加してみてください。

参考になりそうな MDN (Mozilla Developer Network) のページを以下に挙げておきます。
(ここで紹介しているメソッド以外を使用しても構いません。)

* ノードに子ノードを追加: [Node.appendChild - Web API リファレンス | MDN](https://developer.mozilla.org/ja/docs/Web/API/Node.appendChild)
* Element ノードの生成: [document.createElement - Web API リファレンス | MDN](https://developer.mozilla.org/ja/docs/Web/API/document.createElement)
* ノードの子孫のテキストを設定したり読み取ったりする: [Node.textContent - Web API リファレンス | MDN](https://developer.mozilla.org/ja/docs/Web/API/Node.textContent)

### 課題 JS-3

課題 JS-1 と JS-2 で作成した関数を用いて、`js/js-3.html` のページが次のような動作をするように `js/js-3.js` に JavaScript の処理を記述しなさい。
`js/main.js` には課題 JS-1 と JS-2 で作成した関数が記述されているものとします。

* `js/js-3.html` の動作: ユーザーが `textarea` 要素に LTSV 形式のアクセスログを入力し、「表に出力する」 ボタンをクリックすると、`access-log-table-container` という `id` 属性をもつ要素の直下にアクセスログの表を表す `table` 要素が作られる。

`js/js-3.html` の中身は次のとおりです。

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Hatena-Intern-Exercise : JavaScript</title>
  <link rel="stylesheet" href="js-3.css" />
</head>
<body>
  <section>
    <h1>JavaScript 事前課題</h1>
    <h2>課題 JS-3 : イベントリスナを使用する</h2>
    <p>「表に出力する」 ボタンをクリックすると、テキストエリアに入力したログデータが表として表示されるようにしてください。 その際、課題 JS-1 と JS-2 で作成した関数を使用してください。</p>
    <p>また、表 (table 要素) は table-container を id として持つ div 要素の子要素として作成するようにしてください。</p>
    <div>
      <textarea id="log-input" cols="64" rows="10">path:/&#x0009;epoch:123456
path:/uname&#x0009;epoch:500000
path:/help&#x0009;epoch:234222
path:/&#x0009;epoch:94843
</textarea>
      <div><input value="表に出力する" type="button" id="submit-button" /></div>
    </div>
    <div id="table-container"></div>
  </section>
  <script src="main.js"></script>
  <script src="js-3.js"></script>
</body>
</html>
```

参考になりそうな MDN のページを以下に挙げておきます。
(ここで紹介しているメソッド以外を使用しても構いません。)

* id を指定して文書中の Element ノードを取得: [document.getElementById - Web API リファレンス | MDN](https://developer.mozilla.org/ja/docs/Web/API/document.getElementById)
* イベントリスナを追加: [EventTarget.addEventListener - Web API リファレンス | MDN](https://developer.mozilla.org/ja/docs/Web/API/EventTarget.addEventListener)

## 応用編

### 課題 JS-4

課題 JS-3 で作成したものに、ログの検索機能を実装してください。

例えば、以下の様な機能が考えられます。
- `path` を検索できる機能。例えば `bookmark` と入力して「検索」ボタンを押すと、`path` の `uri` に `bookmark` が含まれるログが表示される
- `POST`のログしか表示しない機能
- 2つ以上の条件を組み合わせて検索できる機能
- インクリメンタルサーチする機能

どのような検索機能を実装するか、どのような UI を作るかは全て自由とします。複数の機能を作ってもらっても構いません。またこの課題では好きな JavaScript ライブラリを使って構いません。ただし検索機能は自分で実装するようにして下さい。(= 検索機能を提供するライブラリの利用は禁止します。) 特にこだわりがなければ、jQuery や Underscore.js などのユーティリティを使うようにして下さい。

この課題のための HTML ファイルや JS ファイルは、新たに作成してください (ファイル名は特に指定しませんが、js/js-4.html や js/js-4.js など、わかりやすい名前にしてください)。
また、この課題で使うログデータは `../sample_data/log.ltsv` (または `large_log.ltsv` )にあるデータを `<textarea>` に入れて利用するようにしてください。実行の度に貼り付けても良いし、予めDOMに埋め込んでおいても構いません。
