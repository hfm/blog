---
layout: post
title: Zsh設定ファイルがこんなに育ちました。
categories:
- Dev
tags:
- Zsh
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: Development, Zsh
  _aioseop_title: Zsh設定ファイルがこんなに育ちました。
---
<img class="aligncenter size-large wp-image-3429" alt="z" src="http://blog.hifumi.info/wp-content/uploads/2013/01/z-e1358587492148-600x171.png" width="600" height="171" />

皆さんいつもお世話になっております。

以前、.zshrcと.zprofileによるZsh設定ファイルを公開しました。

『 <a title="Zshの設定プロファイル(.zprofileと.zshrc)" href="http://blog.hifumi.info/mac/zprofile-and-zshrc/" target="_blank">Zshの設定プロファイル(.zprofileと.zshrc)</a> 』

しかし、.zprofileと.zshrcにテキストをベタ書きするのでは芸がありません。

そこで今回は、自分のZsh環境を再構築すると共に、その構成について公開させていただきます。

…といっても、ほとんどの設定はGitHubやブロガーの方々のノウハウを流用したものばかりですので、新規性には乏しいかと思います。あらかじめご了承くださいませ。

<!--more-->

aa
<blockquote>【コラム】漢のzsh

1 最強のシェル、それは「zsh」

<a title="【コラム】 漢のzsh (1) 最強のシェル、それは「zsh」" href="http://news.mynavi.jp/column/zsh/001/index.html" target="_blank">http://news.mynavi.jp/column/zsh/001/index.html</a></blockquote>
あ
<h3>ログインシェルとしてzshが起動された場合</h3>
<ol>
	<li>~/.zshenv</li>
	<li>~/.zprofile</li>
	<li>~/.zshrc</li>
	<li>~/.zlogin</li>
</ol>
<h3>インタラクティブシェルとしてzshが起動された場合</h3>
<ol>
	<li>~/.zshenv</li>
	<li>~/.zshrc</li>
</ol>
<h3>シェルスクリプトを実行するコマンドとしてzshが起動された場合</h3>
<ol>
	<li>~/.zshenv</li>
</ol>
<h3>ログインシェルとして起動されたzshからログアウトする場合</h3>
<ol>
	<li>~/.zlogout</li>
</ol>
あああ
