---
layout: post
title: Homebrewで（OpenCVのために）pangoを何とか入れた
categories:
- Dev
- Mac
tags:
- Homebrew
- Mac
- pango
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/uMTWRD
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/mac/try-to-install-pango-with-homebrew/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:2:{i:0;s:163:"【ブログ編集】 Homebrewで（OpenCVのために）pangoを何とか入れた http://bit.ly/uMTWRD
    - MacのHomebrewでOpenCVを入れようと思った矢先";i:1;s:163:"【ブログ編集】 Homebrewで（OpenCVのために）pangoを何とか入れた
    http://bit.ly/uMTWRD - MacのHomebrewでOpenCVを入れようと思った矢先";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _yoast_wpseo_metadesc: HomebrewでOpenCVを入れようとした時に、依存関係にあるPangoをインストールしようとするとエラーが出たので、その時の作業についてメモを残しておきます。
  _yoast_wpseo_metakeywords: Homebrew, Mac, コンパイラ
  _yoast_wpseo_title: Homebrewでpangoを何とか入れた
  _aioseop_keywords: Homebrew, Mac, pango
  _aioseop_description: HomebrewからOpenCVを入れようとして、上手くいかずに悪戦苦闘した話です。
  _aioseop_title: Homebrewで（OpenCVのために）pangoを何とか入れた
  dsq_thread_id: '1228367245'
---
Xcodeのバージョンアップに伴うコンパイラの仕様変更などから、Homebrew経由でインストールするパッケージに不具合が出ることが稀に起こります。今回はOpenCVを入れようとした時に起こったインストールミスをなんとかするための備忘録になります。
<!--more-->
MacのHomebrewでOpenCVを入れようと思った矢先の出来事でした。
<pre class="toolbar:2 lang:default decode:true">brew install opencv</pre>
これだけで済むはずだったんですが、依存関係にあるPangoを一緒にインストールしようとしたら謎のエラー。makeの途中(make installではなく)でMacがエラー画面を吐き出してしまって、にっちもさっちもいかなくなるという現象（スクショ撮り忘れました…）にしばし格闘。

結局のところ、Pangoに問題があるのではなく（？）、それより前にインストールした<strong>glibとcairoに問題があった</strong>ようでした。以下、その時に僕が解決した方法です。
<pre class="toolbar:2 lang:default decode:true">brew install glib --use-llvm
brew install cairo --use-clang
brew install pango</pre>
これでOKでした<span style="color: #888888;">（ただこれ、根本的な原因究明ではないですよね…）</span>。makeでダメになる、というところでコンパイラの問題かなぁとは思ってたんですが、まさかPangoじゃなくてglibとcairoの問題とは…。

<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/" target="_blank">前回Homebrewの紹介をした時</a>に、Xcode4.2以降はコンパイラがGCCからClangに変わった関係で、--use-clangを使いましょう、ということだったんですが、どうやら今回の問題に限ってはClangではなくLLVM GCCを使わないと何とかならなかったようでした…うーん、そちらの方の知識に乏しいので、これが上手な解決策なのかが分からないあたり、勉強しなくてはいけないんですかね…(・_・;)
