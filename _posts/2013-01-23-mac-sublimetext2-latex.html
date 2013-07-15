---
layout: post
title: Mac、Sublime Text 2、LaTeX
categories:
- Mac
tags:
- LaTeX
- Mac
- Sublime Text 2
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '3473'
  _aioseop_keywords: Mac, Sublime Text 2, LaTeX, latexmk
  _aioseop_description: Macを例に、Sublime Text 2上でLaTeXをコンパイル出来るようにするための設定紹介です。
  _aioseop_title: Mac、Sublime Text 2、LaTeX
  dsq_thread_id: '1224741716'
---
<p style="text-align: center;"><a href="http://blog.hifumi.info/wp-content/uploads/2013/01/Sublime-TEXt-2.png"><img class="aligncenter size-large wp-image-3473" style="border: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px;" alt="Sublime TEXt 2" src="http://blog.hifumi.info/wp-content/uploads/2013/01/Sublime-TEXt-2-700x250.png" width="700" height="250" /></a></p>
Macで<a href="http://www.sublimetext.com/" target="_blank">Sublime Text 2</a>をメインエディタとして利用している人向けに、TeX環境をST2用にセットアップするための手順です．

準備として次のようなものを入手します。
<ul>
	<li>Homebrew</li>
	<li>MacTeX</li>
	<li>latexmk（MacTeXに付属）</li>
	<li>Sublime Text 2</li>
	<li>LaTeXTools（ST2へ導入するパッケージ）</li>
</ul>
<!--more-->
<h1>目次</h1>
<ul>
	<li><a href="#homebrew">Homebrew</a>
<ul>
	<li><a href="#homebrewspecified">Homebrewから指定バージョンをダウンロードする</a></li>
</ul>
</li>
	<li><a href="#mactex">MacTeX</a>
<ul>
	<li><a href="#installmactex">MacTeXのインストール</a></li>
	<li><a href="#texliveutility">TeX Live Utility</a></li>
	<li><a href="#latexmk">latexmk</a></li>
	<li><a href="#latexmkrc">.latexmkrc</a></li>
</ul>
</li>
	<li><a href="#st2">Sublime Text 2</a>
<ul>
	<li><a href="#latextools">LaTeXTools</a></li>
	<li><a href="#sublime-build">LaTeXTools/LaTeX.sublime-build</a></li>
</ul>
</li>
</ul>
<h1><a name="homebrew"></a>Homebrew</h1>
Homebrew導入は不肖ながら<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/">以前記事を書きました</a>ので、細かな設定はそちらをご参考ください。

インストールコマンドは次のとおりです。
<pre class="lang:default decode:true" title="Homebrewのインストール">ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"</pre>
上記のコマンドでHomebrewが用意できたら、GhostscriptとImageMagickをインストールしておきます。
<pre class="lang:default decode:true" title="GhostScriptとImageMagickのインストール">brew install ghostscript
brew install imagemagick</pre>
後述するMacTeXにもGhostScriptとImageMagickのパッケージはついてくるのですが、<a href="http://toggtc.hatenablog.com/entry/2012/02/20/230500" target="_blank">日本語出力に難があるとの話</a>もあり、オススメできません。
<blockquote><a href="http://toggtc.hatenablog.com/entry/2012/02/20/230500" target="_blank">2012年、Mac(Lion)とTeXと日本語と、あとhomebrew</a>

Ghostscriptはディストリビューションやバージョンによって日本語が通ったり通らなかったりします。自分の環境ではhomebrewからghostscript 9.04やMacTeXにバンドルされたghostscript 9.02を使っても日本語がうまく通りませんでした。
最新のghostscript 9.05を使ったところ、日本語が通ったのでそちらを使います。</blockquote>
こちらの説明ではGhostScript9.04や9.02が上手くいかないとのことですが、2013.1.30時点でHomebrewから入手できるGhostscriptのバージョンは9.06 (2012-08-08)で、こちらは日本語の扱いは問題ありません。

ちなみに、今後のアップデートでまたうまく動かなくなる可能性も十分考えられますので、その場合は次のような方法を用いて解決します。
<h2><a name="homebrewspecified"></a>Homebrewからバージョン指定でダウンロードする</h2>
Homebrewにはversionsというコマンドがあり、これを使用すれば各パッケージの特定バージョンのダウンロードが可能です。
<pre class="lang:default decode:true" title="brew versionsの使用例">$ brew versions ghostscript
9.06     git checkout ead06fb /usr/local/Library/Formula/ghostscript.rb
9.05     git checkout 524e42a /usr/local/Library/Formula/ghostscript.rb
9.04     git checkout c3bf616 /usr/local/Library/Formula/ghostscript.rb
9.02     git checkout a22d862 /usr/local/Library/Formula/ghostscript.rb
9.01     git checkout 0476235 /usr/local/Library/Formula/ghostscript.rb
9.00     git checkout 7871a99 /usr/local/Library/Formula/ghostscript.rb
8.71     git checkout ed51a5b /usr/local/Library/Formula/ghostscript.rb
8.70     git checkout fc7abba /usr/local/Library/Formula/ghostscript.rb</pre>
最新ではないバージョンが欲しい場合は、少し手続きが面倒になりますが、次のようなコマンドで導入できます。
<pre class="lang:default decode:true" title="GhostScript9.02をインストールしたい場合">$ cd /usr/local/Library/Formula
$ git checkout a22d862 /usr/local/Library/Formula/ghostscript.rb
$ brew install ghostscript</pre>
<p style="text-align: right;">参考：<a title="homebrewでバージョンを指定してインストールする - Qiita" href="http://qiita.com/items/f8f647e757842f08b9ec" target="_blank">homebrewでバージョンを指定してインストールする - Qiita</a> by <a href="http://qiita.com/users/semind" target="_blank">semind</a></p>

<h1><a name="mactex"></a>MacTeX</h1>
<h2><a name="installmactex"></a>MacTeXのインストール</h2>
まずは<a href="http://tug.org/mactex/" target="_blank">MacTeXの公式ウェブサイト</a>からMacTeX.pkgをダウンロード、インストールします。

ただし注意点として、インストールウィザードの途中で「カスタマイズボタン」を押し、インストールする内容に変更を加える必要があります。

[caption id="attachment_3453" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex1.png"><img class="size-medium wp-image-3453" alt="インストールウィザードの途中でカスタマイズボタンを押す" src="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex1-400x283.png" width="400" height="283" /></a> インストールウィザードの途中でカスタマイズボタンを押す[/caption]

具体的には、デフォルトでインストールされてしまうGhostScriptとImageMagickを対象から外します。

[caption id="attachment_3454" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex2.png"><img class="size-medium wp-image-3454" alt="GSとIMのチェックを外してインストール" src="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex2-400x283.png" width="400" height="283" /></a> GSとIMのチェックを外してインストール[/caption]

この点だけ注意して、MacTeXをインストールします。
<h2><a name="texliveutility"></a>TeX Live Utility</h2>
[caption id="attachment_3455" align="alignleft" width="200"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex3.png"><img class="size-thumbnail wp-image-3455 " alt="TeX Live Utilityのバージョンアップ" src="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex3-200x200.png" width="200" height="200" /></a> TeX Live Utilityのバージョンアップ[/caption]

MacTeXのインストール後、TeX Live Utilityを更新して最新バージョンにします。
<p class="clearfix">TeX Live Utilityを起動すれば自動アップデートの催促が来るので、そのまま指示に従ってInstall Updateしてしまいましょう。</p>


[caption id="attachment_3456" align="alignleft" width="200"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex4.png"><img class="size-thumbnail wp-image-3456" alt="texlive.infraのアップデート" src="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex4-200x200.png" width="200" height="200" /></a> texlive.infraのアップデート[/caption]

TeX Live Utilityのアップデート後、texlive.infraというパッケージのアップデート催促が来るので従います。
<p class="clearfix">ちなみに、このtexlive.infraという単語でググるとアップデートエラーに関する記事がバンバン上がってくるのですが、OS X Mountain LionとMacTeX 2012の組み合わせではエラーはありませんでした。</p>


[caption id="attachment_3457" align="alignleft" width="200"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex5.png"><img class="size-thumbnail wp-image-3457 " alt="TeX Live Utilityから各パッケージのアップデート" src="http://blog.hifumi.info/wp-content/uploads/2013/01/macst2latex_mactex5-200x200.png" width="200" height="200" /></a> 各パッケージのアップデート[/caption]

texlive.infraのアップデートが完了すると、次は各パッケージのアップデートです。

このアップデートも長いので気長に待ちましょう。
<p class="clearfix">ここまでの一連の作業を終えたら、TeXをコンパイルするための道具が全て揃ったことになります。</p>

<h3>ちなみに…Homebrewを入れている場合</h3>
先程はチェックを外しましたが、MacTeXの標準インストールでは、GhostScriptとImageMagickが付属アプリとして導入されるようになっています。

しかし、これらのインストール先は<span class="crayon-inline">/usr/local/bin</span> です。つまり、Homebrewのインストールディレクトリと同じになっています。

先ほどチェックを外した理由の1つとして、Homebrewのインストールディレクトリと同じ場所にrootユーザのパッケージが入ってくるのは少しイゴコチが悪いというのがあります。 （ただし、GSとIMのチェックを外しても、<span class="crayon-inline">/usr/local/bin/texdist</span> というエイリアスファイルが生成されてしまいますが…）
<h1><a name="latexmk"></a>latexmk</h1>
後述するLaTeXToolsではTeXコンパイルに<a href="http://www.phys.psu.edu/~collins/software/latexmk-jcc/" target="_blank">latexmk</a>を使用しています。latexmkはMakefileのLaTeX版のようなもので、(p)latexからbibtex、dvipdfmxといったTeX処理を一括で行なってくれます。

latexmkは先程のMacTeXをインストールしていれば、自動的にインストールされます。
<p style="text-align: right;">参考：<a href="http://d.hatena.ne.jp/goth_wrist_cut/20120214/1329186414" target="_blank">修論が終わってからlatexmkの存在に気がついた</a></p>

<h2><a name="latexmkrc"></a>.latexmkrc</h2>
latexmkを利用するにあたって、<span class="crayon-inline">$HOME/.latexmkrc</span> を作成し、次のような設定を書き込みます。
<pre class="lang:default decode:true" title="~/.latexmkrc">$latex ="platex -synctex=1 -src-specials -interaction=nonstopmode";
$bibtex = "pbibtex %O %B";
$dvipdf = "dvipdfmx %O -o %D %S";
$pdf_mode = 3;
$pdf_update_method = 0;
$pdf_previewer = "open -a preview.app";</pre>
<h1><a name="st2"></a>Sublime Text 2</h1>
ST2は再び不肖ながら<a title="Sublime Text 2をMacで使う" href="http://blog.hifumi.info/mac/sublime-text-2-for-mac/">以前書いた記事</a>などを参考にインストールしてください。以下はPackageControlを導入済みのST2を前提とした内容になります。
<p style="text-align: right;">参考：<a href="http://wiki.livedoor.jp/fuhmi/d/TeX%A4%CB%B4%D8%A4%B9%A4%EB%B3%D0%A4%A8%BD%F1%A4%AD#content_16">TeXに関する覚え書き</a></p>

<h2><a name="latextools"></a>LaTeXTools</h2>
PackageControlからLaTeXToolsをインストールしてください。LaTeXToolsはLaTeXのビルドやコマンドや数式のSnippetsといったST2 for LaTeXの補完パッケージです。

[caption id="attachment_3466" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/latextools.png"><img class="size-medium wp-image-3466" alt="LaTeXTools" src="http://blog.hifumi.info/wp-content/uploads/2013/01/latextools-400x118.png" width="400" height="118" /></a> LaTeXTools[/caption]
<h2><a name="sublime-build"></a>LaTeXTools/LaTeX.sublime-build</h2>
<span class="crayon-inline">Sublime Text 2/Packages/LaTeXTools/LaTeX.sublime-build</span> の34行目付近を、
<pre class="lang:default decode:true" title="《変更前》Sublime Text 2/Packages/LaTeXTools/LaTeX.sublime-buildの34行目付近">"cmd": ["latexmk", "-cd",
        "-e", "\\$pdflatex = 'pdflatex %O -interaction=nonstopmode -synctex=1 %S'",
        //"-silent",
        "-f", "-pdf"],</pre>
から
<pre class="lang:default decode:true" title="《変更後》Sublime Text 2/Packages/LaTeXTools/LaTeX.sublime-buildの34行目付近">"cmd": ["latexmk", "-cd", "-f", "-pv"],</pre>
に変更します。
<p style="text-align: right;">参考：<a href="http://skalldan.wordpress.com/2012/11/23/sublime-text-2-%E3%81%A7-latex-%E3%81%99%E3%82%8B%E3%81%BE%E3%81%A7%E3%81%AE%E3%83%A1%E3%83%A2/">Sublime Text 2 で LaTeX するまでのメモ</a></p>
ここまで書けば設定は全て完了です。お疲れ様でした。

Sublime Text 2から開いたTeXファイル、あるいは新規作成したものをCommand⌘-Bでコンパイルしてみましょう。コンパイルされてPDFとして出力されたファイルがPreviewで表示されます（１度目だけは表示されないようなのでご注意ください）。また、日本語での出力もできると思います。
<h3>ちなみに…latexmkのオプションの説明</h3>
<ul>
	<li><span class="crayon-inline">-cd</span> …プロセス時にソースファイルのディレクトリへ移動</li>
	<li><span class="crayon-inline">-e</span>…このオプションの後にPerlのコードを書いて実行</li>
	<li><span class="crayon-inline">-f</span>…エラーが起きても構わず最後までコンパイル</li>
	<li><span class="crayon-inline">-pdf</span>…pdflatexを用いてPDFを生成する</li>
	<li><span class="crayon-inline">-pv</span>…生成したドキュメントをプレビューする</li>
</ul>
ちなみに変更後の方は-pdfオプションを削除していますが、.latexmkrcによって補完されているので、最終的にはPDFが生成されますのでご安心を。
