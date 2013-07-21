---
layout: post
title: Zshの設定プロファイル(.zprofileと.zshrc)
categories:
- Dev
- Mac
tags:
- Homebrew
- Mac
- Zsh
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/Lxk5dk
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/mac/zprofile-and-zshrc/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:1:{i:0;s:183:"【ブログ更新】 Zshの設定プロファイルを用意する(.zprofileと.zshrc) http://bit.ly/Lxk5dk
    - MacやさくらVPS等のターミナルではシェルにZshを愛用し";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '3429'
  _aioseop_keywords: Mac,Zsh,Homebrew
  _aioseop_description: Zshの設定プロファイル(.zprofileと.zshrc)の参考例、およびMacでHomebrewを用いてzshを導入する方法。
  _aioseop_title: Zshの設定プロファイル(.zprofileと.zshrc)
  dsq_thread_id: '1224399428'
---
<a href="http://blog.hifumi.info/wp-content/uploads/2013/01/z-e1358587492148.png"><img class="size-full wp-image-3429 aligncenter" style="margin-top: 0px; margin-bottom: 0px; border: 0px; padding: 0px;" alt="z" src="http://blog.hifumi.info/wp-content/uploads/2013/01/z-e1358587492148.png" width="700" height="200" /></a>

普段のちょっとした作業にシェルを使うとシンプルの中にある強力な機能に驚くことが多々あります。なかでもZshは素晴らしい。自動補完やPATHの指定などをキチンと設定しておかないとBash等と大差の無いままですが、設定ファイルを利用することで非常に強力な機能を有することができます。

（Zshの場合は<a href="https://github.com/robbyrussell/oh-my-zsh" target="_blank">oh-my-zsh</a>という便利機能一括パッケージがありますので、そちらを導入するのも手かもしれません）。

<!--more-->

zsh設定プロファイルにも色々あると思うのですが、アーカイブとしての意味も込めて、自分用の設定ファイルを掲載しておきます。
<h1>.zprofileと.zshrc</h1>
以下のコードは~/.zprofileと~/.zshrcの設定ファイルです。それぞれ<strong>環境変数の設定、それ以外の基本設定</strong>と用途別にしています（分けなくても普通に動きますが、整理のためです）。

.zprofileはログインシェルとしてzshが起動した際にのみ呼ばれる設定ファイルで、色やPATH等の環境変数は何度もsource ~/.zshrcで呼ぶ必要もないので、そちらに書いています。他にも.zshenvや.zloginなども設定ファイルとして作成可能ですが、特に.zshenvはZshが起動されたら必ず呼ばれる仕様になっていたりするので、そうそう記述するものではないと思います。

設定ファイルの読み込みタイミングについては、（英語ですが）<a title="A User's Guide to the Z-Shell" href="http://zsh.sourceforge.net/Guide/zshguide02.html" target="_blank">こちらの2.2: All the startup files</a>に書いてありますので、気になる方はご参照ください。
<pre class="lang:default decode:true" title=".zprofile"># 言語設定
export LANG=ja_JP.UTF-8

# カラー設定
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# gnuplot等のグラフ出力先をX11に指定
export GNUTERM=x11

# Homebrew用PATH指定
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/local/share/python:$PATH

# TeXLive用PATH指定
export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-darwin

# Cabal(Haskell)用設定
export PATH=$PATH:$HOME/.cabal/bin

# rbenv,phpenv用設定
export PATH=$HOME/.phpenv/bin:$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH

# JAVA用PATH指定
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

# NODEBREW用PATH指定
export PATH=$HOME/.nodebrew/current/bin:$PATH
export NODEBREW_ROOT=$HOME/.nodebrew

# PYTHON用設定（pythonbrewを使用）
export PYTHONPATH=$HOME/.pythonbrew/current:$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
export WORKON_HOME=$HOME/.virtualenvs

# perlbrew用環境設定
export PATH=$PATH:$HOME/perl5/perlbrew/bin/</pre>
<pre class="lang:default decode:true" title=".zshrc">#=================##
## File Operation ##
##=================#
autoload -U compinit &amp;&amp; compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt nobeep
setopt prompt_subst
setopt list_packed
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

#=========##
## PROMPT ##
##=========#
autoload -U colors &amp;&amp; colors
PROMPT="%B%{^[[33m%}%n:%{^[[m%}%b "
PROMPT2="%B%{^[[33m%}%_%{^[[m%}%b "
SPROMPT="%BDid you mean %{^[[31m%}%r? [n,y,a,e]:%{^[[m%}%b "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &amp;&amp; PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
RPROMPT="%{^[[34m%}[%~]%{^[[m%}"

#==========##
## HISTORY ##
##==========#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt hist_ignore_dups #ignore duplication command history list
setopt share_history    #share command history data
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#================##
## ALIAS COMMAND ##
##================#
setopt complete_aliases
alias ls="ls -G -w -h"
alias la="ls -a"
alias lf="ls -F"
alias ll="la -lh"
alias du="du -h"
alias df="df -h"
alias -s txt=lv
alias -s md=lv
alias -s markdown=lv
alias -s xml=lv
alias vi="vim"
alias bup="brew update"
alias brug="brew upgrade"
alias bs="brew -S"
alias bi="brew info"

#================================##
## Version Control for Languages ##
##================================#
# rbenv
if which rbenv &gt; /dev/null; then
    eval "$(rbenv init - zsh)"
    source "`brew --prefix rbenv`/completions/rbenv.zsh"
fi

# phpenv
if which phpenv &gt; /dev/null; then
    eval "$(phpenv init - zsh)"
    source "$HOME/.phpenv/completions/rbenv.zsh"
fi

# perlbrew
if which perlbrew &gt; /dev/null; then
    source "$HOME/perl5/perlbrew/etc/bashrc"
fi

# pythonbrew
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] &amp;&amp; . "$HOME/.pythonbrew/etc/bashrc"

#==================##
## zsh-completions ##
##==================#
fpath=(/usr/local/share/zsh-completions $fpath)

#================================##
## source zsh-syntax-highlighting #
##================================#
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &amp;&amp; . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#====##
## z ##
##====#
source ~/.zsh/z.sh
precmd() {
    _z --add "$(pwd -P)"
}</pre>
<h2>エスケープ文字^[の入力方法</h2>
# PROMPT(16-20行)に表示されている^[ はエスケープ文字という特殊文字であり、この入力方法はエディタによって異なります。以下、viとEmacsの場合について紹介します。
<h3>viの場合</h3>
<pre class="toolbar:2 lang:default decode:true">Control + v → Esc</pre>
<h3>Emacsの場合</h3>
<pre class="toolbar:2 lang:default decode:true">Control + q → Esc</pre>
<h1>Mac、Zsh、Homebrew</h1>
MacでZshを使う場合は<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/">Homebrew</a>から最新版であるZsh 5.x系を使っています。また、Zshの自動補完の補填パッケージの<a href="https://github.com/zsh-users/zsh-completions" target="_blank">zsh-completions</a>も導入します。
<pre class="lang:default decode:true" title="zsh install">brew install zsh zsh-completions
echo 'fpath=(/usr/local/share/zsh-completions $fpath)' &gt;&gt; ~/.zshrc
rm -f ~/.zcompdump; compinit</pre>
また、Homebrewから入れたZshを標準で使うシェルに設定するためには、起動パスの設定を変更しましょう。

[caption id="attachment_3296" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2011/10/startup.png"><img class="size-medium wp-image-3296" alt="シェルの起動パスを/usr/local/bin/zshに" src="http://blog.hifumi.info/wp-content/uploads/2011/10/startup-400x335.png" width="400" height="335" /></a> シェルの起動パスを/usr/local/bin/zshに[/caption]

Command + 'で、設定パネルを呼び出し、絶対パスで/usr/local/bin/zshと入力。すると次回以降のターミナルの起動ではHomebrewから入れたZshが有効になります。
<h1>zsh-syntax-highlighting</h1>
こちらの<a href="http://blog.glidenote.com/blog/2012/12/15/zsh-syntax-highlighting/" target="_blank">zsh-syntax-highlightingでコマンドラインにsyntax Highlightを効かす</a>のブログ記事で紹介されていた、zshのコマンド入力に反応してシンタックスカラーリングしてくれるプラグインが便利そうだったので導入。
<h2><a href="https://github.com/zsh-users/zsh-syntax-highlighting" target="_blank">zsh-users / zsh-syntax-highlighting</a></h2>
やり方は<a href="http://blog.glidenote.com/blog/2012/12/15/zsh-syntax-highlighting/" target="_blank">先のブログ記事</a>と全く同じです。
<pre class="lang:default decode:true" title="zsh-syntax-highlighting">mkdir ~/.zsh
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
source ~/.zshrc</pre>
私はoh-my-zshを使用していないので、.zshディレクトリを作成しそこに今回のプラグインをダウンロード（oh-my-zshではpluginディレクトリにダウンロードすればいいようです）。
