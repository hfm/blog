---
layout: post
date: 2014-12-26 08:28:58 +0900
title: serverspec-snippetsにmergeしてもらったcommitいくつか
tags: 
- serverspec
- vim
---
serverspec-snippetsそのものについては以下をご参照ください．

- [Serverspecが超高速で書けるserverspec-snippetsを作った - Glide Note - グライドノート](http://blog.glidenote.com/blog/2014/06/17/serverspec-snippets/)
- [glidenote/serverspec-snippets](https://github.com/glidenote/serverspec-snippets)

serverspec-snippetsは仕事でガッツリ使っていて，今では手放せないVim pluginの1つです．
今日はなんとなく，そのプロダクトへのPRを紹介してみようと思います．
今のところ全部僕のPRです．

- https://github.com/glidenote/serverspec-snippets/pull/1
- https://github.com/glidenote/serverspec-snippets/pull/2
- https://github.com/glidenote/serverspec-snippets/pull/3

## [Serverspec v2 #1](https://github.com/glidenote/serverspec-snippets/pull/1)

Serverspec v2がリリースされた後に出したPRです．
新しく使えるようになったマッチャのsnippetsを追加しました．

v2ではいくつかのマッチャが廃止され，代わりのマッチャが追加されました．
この詳細は [Serverspec - Changes of Version 2](http://serverspec.org/changes-of-v2.html) の**Backward Incompatibility**に記されています．

ちなみに，v1を利用しているところもあると思うので，このPRではobsolatedなマッチャは削除していません．

## [Update service snippets #2](https://github.com/glidenote/serverspec-snippets/pull/2)

typo修正とserviceリソースの`be_running.under`に対する変更PRです．

元々snippetsがsupervisorの決め打ちになっていたんですが，[Serverspecでdaemontoolsのテストが可能になった](/2014/12/25/serverspec-daemontools/)他にも，upstartの利用も出来ますし，今後さらなる拡張もあり得るのでplaceholderに変えました．

## [Update user snippets #3](https://github.com/glidenote/serverspec-snippets/pull/3)

typo修正と，`user_resource`というuserリソース関係のexampleをバババッと並べるsnippetsを追加しました．
すでにある`file_resource`snippetsと同じような感じです．

ユーザを作成ときには，大体UIDやgroup, ホームディレクトリの有無，ログインシェル等もまとめて指定するので，それらを一括でペタッと貼り付けられるsnippetsがあると便利じゃないか！と思ったのがキッカケです．

## 終わりに

今後もServerspecやserverspec-snippetsにはガンガンPRしていくぞう．

__2014/12/27 20:27追記__

コラボレータに追加してもらいました！

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/hfm">@hfm</a> Collaboratorsに追加しておきました！いつもありがとう〜</p>&mdash; Akira MAEDA (@glidenote) <a href="https://twitter.com/glidenote/status/548323315878617088">2014, 12月 26</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
