---
layout: post
date: 2015-02-24 23:24:39 +0900
title: 『Linuxカーネル2.6解読室』読書会の省察と『詳解UNIXプログラミング』読書会
tags:
- kernel
- book
---
昨年，[@hiboma](https://twitter.com/hiboma)さん主導のもと，ペパボで『[Linuxカーネル2.6解読室](http://www.amazon.co.jp/exec/obidos/ASIN/4797338261/hifumiass-22/ref=nosim/)』読書会を毎週1回のペースで行っていた．

2015年からは，新たに『[詳解UNIXプログラミング](http://www.amazon.co.jp/exec/obidos/ASIN/B00KRB9U8K/hifumiass-22/ref=nosim/)』を選択し，週1ペースで読書会を開催してる．

[![詳解UNIXプログラミング 第3版](http://ecx.images-amazon.com/images/I/51L6CwNG11L._SL160_.jpg)](http://www.amazon.co.jp/exec/obidos/ASIN/B00KRB9U8K/hifumiass-22/ref=nosim/)
[詳解UNIXプログラミング 第3版](http://www.amazon.co.jp/exec/obidos/ASIN/B00KRB9U8K/hifumiass-22/ref=nosim/)

## @hibomaさんによる読書会の主導

![](/images/2015/02/21/whats-apue.png)

<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-version="4" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAAGFBMVEUiIiI9PT0eHh4gIB4hIBkcHBwcHBwcHBydr+JQAAAACHRSTlMABA4YHyQsM5jtaMwAAADfSURBVDjL7ZVBEgMhCAQBAf//42xcNbpAqakcM0ftUmFAAIBE81IqBJdS3lS6zs3bIpB9WED3YYXFPmHRfT8sgyrCP1x8uEUxLMzNWElFOYCV6mHWWwMzdPEKHlhLw7NWJqkHc4uIZphavDzA2JPzUDsBZziNae2S6owH8xPmX8G7zzgKEOPUoYHvGz1TBCxMkd3kwNVbU0gKHkx+iZILf77IofhrY1nYFnB/lQPb79drWOyJVa/DAvg9B/rLB4cC+Nqgdz/TvBbBnr6GBReqn/nRmDgaQEej7WhonozjF+Y2I/fZou/qAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div> <p style=" margin:8px 0 0 0; padding:0 4px;"> <a href="https://instagram.com/p/zMyEGFs854/" style=" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;" target="_top">週1でやってる&#34;詳解UNIXプログラミング&#34;読書会、キリがいいところまでやって時間が余ったのでハイパーバーチータイム。出張中の住処について話してくれているところ</a></p> <p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;">A photo posted by Shinya Tsunematsu (@tnmt) on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2015-02-17T10:56:28+00:00">Feb 17, 2015 at 2:56am PST</time></p></div></blockquote>
<script async defer src="//platform.instagram.com/en_US/embeds.js"></script>

本書は「Unix上で動くプログラムを書く人を対象」(初版・序文より) としており，弊社エンジニアも例外では無い．
C言語とか書いてるわけでは無いけど，エンジニアの共通言語を養うことにもなって，良いコミュニティだなあと感じている．

書籍から学べる内容ももちろんのこと，例えば`man`って意外とみんな使ってなくて，`man 3 open`とかすると「3って何？」みたいなことになる．
「`man -aw open`してみると，同名のマニュアル一覧出せますよ」と言えば，「へ〜」とか「お〜」みたいなリアクションが返ってくる．
早い話がドヤれるってことなんだろうけど，「困ったらmanを引け」みたいな言葉だけのマサカリだけでなく，実演による経験値への還元率の高さは読書会の魅力の1つと言える．

これがRailsであれば (Railsそこまで詳しく無いけど)，「調べ物したかったら http://api.rubyonrails.org/ や http://edgeguides.rubyonrails.org/ 見なさい」みたいなことだと思うんだけど

「system callって何を指してるの？」とか「OSとkernelの違いってなんぞや？」

