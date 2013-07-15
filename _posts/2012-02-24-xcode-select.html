---
layout: post
title: Xcodeが4.3になったのでxcode-selectのフォルダパスを変更しよう
categories:
- Dev
- Mac
tags:
- Homebrew
- Mac
- Xcode
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/y10kru
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/mac/xcode-select/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: "a:4:{i:0;s:123:\"【ブログ編集】 Xcodeが4.3になったのでxcode-selectのフォルダパスを変更しよう
    http://bit.ly/y10kru\";i:1;s:176:\"【ブログ編集】 Xcodeが4.3になったのでxcode-selectのフォルダパスを変更しよう
    http://bit.ly/y10kru - またHomebrew絡みなんですが…\r\n\r\n\r\n\r\nHome\";i:2;s:176:\"【ブログ編集】
    Xcodeが4.3になったのでxcode-selectのフォルダパスを変更しよう http://bit.ly/y10kru - またHomebrew絡みなんですが…\r\n\r\n\r\n\r\nHome\";i:3;s:176:\"【ブログ編集】
    Xcodeが4.3になったのでxcode-selectのフォルダパスを変更しよう http://bit.ly/y10kru - またHomebrew絡みなんですが…\r\n\r\n\r\n\r\nHome\";}"
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _syntaxhighlighter_encoded: '1'
  _yoast_wpseo_metadesc: HomebrewからMacVimがインストール出来なかったので、Xcode4.3から色々変わった仕様を調べてたら、やっぱりその仕様のせいでエラーが起きていたので何とかしました、というエントリーです。
  _yoast_wpseo_metakeywords: Mac,Xcode,Homebrew
  _yoast_wpseo_title: Xcodeが4.3になったのでxcode-selectのファルダパスを変更しよう
  dsq_thread_id: '1225904424'
  _oembed_4032987b42c2606dd58eac67437144fa: '{{unknown}}'
  _oembed_f2af04fa6ee7ff446caed9e2534320ed: '{{unknown}}'
  _oembed_3d18495f4efe10bce747dfdff71be533: '{{unknown}}'
  _oembed_ceb98269ccfb6f9de32fa3a2618b2514: '{{unknown}}'
---
また<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/" target="_blank">Homebrew</a>絡みなんですが、Xcode4.3からアプリケーションディレクトリの位置が変更されてしまったため、そのためにxcode-selectのフォルダパスを変更を行ないました。以下、そのまとめです。

<!--more-->

<a title="Homebrew" href="http://mxcl.github.com/homebrew/" target="_blank">Homebrew</a>経由で<a title="macvim" href="http://code.google.com/p/macvim/" target="_blank">MacVim</a>を入れようとしたら、以下のような状況に。
<pre>$ brew install macvim --custom-icons --with-cscope --enable-clipboard
==&gt; Downloading https://github.com/b4winckler/macvim/tarball/snapshot-64
File already downloaded in /Users/hfm/Library/Caches/Homebrew
==&gt; ./configure --with-features=huge --with-tlib=ncurses --enable-multibyte --with-macarch
==&gt; make
Starting make in the src directory.
...
Error: No developer directory found at /Developer. Run /usr/bin/xcode-select to update the developer directory path.
make[1]: *** [macvim] Error 1
make: *** [first] Error 2
==&gt; Exit Status: 2
http://github.com/mxcl/homebrew/blob/master/Library/Formula/macvim.rb#L63
...
Error: Failed executing: make
These existing issues may help you: 
https://github.com/mxcl/homebrew/issues/10121  
https://github.com/mxcl/homebrew/issues/10124 
Otherwise, please report the bug:
https://github.com/mxcl/homebrew/wiki/checklist-before-filing-a-new-issue</pre>
で、何がなにやらよく分からなかったんですが、よく見るとこんな一文が。
<pre>Error: No developer directory found at /Developer. Run /usr/bin/xcode-select to update the developer directory path.</pre>
/Developerというフォルダ(ディレクトリ)が見つからない、ということが主原因だそうです。

最近、Mac OS X 10.7.3がリリースされて、それに伴いXcodeも4.3にバージョンアップしました。Mac App Storeから入手できる最新版のXcodeは、これまでのバージョンと違い、/ApplicationsにXcode.appという形で全て収められるようになりました。これまではルートに/Developerフォルダがあったんですが、全て削除されるようになりましたね。

そして/Developerが消えて/Applications/Xcode.appに全てが入るようになってから、一部の開発ツールも移行してしまったのが今回のエラーに繋がってしまったようです。

そこでどうすればいいかというと、エラー文にあるようにXcodeが見つからないので、<strong>xcode-select</strong>というツールを使って改めてXcodeのパスを指定してあげてください、ということだそうです。
<h1>なんとかする</h1>
<pre>$ xcode-select -print-path
<span style="color: #888888;">/Developer</span></pre>
ということで、存在しないフォルダパスを指定しているようでしたので、オプション-switchを使って新しくパスを指定します。
<pre>$ sudo xcode-select -switch /Applications/Xcode.app
$ xcode-select -print-path
<span style="color: #888888;">/Applications/Xcode.app/Contents/Developer</span></pre>
これで完了です。改めてMacVimを入れてみましょう。
<pre>$ brew install macvim --custom-icons --with-cscope --enable-clipboard
==&gt; Downloading https://github.com/b4winckler/macvim/tarball/snapshot-64
File already downloaded in /Users/hfm/Library/Caches/Homebrew
==&gt; ./configure --with-features=huge --with-tlib=ncurses --enable-multibyte --with-macarch
==&gt; make
==&gt; Caveats
MacVim.app installed to:
/usr/local/Cellar/macvim/7.3-64

To link the application to a normal Mac OS X location:
brew linkapps
or:
ln -s /usr/local/Cellar/macvim/7.3-64/MacVim.app /Applications
==&gt; Summary
/usr/local/Cellar/macvim/7.3-64: 1733 files, 27M, built in 2.5 minutes

$ brew linkapps
Linking /usr/local/Cellar/macvim/7.3-64/MacVim.app</pre>
というわけで無事インストール終わりました。Xcodeが新しくなったことでなんかエラー出るだろうなーとは思ってたんですが、まさかこんなところで露呈するとは…。

<hr />

<strong>追記(February 25, 2012)</strong>

Xcodeの設定欄見てたら、なにやら気になる項目が。

[caption id="attachment_881" align="aligncenter" width="300"]<a title="Xcode Preference" href="http://blog.hifumi.info/wp-content/uploads/2012/02/Screen-Shot-2012-02-25-at-6.55.45-.png"><img class="size-medium wp-image-881" title="Xcode Preference" alt="Command Line Tools...?" src="http://blog.hifumi.info/wp-content/uploads/2012/02/Screen-Shot-2012-02-25-at-6.55.45--300x222.png" width="300" height="222" /></a> Command Line Tools...?[/caption]

なにやらCommand Line Toolsという単語が見えるのですが、ひょっとしてxcode-serectとか使わなくてもこれ入れておけば良かった、みたいな話なんですかね…？

<hr />

<strong>追記(March 22, 2012)</strong>

<a href="http://mogutan.wordpress.com/2012/02/18/trouble-installing-xcode4-3/" target="_blank">Xcode 4.3 と Mac Ports とか HomeBrew とか（もぐろぐ）</a>によると、
<blockquote>xcode 4.3 から Commandline tools とか色々と分離されたらしい。</blockquote>
ほう。
<blockquote>$PATH に /Applications/Xcode.app/Contents/Developer/usr/bin を加える必要は無い、代わりに Coomand Line Tools をインストールするだけでよい。</blockquote>
なんと…。

ということで、やはりXcodeからCommand Line Toolsをインストールすれば、上に書いた問題は解決されるようでした。うーん、毎度のことながら林檎社の仕様変更には振り回されまくりですね(ーー;)
