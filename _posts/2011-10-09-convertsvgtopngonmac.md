---
layout: post
title: MacでSVGファイルを簡単にPNGファイルに変換する
categories:
- Mac
tags:
- Graphics
- Mac
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/mWOV0S
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/mac/convertsvgtopngonmac/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:2:{i:0;s:106:"【ブログ編集】 MacでSVGファイルを簡単にPNGファイルに変換する http://bit.ly/mWOV0S";i:1;s:106:"【ブログ編集】
    MacでSVGファイルを簡単にPNGファイルに変換する http://bit.ly/mWOV0S";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _syntaxhighlighter_encoded: '1'
  _thumbnail_id: '583'
  _aioseop_keywords: qlmanage,QuickLook,svg,png,svgをpngに変換,画像変換,mac
  _aioseop_description: "MacでSVGファイルを簡単にPNGファイルに変換する方法です。\r\nqlmanageというQuickLookのマネージャパッケージがコマンドラインから仕様出来るので、それを利用します。"
  _aioseop_title: MacでSVGファイルを簡単にPNGファイルに変換する
  dsq_thread_id: '1225598637'
---
いやもう<a title="Command-line application for converting SVG to PNG on Mac OS X - superuser" href="http://superuser.com/questions/134679/command-line-application-for-converting-svg-to-png-on-mac-os-x" target="_blank">ここ</a>に載ってあった鮮やかすぎる変換方法のただの転載なんですが…
<pre>SVGファイルをPNGに変換する
$ qlmanage -t -s 1000 -o . ***.svg</pre>
これだけです。

各パラメータについてですが、オプションの <strong>-t </strong>はおまじないと思って必ずつけて下さい。

<strong>-s 1000 </strong>の数字は出力ピクセル数になります。上記の例だと1000 平方pxの画像になります。

<strong>-o .</strong> は出力場所の指定で、これを抜くと何も生成されないのでつけておきましょう。

***.svgにpngに変換したいsvgファイルを指定します。このコマンドを実行すると、***.svg.pngというファイル名でpngファイルが生成されます。

<!--more-->

さて、このqlmanageコマンドですが、どんな画像も正方形で出力してしまいます。（※引き伸ばしてるわけではありません。）具体的にどんな画像になるのかを実際のsvgファイルを変換して確認します。
<h2>svgファイルの準備</h2>
まず普通のsvgファイルを用意します。今回は<a title="Inkscape" href="http://inkscape.org" target="_blank">Inkscape</a>を使って描きました。

[caption id="attachment_586" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2011/10/drawing.svg"><img class="size-full wp-image-586" title="テスト用SVGファイル by Inkscape" src="http://blog.hifumi.info/wp-content/uploads/2011/10/drawing.svg" alt="テスト用SVGファイル by Inkscape" width="400" height="135" /></a> Inkscapeで描いたSVGファイル[/caption]
<h2 style="text-align: left;">qlmanageでpng画像を生成</h2>
<p style="text-align: left;">qlmanageコマンドでpngファイルを生成します。コマンドはこのエントリの最上にある通り、1000x1000ピクセルのpng画像です。</p>

<pre>【再掲】SVGファイルをPNGに変換する
$ qlmanage -t -s 1000 -o . ***.svg</pre>
[caption id="attachment_584" align="aligncenter" width="300"]<a href="http://blog.hifumi.info/wp-content/uploads/2011/10/drawing.svg_.png"><img class="size-medium wp-image-584" title="qlmanageでsvgから変換されたpngファイル" src="http://blog.hifumi.info/wp-content/uploads/2011/10/drawing.svg_-300x300.png" alt="qlmanageでsvgから変換されたpngファイル" width="300" height="300" /></a> qlmanageでsvgから変換されたpngファイル[/caption]

1000x1000で出力されるので、余白がおかしくなっています。ご覧のとおり引き伸ばしじゃないんですが、余計な領域まで勝手に生成してしまうのが玉にキズですね。
<h2>Preview.appで部分抽出</h2>
あとはPreviewで余白部分を切り取って (Command + K) 、欲しい部分だけ手に入れましょう。

[caption id="attachment_583" align="aligncenter" width="300"]<a href="http://blog.hifumi.info/wp-content/uploads/2011/10/drawing.svg_mod.png"><img class="size-medium wp-image-583" title="Previewで余白を切り取った後" src="http://blog.hifumi.info/wp-content/uploads/2011/10/drawing.svg_mod-300x97.png" alt="Previewで余白を切り取った後" width="300" height="97" /></a> Previewで余白を切り取った後[/caption]

これで完成です。

元々は<a title="ImageMagick: Convert, Edit, And Compose Images" href="http://www.imagemagick.org/" target="_blank">ImageMagick</a>を使ってなんとか変換できないものかとググっていたら見つけたものなんですが、まさかこれほどまでに鮮やかにSVGをPNGにコンバートできるとは。しかもInkscapeやImageMagickをインストールせずに、Macが標準で備えている機能だけで実現できる所がいいですね。

ちなみに<strong>qlmanage</strong>はQuick Lookのサーバーデバッグ、マネジメントツールだそうです。（man qlmanageで説明丸写ししました）Quick Lookでプレビュー出力したsvgファイルをpngファイルに変換して保存してるんですかね…？

参考
<ul>
	<li><a href="http://superuser.com/questions/134679/command-line-application-for-converting-svg-to-png-on-mac-os-x" target="_blank">Command-line application for converting SVG to PNG on Mac OS X - superuser</a></li>
</ul>
