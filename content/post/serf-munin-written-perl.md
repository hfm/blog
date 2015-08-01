---
title: Perl版serf-muninを書いた
date: 2014-08-11
tags:
- serf
- perl
---
zenbutsuさんのserf-munin[^1][^2]，glidenote先生の改造版[^3]があり，3番煎じは流石の薄味ですが，Perlでserf-muninのイベントハンドラを書いてみました．

- https://github.com/tacahilo/serf-munin.pl

実はまともにperlのスクリプトを書くのはこれが2回目です．1回目は1.5年くらい前に書いた雑過ぎる席替えスクリプト[^4]です．
あと，こちらのserf-munin.plは30days Album[^5]のバックエンドでひっそりと動いてもらっています．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">おっくんのおかげで30daysにserfが入った。/ serfの基本的な動作を試してみた | blog: takahiro okumura <a href="http://t.co/VHxWdcVaEO">http://t.co/VHxWdcVaEO</a></p>&mdash; kuroda (@lamanotrama) <a href="https://twitter.com/lamanotrama/status/491827063343415298">2014, 7月 23</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

基本的な動作はzenbutsuさん，glidenote先生のものと同じですが，若干の仕様変更を加えています．
設定方法そのものは公式ドキュメントをご参考ください．

- http://www.serfdom.io/docs/agent/basics.html

## `$role`じゃなくて`munin_group`という`$tags`を使う

`$tags`の中に`munin_group`というタグを用意し，そこにmuninのグループ名を登録するようにしています．  
例えば次のように，`munin_group=application`というタグを設定します．

```json
{
 "tags": {
   "munin_group": "app"
 }
}
```

すると次のように，名前，アドレス，ロール，タグが`\t`区切りで，標準入力からイベントハンドラに渡されてくるので，これをmuninのグループ名としています．  
（ロール未指定の場合，`<role>`の中身は空っぽで渡されてくる．）

```sh
<name>    <address>       <role>   <tags>
foo.com   192.168.100.1            munin_group=app
```

AWSのようなクラウド前提だと`$role`でも良いような気もするのですが，オンプレだと中々そうもいかず，ロールからは独立したmunin-nodeグループタグを用意することにしました．

## munin-nodeのconfigファイルを生成・削除するタイミングの変更

### `member-update`でもconfigファイルを再生成する

これは単純に，サーバのリプレイス等が発生してIPアドレスが変わる可能性があるからです（言っても，ほぼほぼ無いケースですが）．

### `member-failed`でmuninのconfifファイルを削除しない

一時的な負荷等で障害が発生した時は，serf同士の通信もうまく行かずにfailedしてしまいます．

その時にserf-muninが`member-failed`の通知を受け取ってconfigファイルを削除してしまうと，しばらくしてmuninから該当サーバの項目が削除されてしまいます．
障害発生前のサーバの様子も確認したいので，明示的にサーバから離れる`member-leave`の時だけconfigファイルを削除するようにしています．

それ以外の挙動は同じです．よいserf x muninライフを！

[^1]: [serf-muninでmunin-nodeの監視自動追加/削除 | Pocketstudio.jp log3](http://pocketstudio.jp/log3/2013/11/01/serf-munin-eventhander-auto-monitorin/)
[^2]: https://github.com/zembutsu/serf-munin
[^3]: [serf-muninを導入してmunin-nodeの監視追加、削除を自動化した - Glide Note - グライドノート](http://blog.glidenote.com/blog/2013/11/06/serf-munin/)
[^4]: [ペパボ新卒３期生エンジニア研修，席替えスクリプトの思い出 | blog: takahiro okumura](/2014/08/10/sekigae-scripts/)
[^5]: http://30d.jp/
