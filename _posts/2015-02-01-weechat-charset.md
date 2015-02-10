---
layout: post
date: 2015-02-01 20:51:36 +0900
title: Weechat 1.1.1がLC_CTYPEのせいで文字化けしたのを直した
tags:
- weechat
---
今年に入って，Weechatが1.1系にバージョンアップしていた[^1]ので，さくっとbrew upgradeしたら，急に文字化けしてしまった．

{% tweet https://twitter.com/hfm/status/561837850354667522 %}

{% tweet https://twitter.com/hfm/status/561838241867767808 %}

自分のzshenvを覗いてみたら，`LANG`だけ設定してあったので，`LC_CTYPE`も同様に設定しておいた[^2]．

```sh
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
```

この手の文字化けは，疑うべき箇所が散らばってる印象がある．
ターミナルアプリの設定ファイルなのか，localeなのか，あるいはアプリケーションの文字セットなのか．
今回はlocaleだったのでそこを直せば良かったんだけど，アレコレ試して時間がかかってしまった．

[^1]: https://weechat.org/files/changelog/ChangeLog-1.1.1.html
[^2]: [The GNU C Library: Locale Categories](https://www.gnu.org/savannah-checkouts/gnu/libc/manual/html_node/Locale-Categories.html)
