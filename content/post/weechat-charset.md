---
layout: post
date: 2015-02-01T20:51:36+09:00
title: Weechat 1.1.1がLC_CTYPEのせいで文字化けしたのを直した
tags:
- weechat
---
今年に入って，Weechatが1.1系にバージョンアップしていた[^1]ので，さくっとbrew upgradeしたら，急に文字化けしてしまった．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">Weechat 1.1.1にあげたら文字列が”????”だらけになってしまった． charset.default.encode がなぜかUS-ASCIIに．&#10;調べると <a href="https://t.co/CwHuxPAG2Q">https://t.co/CwHuxPAG2Q</a> に事例が．</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/561837850354667522">2015, 2月 1</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://t.co/jP0aNS7oOP">https://t.co/jP0aNS7oOP</a> の続き．&#10;<a href="https://twitter.com/search?q=%24LANG&amp;src=ctag">$LANG</a>=ja_JP.UTF-8 にしていたんだけど， <a href="https://twitter.com/search?q=%24LC&amp;src=ctag">$LC</a>_CTYPE=UTF-8 なのが原因だった．&#10;export LC_CTYPE=ja_JP.UTF-8 で解決した．</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/561838241867767808">2015, 2月 1</a></blockquote>

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
