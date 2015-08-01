---
layout: post
title: ttygif最高だ！
date: 2014-07-19
tags:
- gif
---
社内やブログ等で技術的なTipsを共有する時にGifアニメーションを使うことがある。
具体的には、Percol/Pecoの操作感を伝える時に、アニメは非常に効果的だ。

しかし、Gifzo[^1]はターミナルの操作を伝えるのに十分な使い勝手とは言い難い。
App StoreにあったGifGrabber[^2]はまだ少し良かったが、時間制限が厳しかった。
どちらのツールにも言えることだが、そもそもアクティブウィンドウの切り替えが面倒だ(ツールを使いこなしていないだけで、もっと楽な方法があったのだろうか)。

そんな時にttygif[^3]に出会った。

[ターミナル操作の録画からGIFアニメを生成するツールを作った - すぎゃーんメモ](http://d.hatena.ne.jp/sugyan/20140719/1405729672)[^4] の「背景」の節にモチベーションが紹介されている。
最高だと思う。

## How to use

OSXで使用する場合はhomebrewから`ttyrec`をインストールする必要がある。

```sh
brew install ttyrec
```

ttygifはこのttyrecの後に実行する。

まず録画方法だが、これは`ttyrec`コマンドを実行だけでよい。
録画の終了時に`exit`を実行する。

そして次に`ttygif`コマンドを実行すればよい。
あとは自動的に録画した情報がGifアニメに変換される。

```sh
# 録画開始
ttyrec
any command
any command
any command
# 録画終了
exit
# Gifアニメ書き出し
ttygif
```

`ttygif --help`でオプションが見れるので、fpsとかを調整したい場合は参照するといい。

素晴らしいツールに出会えて大変嬉しくなったので、祝福のビール[^5]を降らしてみた。

![happy beer](/images/2014/07/19/ttygif.gif)

Happy GIF Animation Life!

[^1]: [Gifzo - 宇宙一簡単なスクリーンキャスト共有](http://gifzo.net/)
[^2]: [GifGrabber - Make Animated Gifs from Video](http://www.gifgrabber.com/)
[^3]: [sugyan/ttygif](https://github.com/sugyan/ttygif)
[^4]: [ターミナル操作の録画からGIFアニメを生成するツールを作った - すぎゃーんメモ](http://d.hatena.ne.jp/sugyan/20140719/1405729672)
[^5]: [Macのターミナルでビールが降る | SOTA](http://deeeet.com/writing/2014/04/30/beer-on-terminal/)
