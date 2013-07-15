---
layout: post
title: Play with さくらVPS viii to ix ZshとVim
categories:
- Dev
tags:
- CentOS
- SakuraVPS
- vim
- Zsh
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/otMqoV
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/dev/play-with-%E3%81%95%E3%81%8F%E3%82%89vps-viii-to-ix-zsh%E3%81%A8vim/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:1:{i:0;s:143:"【ブログ編集】 Play with さくらVPS viii to ix ZshとVim http://bit.ly/otMqoV
    - 前回　Play with さくらVPS vii セキュリティ";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _syntaxhighlighter_encoded: '1'
  _yoast_wpseo_metadesc: さくらVPSのCent OSにZshとVimをインストールして、.zshrcと.vimrcを設定します。
  _yoast_wpseo_metakeywords: さくらVPS, CentOS, Zsh
  _yoast_wpseo_title: Play with さくらVPS viii to ix 色々インストール
  _aioseop_keywords: Zsh,Vim,さくらVPS,CentOS
  _aioseop_description: さくらVPSを使いやすくするためのVimとZshの設定。
  _aioseop_title: Play with さくらVPS viii to ix ZshとVim
  dsq_thread_id: '1224835406'
---
前回　<a title="Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証" href="http://blog.hifumi.info/dev/play-with-%e3%81%95%e3%81%8f%e3%82%89vps-vii-%e3%82%bb%e3%82%ad%e3%83%a5%e3%83%aa%e3%83%86%e3%82%a3%e8%a8%ad%e5%ae%9a%e3%81%9d%e3%81%ae2/">Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証</a>

前回までがセキュリティやログインの設定で、今回からは色々さくらVPSを使いやすくするための設定に参りたいと思います。

目次。
<p style="padding-left: 30px;">8. Zshを入れてデフォルトのシェルに設定する
8.1. Zshのセットアップ
8.2. .zshrcの作成
9. Vimを使いやすくする
9.1. Vim-enhancedのインストール
9.2. .vimrcでVimを使いやすく</p>
<!--more-->
<h2>8. Zshを入れてデフォルトのシェルに設定する</h2>
順番的にはもう少し早くに入れても良かったんですが、セキュリティやログイン設定はこうしたパッケージをインストールする前に行いたいのでこの順番です。
<h3>8.1. Zshのセットアップ</h3>
Zshのセットアップは以下のコマンドで実行します。
<pre>$ yum install zsh
$ chsh
user のシェルを変更します。
パスワード:
新しいシェル [/bin/bash]: /bin/zsh
シェルを変更しました。
$ zsh</pre>
<h3>8.2. .zshrcの作成</h3>
Zshをインストールしたら.zshrcを設定しましょう。この設定によってシェルが非常に強力になります。
<pre>$ vi .zshrc
$ source .zshrc</pre>
Zshの振る舞いを設定する.zshrcの設定は<a title="Zshの設定プロファイルを用意する(.zprofileと.zshrc)" href="http://blog.hifumi.info/mac/zprofile-and-zshrc/">こちら</a>にもありますが、これはMac用のカスタムで（しかも私のMacはもう設定変更しちゃってる）さくらVPSで使用するにはちょっと違和感があるので、改めてZshプロファイルを記載しておきます。
<pre>#シェルの言語を日本語に設定する
export LANG=ja_JP.UTF-8

#Zshのオートコンプリートを有効にする
autoload -U compinit &amp;&amp; compinit
setopt auto_cd
setopt auto_pushd
setopt correct

#コマンド履歴と補完機能の設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

##シェルに色をつける
autoload -U colors &amp;&amp; colors

#プロンプト
PROMPT="%B%{^[[33m%}%n:%{^[[m%}%b "
PROMPT2="%B%{^[[33m%}%_%{^[[m%}%b "
SPROMPT="%BDid you mean %{^[[31m%}%r? [n,y,a,e]:%{^[[m%}%b " [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &amp;&amp; PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
RPROMPT="%{^[[34m%}[%~]%{^[[m%}"

#リスト表示の色設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1
setopt list_packed

#エイリアスコマンドの設定をする
setopt complete_aliases
alias vi='vim'
alias ll='ls -la'</pre>
#プロンプトの<span style="color: #ffff00; background-color: #333333;"><strong>^[ </strong></span>で書かれた部分は、viでCtrl-v ESCと入力します。
<h2>9. Vimを使いやすくする</h2>
Emacs派とVim派みたいな議論はよくお見かけしますが、私はなんとなく最初にVimを使い出したというだけの理由でこちらを使用しています。EmacsのキーバインドもMac使ってるのでチラホラ使用していますが、そもそもさくらVPSのターミナル上でそんなガッツリプログラミングしないので、まあ、気分みたいなものとして。
<h3>9.1. Vim-enhancedのインストール</h3>
どのリポジトリにあるのか忘れてしまいましたが、Vim-enhancedを入れます。最新の拡張機能を持つVimだ、という謳い文句ですが2011年10月現在のバージョンが7.0ということで、相当古い…お好きな方はソースインストールをお勧めします。
<pre>$ yum install vim-enhanced</pre>
これだけで完了です。さきほどの.zshrcにおいて、viと入力すればvimが反応するようにエイリアスの設定をしていますので、viでもvimでもどっちを入力しても、次回からはVim-enhancedが起動します。
<h3>9.2.  .vimrcでVimを使いやすく</h3>
Vim-enhancedがインストールされたところで、このままではまだ普通のviとなんら変わりがありません。そこで.vimrcによるvimの振る舞いを設定して、より快適にVimを使えるようにしましょう。

これから行う設定の前に、かならずユーザーのホームフォルダ以下に.vimフォルダと、.vimフォルダ以下にbackupという名前でフォルダを作成してください。vim用のバックアップフォルダに使います。
<pre>$ mkdir ~/.vim
$ mkdir ~/.vim/backup</pre>
これが済んだら、いよいよ.vimrcの作成を行いましょう。.vimrcについては<a title="vimの設定ファイル(.vimrc)を晒してみる" href="http://blog.hifumi.info/dev/vimrc/">こちらのエントリに</a>書きましたので、よろしければご参照を。

.vimrcを作成した後、ふたたびvimを起動すると、驚くほど画面が変わっているのに気づくと思います。

というわけで今回はここまで。

参考
<ul>
	<li><a title="漢のZsh" href="http://journal.mycom.co.jp/column/zsh/index.html">漢のZsh - マイコミジャーナル</a></li>
	<li><a title="Vim初心者的導入メモ 2/3 「vimrc設定」編 - ナレッジエース" href="http://blog.blueblack.net/item_110">Vim初心者的導入メモ 2/3 「vimrc設定」編 - ナレッジエース</a></li>
</ul>
