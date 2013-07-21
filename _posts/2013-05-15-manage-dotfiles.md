---
layout: post
title: Dot filesをGitHubで管理する
categories:
- Dev
- Mac
tags:
- GitHub
- Mac
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: Mac, Programming, Development, Shell, dotfiles, GitHub
  _aioseop_title: Dot filesをGitHubで管理する
---
ドットファイルは、ファイル名がドットから始まるファイルを示すUNIX用語です。

<!--more-->

通常、ドットファイルは隠しファイル（隠しディレクトリ）として機能しています。.gitや.vimrc等、

次のドットファイル移行用シェルスクリプトを叩けば、.dotfilesの中にある (.gitを除く) 全てのドットファイルのシンボリックリンクをホームディレクトリに貼ります。
<pre class="lang:sh decode:true" title="migration.sh">#!/bin/sh

for file in 'find ~/.dotfiles -d 1 -name '.*' | grep -v '.git$' | sed "s/.*dotfiles\///g"'
do
    ln -s ~/.dotfiles/$file ~/$file
done</pre>
&nbsp;
