---
layout: post
title: Graph::Easy => Graphvizを試してみた
date: 2014-01-13
tags: 
- perl
- graph
---
ペパボの先輩のブログから[Graph-Easy](http://search.cpan.org/~tels/Graph-Easy/)という便利ツールを知ったので自分も触ってみた。

 * [Graph-Easyで構成図(ブロック図)を描いてみる - テノニッキ (@hideack 's diary)](http://hideack.hatenablog.com/entry/2014/01/12/230627)
 * [Tels / Graph-Easy - search.cpan.org](http://search.cpan.org/~tels/Graph-Easy/)

## Graph-Easyの基本的な使い方

先輩のブログに書いてあるのだけれども、一応自分でも実行した内容を記載する。

### Macで入手

cpanmから以下のように入手可能。

```sh
$ cpanm Graph::Easy
```

### 入力

以下のような`graph.txt`を用意する。

```
[ local ] - ssh -> [ linux server ]
```

### 出力

`graph.txt`に対して`graph-easy`を実行する。

```sh
$ graph-easy graph.txt
```

すると以下のようなアスキーアートが出力される。

```
+-------+  ssh   +--------------+
| local | -----> | linux server |
+-------+        +--------------+
```

### 番外

ちなみに、以下のようにハイフンの数を増やすと、何故かちょっと崩れた感じになった。

```
Input:
[ local ] --- ssh ---> [ linux server ]

Output:
+-------+  ssh    +--------------+
| local | ..-..-> | linux server |
+-------+         +--------------+
```

## Graphvizで画像出力

ドキュメントを見てみると、なんと[Graphviz](http://www.graphviz.org/)のdot形式の入出力に対応しているらしい。

 * [Graphviz | Graphviz - Graph Visualization Software](http://www.graphviz.org/)

以下のように`--dot`あるいは`--as_dot`とオプションをつけるとdot形式のファイルが出力されるので、それをそのままdotコマンドに引き渡してsvg画像を出力してみた。

```sh
$ graph-easy graph.txt --dot | dot -Tsvg -o graph.svg
```

![](/images/2014/01/13/graph.svg)

これは便利。

txt形式で簡単にファイルを保存しておけば、あとはGraph-Easyを利用するだけでお手軽にアスキーアートや画像を出力できるようになる。

サーバ構成図のような、ちょっとしたドキュメント作成の時に使えるかもしれない。
