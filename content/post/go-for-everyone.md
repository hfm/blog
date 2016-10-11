---
date: 2016-10-11T13:00:57+09:00
title: 『みんなのGo言語 現場で使える実践テクニック』
tags:
- golang
- book
---
[『みんなのGo言語 現場で使える実践テクニック』](https://www.amazon.co.jp/gp/product/477418392X/ref=as_li_ss_tl?ie=UTF8&linkCode=ll1&tag=hifumiass-22&linkId=a7bfdcf443475b21e20f019eb801bf50)を著者のひとりである[中島大一](https://twitter.com/deeeet)さんよりご恵贈に与りました。ありがとうございます。書評経験に乏しく、頂いてからずいぶん時間がかかってしまいましたが、読了の旨とその感想を書かせていただきたいと思います。

<blockquote class="instagram-media" data-instgrm-version="7" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50.0% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAMUExURczMzPf399fX1+bm5mzY9AMAAADiSURBVDjLvZXbEsMgCES5/P8/t9FuRVCRmU73JWlzosgSIIZURCjo/ad+EQJJB4Hv8BFt+IDpQoCx1wjOSBFhh2XssxEIYn3ulI/6MNReE07UIWJEv8UEOWDS88LY97kqyTliJKKtuYBbruAyVh5wOHiXmpi5we58Ek028czwyuQdLKPG1Bkb4NnM+VeAnfHqn1k4+GPT6uGQcvu2h2OVuIf/gWUFyy8OWEpdyZSa3aVCqpVoVvzZZ2VTnn2wU8qzVjDDetO90GSy9mVLqtgYSy231MxrY6I2gGqjrTY0L8fxCxfCBbhWrsYYAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div><p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;"><a href="https://www.instagram.com/p/BJ-VCQ-jKKj/" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none;" target="_blank">A photo posted by Takahiro Okumura (@hfm)</a> on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2016-09-05T12:15:31+00:00">Sep 5, 2016 at 5:15am PDT</time></p></div></blockquote>
<script async defer src="//platform.instagram.com/en_US/embeds.js"></script>

私は Go 言語にそこまで精通している者ではなく、[A Tour of Go](https://tour.golang.org/) を一通り終えた後、[Mackerel](https://mackerel.io/) プラグイン開発でちまちまと書いている程度です。Mackerel プラグインは先人の書き方もあり、ひと通り文法を学んだ後なら見よう見まねでなんとかなりました。

しかし、それら見よう見まねのコードが Go らしく書けているのか、またパフォーマンスは十分なのか等、自分に足りていないものが徐々に気になってきていました。最近は C を書くことが増え、Go のソースコードを読む時間も減り、距離が出来つつあることも不安の種でした。

本書は、そんな私がもう一段理解を深めるのにピッタリの本でした。技術書としてはやや薄い約140ページほどのボリュームですが、中身は著者らの経験がギュッと凝縮されています。

内容は章ごとに独立しているので、どこから読み始めてもいいと思います。

第1章「 Goによるチーム開発のはじめ方とコードを書く上での心得」では、恥ずかしながら gorename や guru, godef, gotags を知らなかったので、これらのツールは私にとって発見でした。 ソースコードの探検が捗ります。周辺ツールの充実っぷりの再確認にもなりました。

第2章「マルチプラットフォームで動作する社内ツールのつくり方」では、主に Windows へのポータビリティの配慮について学びました。普段は Linux ときどき OSX といった程度しかプラットフォームのことを考えていなかったので、path/filepath を例にしたマルチプラットフォーム対応コードの書き方はなるほどと思って読ませていただきました。

第3章「実用的なアプリケーションを作るために」は、Go でアプリケーションを作った経験が無い私にとって、もっとも勉強になった章でした。本章では「実用的なアプリケーション」の定義と具体的な実装例として、バッファリングやシグナル、goroutine などの扱い方を示してくれます（他にもまだまだあるのですが、特に勉強になった項目だけ抜粋）。冒頭に述べた「パフォーマンスは十分なのか」という視座の欠如に光をもたらしてくれる大変ありがたい内容でした。

第4章「コマンドラインツールを作る」では、Go が元々持っている機能を最大限活用すれば、サードパーティ製のものを使わずとも十分なツールが作れるという意思を見た気がします。Mackerel プラグインを書く際、中島さんのコードやブログ記事にたくさん触れてきましたが、この章は彼のこれまでの活動が集約されているようでした。

第5章「The Dark Arts Of Reflection」は...すみません、まだ私には早かったようです(ヽ´ω`)内容がわからなかったわけでは無いのですが、まだ reflect パッケージを活用すべきプロダクトに出会っていないので、いつか出会うかもしれない Reflection 活用プロダクトに思いを馳せておきます。タイトルもそうですが、本書のなかでも際立った特徴を持つ章でした。

第6章「Go のテストに関するツールセット」では、Go のテストツールセットが持つ、シンプルで強力な機能を再確認しました。YAPC::Asia 2015 で [@bradfitz](https://twitter.com/bradfitz) がデモで見せた [Profiling & Optimizing in Go](http://yapcasia.org/2015/talk/show/6bde6c69-187a-11e5-aca1-525412004261) を見たときも感嘆しましたが、C を書いている身としては（C に詳しいわけではないので知らないだけかもしれませんが）、 ベンチマーク や Race Detector が最初から使えるのは大変便利です。

[『みんなのGo言語 現場で使える実践テクニック』](https://www.amazon.co.jp/gp/product/477418392X/ref=as_li_ss_tl?ie=UTF8&linkCode=ll1&tag=hifumiass-22&linkId=a7bfdcf443475b21e20f019eb801bf50)は「文法をひと通り学んだけど、Go を使ったアプリケーションやツールのベターな書き方が分からない」と悩んでいる人の背中を押してくれる素晴らしい一冊だと思います。ちょっとズルをした気分になるほど、豊かな経験に基づく実践的テクニックの多くを勉強させてもらえる本でした。
