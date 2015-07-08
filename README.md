Hatena-Intern-Exercise
========================================

基本的な教材は Hatena::Textbook など

- [Perl 課題](./perl/)
- [Scala 課題](./scala/)
- [JavaScript 課題](./js/)

## はじめに

※この項は全課題共通になります。はじめに目を通しておきましょう。

LTSV (Labeled Tab-separated Values) とはラベル付きのTSVフォーマットです。
LTSVの1レコードは、`label:value` という形式で表されたラベル付きの値がタブ文字区切りで並びます。

以下に LTSV の例を示します。

* `sample_data/ltsv.log`

```
host:127.0.0.1	user:frank	epoch:1372694390	req:GET /apache_pb.gif HTTP/1.0	status:200	size:2326	referer:http://www.hatena.ne.jp/
host:127.0.0.1	user:john	epoch:1372794390	req:GET /apache_pb.gif HTTP/1.0	status:200	size:1234	referer:http://b.hatena.ne.jp/hotentry
host:127.0.0.1	user:-	epoch:1372894390	req:GET /apache_pb.gif HTTP/1.0	status:503	size:9999	referer:http://www.example.com/start.html
host:127.0.0.1	user:frank	epoch:1372694390	req:GET /apache_pb.gif HTTP/1.0	status:500	size:2326	referer:http://www.hatena.ne.jp/
host:127.0.0.1	user:frank	epoch:1372794395	req:GET /notfound.gif HTTP/1.0	status:404	size:100  referer:-
```

例えば、1レコード目の host の値は 127.0.0.1 であり、2レコード目の referer の値は http://b.hatena.ne.jp/hotentry になります。LTSV についてより詳しくは、以下を参照して下さい。

* http://blog.stanaka.org/entry/2013/02/05/214833
* http://ltsv.org/

## 課題の提出方法について

課題の提出は、このリポジトリをForkしてそこにコミットしていってください。

課題はそれぞれ複数問あるので、問題ごとにコミットを分けてください（すべての回答を一つのコミットにまとめないようにお願いします）。コミットの粒度は1問1コミットでなくても、細かくコミットしていて構いません。
