"use strict";

QUnit.module("課題 JS-1");

QUnit.test("関数定義の確認", function () {
    QUnit.ok(typeof parseLTSVLog === "function", "`parseLTSVLog` という名前の関数がある");
});

QUnit.test("`parseLTSVLog` 関数の動作確認", function () {
    var logStr;
    var logRecords;

    logStr = "path:/\tepoch:500000\n";
    logRecords = parseLTSVLog(logStr);
    QUnit.deepEqual(logRecords, [
        { path: "/", epoch: 500000 }
    ], "1 行のみのログデータが期待通りパースされる");

    logStr =
        "path:/\tepoch:400000\n" +
        "path:/uname\tepoch:123456\n" +
        "path:/\tepoch:500000\n";
    logRecords = parseLTSVLog(logStr);
    QUnit.deepEqual(logRecords, [
        { path: "/",      epoch: 400000 },
        { path: "/uname", epoch: 123456 },
        { path: "/",      epoch: 500000 }
    ], "3 行からなるログデータが期待通りパースされる");

    logStr = "";
    logRecords = parseLTSVLog(logStr);
    QUnit.deepEqual(logRecords, [], "空文字列を渡したときは空の配列を返す");

    // テストを追加する場合は、この下に追加しても構いませんし、
    // `QUnit.test` 関数や `QUnit.asyncTest` 関数を用いて別に定義しても良いです。

});

QUnit.module("課題 JS-2");

QUnit.test("関数定義の確認", function () {
    QUnit.ok(typeof createLogTable === "function", "`createLogTable` という名前の関数がある");
});

QUnit.test("`createLogTable` 関数の動作確認", function () {
    // #qunit-fixture という要素は、QUnit が自動的に後片付けしてくれる要素
    var fixtureElem = document.getElementById("qunit-fixture");
    var elem = fixtureElem.appendChild(document.createElement("div"));

    createLogTable(elem, [
        { path: "/", epoch: 400000 },
        { path: "/uname", epoch: 123456 },
        { path: "/", epoch: 500000 },
    ]);

    QUnit.strictEqual(elem.childNodes.length, 1, "渡した要素に子ノードが 1 つ追加されている");
    var tableElem = elem.firstChild;
    QUnit.strictEqual(tableElem.tagName, "TABLE", "渡した要素に追加された子ノードは table 要素");

    QUnit.strictEqual(tableElem.childNodes.length, 2, "table 要素の子ノードは 2 個");
    var theadElem = tableElem.firstChild;
    QUnit.strictEqual(theadElem.tagName, "THEAD", "table 要素の 1 つ目の子ノードは thead 要素");
    QUnit.strictEqual(theadElem.childNodes.length, 1, "thead 要素の子ノードは 1 個");
    var tbodyElem = theadElem.nextSibling;
    QUnit.strictEqual(tbodyElem.tagName, "TBODY", "table 要素の 2 つ目の子ノードは tbody 要素");
    QUnit.strictEqual(tbodyElem.childNodes.length, 3, "tbody 要素の子ノードは 3 個");

    var expectedTrElem = document.createElement("tr");

    var actualTheadTrElem = theadElem.firstChild;
    expectedTrElem.innerHTML = "<th>path</th><th>epoch</th>";
    QUnit.ok(expectedTrElem.isEqualNode(actualTheadTrElem),
            "thead 要素の子要素の tr 要素の中身: " + expectedTrElem.innerHTML);

    var actualTbodyTrElem = tbodyElem.firstChild;
    expectedTrElem.innerHTML = "<td>/</td><td>400000</td>";
    QUnit.ok(expectedTrElem.isEqualNode(actualTbodyTrElem),
            "tbody 要素の子要素の 1 番目の tr 要素の中身: " + expectedTrElem.innerHTML);

    actualTbodyTrElem = actualTbodyTrElem.nextSibling;
    expectedTrElem.innerHTML = "<td>/uname</td><td>123456</td>";
    QUnit.ok(expectedTrElem.isEqualNode(actualTbodyTrElem),
            "tbody 要素の子要素の 2 番目の tr 要素の中身: " + expectedTrElem.innerHTML);

    actualTbodyTrElem = actualTbodyTrElem.nextSibling;
    expectedTrElem.innerHTML = "<td>/</td><td>500000</td>";
    QUnit.ok(expectedTrElem.isEqualNode(actualTbodyTrElem),
            "tbody 要素の子要素の 3 番目の tr 要素の中身: " + expectedTrElem.innerHTML);

    // テストを追加する場合は、この下に追加しても構いませんし、
    // `QUnit.test` 関数や `QUnit.asyncTest` 関数を用いて別に定義しても良いです。

});
