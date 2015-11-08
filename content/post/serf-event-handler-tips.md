---
title: serfのイベントハンドラを書く時にハマったこと
date: 2014-08-11
tags:
- serf
---
serf-munin.pl[^1]を書いた時にハマったこと。

## 複数タグを登録すると、カンマ区切りの`key=value`になる

[serfの基本的な動作を試してみた](/2014/07/23/try-serf-clustering/)時に知ったことです。
これはドキュメントにもそれとなく書いてあるので、ハマるという程のことは無かったのですが、なんとも言えない挙動があるのでメモしておきます。

例えば以下のように、`role=app`と`datacenter=tokyo`という2つのタグを設定します。

```json
{
 "tags": {
   "role": "app",
   "datacenter": "tokyo"
 }
}
```

すると、serfは1つのイベントハンドラ発行時に、次のようなタブ区切りの一行を標準入力に送ります。

```sh
foo.com   192.168.100.1   app    role=app,datacenter=tokyo
```

`$tags`をパースしたい場合は、

1. 標準入力から得たフィールドを`\t`で区切り、4番目の値を取得する
1. カンマ`,`でsplitして、`key=value`が入った配列を取得する
1. イコール`=`で区切り、ハッシュを取得する (`$tags{'role'} = app`と`$tags{'datacenter'} = tokyo`)

のような手順が必要です（イベントハンドラの目的が単一的であれば、ハッシュの取得は不要かも）。

### tagsの並び順の罠

ここで注意したいのは、__必ずしも`$tags`の並び順は固定ではないこと__ です。
`role=app,datecenter=tokyo`だったり`datecenter=tokyo,role=app`だったり、alphabeticalでもなく、ランダムっぽい挙動です（`serf members`コマンドを打つ度に結果が変わる。）

## 複数のイベントが一度に発行されると、複数行にわたって情報がイベントハンドラに渡される

複数のserfからイベントを発行すると、serfはイベントハンドラ[^2]に対して __複数行でメンバの情報を送ります__ 。
送り先は標準入力です。

```sh
foo.com   192.168.100.1   app    role=app
bar.com   192.168.100.2   db     role=db
baz.com   192.168.100.3   mail   role=mail
```

なので、serfからmember-joinやmember-leave等の情報が送られてきた際に、取りこぼしの無いようにメンバの情報を取得するには、例えば以下のような処理が必要です。

```perl
# 複数行にわたって送られる可能性があるのでwhileでぐるぐる回す
while (<STDIN>) {
   chomp;

   # 各フィールドはタブ区切り
   my @member_fields = split("\t", $_);

   # ちゃんと4つのフィールドに別れてないと駄目（必須では無いけどバリデーションしておいた方が良いと思う）
   die "fields must include 4 elements" unless @member_fields == 4;

   # name, address, role, tagsの順で用意されてる
   my ($name, $address, $role, $tags) = @member_fields;

   # 以降、処理が続く
   ...
}
```

最初、イベントハンドラは各イベントに対して毎回呼び出されるものと思い込んでいたのですが、どうやらバッファリングしているらしく、同時多発的にイベントが発行された場合はイベント情報を複数行で送る実装になっているようです（ちゃんと実装を読んでいないので、半分くらいは想像ですが。）

- https://github.com/hashicorp/serf/blob/master/serf/config.go

[^1]: [Perl版serf-muninを書いた | blog: takahiro okumura](/2014/08/11/serf-munin-written-perl/)
[^2]: http://www.serfdom.io/docs/agent/event-handlers.html
