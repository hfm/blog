---
date: 2016-09-19T09:29:11+09:00
title: 『みんなのGo言語 現場で使える実践テクニック』
draft: true
tags:
- golang
- book
---
[『みんなのGo言語 現場で使える実践テクニック』](https://www.amazon.co.jp/gp/product/477418392X/ref=as_li_ss_tl?ie=UTF8&linkCode=ll1&tag=hifumiass-22&linkId=a7bfdcf443475b21e20f019eb801bf50)を著者のひとりである[中島大一](https://twitter.com/deeeet)さんよりご恵贈に与りました。ありがとうございます。

<blockquote class="instagram-media" data-instgrm-version="7" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50.0% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAMUExURczMzPf399fX1+bm5mzY9AMAAADiSURBVDjLvZXbEsMgCES5/P8/t9FuRVCRmU73JWlzosgSIIZURCjo/ad+EQJJB4Hv8BFt+IDpQoCx1wjOSBFhh2XssxEIYn3ulI/6MNReE07UIWJEv8UEOWDS88LY97kqyTliJKKtuYBbruAyVh5wOHiXmpi5we58Ek028czwyuQdLKPG1Bkb4NnM+VeAnfHqn1k4+GPT6uGQcvu2h2OVuIf/gWUFyy8OWEpdyZSa3aVCqpVoVvzZZ2VTnn2wU8qzVjDDetO90GSy9mVLqtgYSy231MxrY6I2gGqjrTY0L8fxCxfCBbhWrsYYAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div><p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;"><a href="https://www.instagram.com/p/BJ-VCQ-jKKj/" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none;" target="_blank">A photo posted by Takahiro Okumura (@hfm)</a> on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2016-09-05T12:15:31+00:00">Sep 5, 2016 at 5:15am PDT</time></p></div></blockquote>
<script async defer src="//platform.instagram.com/en_US/embeds.js"></script>

[A Tour of Go](https://tour.golang.org/) を一通り終えた後、[Mackerel](https://mackerel.io/) プラグイン開発でちまちまと Go 言語を書いていました。Mackerel プラグインには先人の書き方もあり、ひと通り文法を学んだ後なら見よう見まねでなんとかなりました。

しかし、それらの書いたコードが Go 言語らしく書けているのか、またパフォーマンスを考慮できたものになっているか、そのした視点の欠如が徐々に気になってきました。

本書は、そんな私がもう一歩踏み出すためにピッタリの本でした。

150ページにも満たない厚みで、どちらかといえば薄い冊子なのに、中身は凝縮されている印象を受けました。6人の執筆者が各章を担当しており、第1章から学びの連続でした。

「第1章 Goによるチーム開発のはじめ方とコードを書く上での心得」では、
導入編のような内容だとせいぜい流し読みか読み飛ばすことも多いけど、知らないツールや使ったことのないツールがたくさんあって、ふむふむと思って読んだ。Go言語は周辺ツールの充実っぷりが大変素晴らしい。
また、「Goらしいコードを書く」では、LL言語からやってきた人がつい選んでしまいがちな方法を避け、タイトルどおり Go らしいコードを書くための tips が紹介されている。

第2章
正直、Linux ときどき OSX といった気持ちしか持っていなかったので、path/filepath を例にしたマルチプラットフォームに対応したコードの書き方は目からうろこだった。

第3章
「3.9 goroutine の停止」でContextパッケージのフォローがある。便利。
第4章
CLI ツールである Mackerel プラグインを書く時に中島大一さんのコードやブログをたくさん読んできましたが、この章はそんな彼のコードに対する姿勢が
第5章
第6章

[@bradfitz](https://twitter.com/bradfitz) の [Profiling & Optimizing in Go](http://yapcasia.org/2015/talk/show/6bde6c69-187a-11e5-aca1-525412004261)

文法をひと通り学んだ人が、「Go 言語を使ってアプリケーションやツールを書いてみたいけど、ベターな書き方が分からないと悩んでいる人の背中を押してくれる素晴らしい一冊だと思います。

個人の経験ですが、言語を修練するためには、コードを繰り返し読み書きし、試行錯誤を学習の糧とします。実践的なテクニックを、本書は余すところなく紹介してくれています。まるで、ちょっとズルをした気分になるような、

- 目次
  - 第1章 Goによるチーム開発のはじめ方とコードを書く上での心得
  - 第2章 マルチプラットフォームで動作する社内ツールのつくり方Windows
  - 第3章 実用的なアプリケーションを作るために
  - 第4章 コマンドラインツールを作る
  - 第5章 The Dark Arts Of Reflection
  - 第6章 Goのテストに関するツールセット
