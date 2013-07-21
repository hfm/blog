---
layout: post
title: zsh compinitのオプション"-u"について調べた
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
  _aioseop_keywords: Zsh, Development
  _aioseop_title: zsh compinitのオプション"-u"について調べた
---
<h1>謎の警告</h1>
それはZsh改造中の出来事でした。

私はいつものように.zshrcに新たな機能を追加していました。愛するターミナルを便利にカスタマイズし続ける喜びを、わたしはよく知っています。それはミンクオイルを丁寧に施された革靴のように、あるいは、

しかしその日は違いました。

便利そうな機能を新たに追加したあと、.zshrc を再読み込みすると、次の警告メッセージが現れたのです。

<!--more-->
<pre class="lang:default decode:true">$ source .zshrc
zsh compinit: insecure directories, run compaudit for list.
Ignore insecure directories and continue [y] or abort compinit [n]?</pre>
よく分からないまま取り敢えずググったところ、次のWebサイトに行き当たりました。
<blockquote>この問題については、compinit に -u オプションを付けることで回避できます。
<p style="text-align: right;"><a href="http://kaworu.jpn.org/kaworu/2009-03-29-1.php" target="_blank">http://kaworu.jpn.org/kaworu/2009-03-29-1.php</a></p>
</blockquote>
コレに従い、.zshrc 中のcompinitに -u オプションを付け加えると、確かにエラーは消えました。
<pre class="lang:diff decode:true">--- autoload -U compinit &amp;&amp; compinit
+++ autoload -U compinit &amp;&amp; compinit -u</pre>
しかし疑問は残ります。

そもそも何の警告文だったのか。謎のオプション -u とはなにか。結局何が問題で、-u がそれをどのように解決してくれたのか。

答えはいつだってman zsh*にあります。追っていきましょう。
<h1>man zshcompsys</h1>
zshのcompinit（自動補完機能）が何やら言っております。
<pre class="lang:default highlight:0 decode:true">zsh compinit: insecure directories, run compaudit for list.</pre>
insecure directories
