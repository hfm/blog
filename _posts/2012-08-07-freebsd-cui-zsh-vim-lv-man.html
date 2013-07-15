---
layout: post
title: FreeBSDのCUI日本語環境を整える（Zsh/Vim/Lv/Man）
categories:
- Dev
tags:
- FreeBSD
- vim
- Zsh
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/MJGbVU
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/dev/freebsd-cui-zsh-vim-lv-man/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: "a:2:{i:0;s:183:\"【ブログ更新】 FreeBSDのCUI環境を整える（Zsh/Vim/Lv/Man） http://bit.ly/MJGbVU
    - ログイン時の言語・文字コードを指定する\r\nホームディレクトリ\";i:1;s:161:\"【ブログ編集】 FreeBSDのCUI環境を整える（Zsh/Vim/Lv/Man）
    http://bit.ly/MJGbVU - サーバ用途でFreeBSDを利用する場合には、ターミ\";}"
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '3505'
  _aioseop_keywords: FreeBSD,Vim,Zsh,Lv,Man,日本語化,サーバ,CUI,jman
  _aioseop_description: FreeBSDのCUI周りを出来るだけ日本語化して、なるべく日本語で読める環境を構築していく流れについて書いていきたいと思います。
  _aioseop_title: FreeBSDのCUI日本語環境を整える（Zsh/Vim/Lv/Man）
  dsq_thread_id: '1224855600'
  dsq_needs_sync: '1'
---
<p style="text-align: center;"><a href="http://blog.hifumi.info/wp-content/uploads/2012/08/svps.png"><img class="aligncenter size-large wp-image-3505" style="border: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px;" alt="sakuraVPS with FreeBSD" src="http://blog.hifumi.info/wp-content/uploads/2012/08/svps-700x150.png" width="700" height="150" /></a></p>
サーバ用途でFreeBSDやLinux/Unixを利用する場合、特にさくらVPS等のレンタルサーバでは専ら操作はターミナルから、つまりCUI(character-based user interface)環境になると思います。

ただ、サーバというものは基本的には英語環境で、ちょっとした調べ物やmanコマンドでヘルプを参照したい時ですら、いちいち英語と格闘しなければならず、日本人にとっては結構なデメリットになっていると思います（とはいえ情報量の多さは英語圏が圧倒的なので、慣れた方がいいのですが。。。）

さて、今回はそんなFreeBSDのCUI周りを出来るだけ日本語化して、なるべく日本語で読める環境を構築していく流れについて書いていきたいと思います。
<!--more-->
<h1>目次</h1>
<ul>
	<li><a href="#lang_char">ログイン時の言語・文字コードを指定する</a></li>
	<li><a href="#zshinstall">PortsからZshをインストールする</a>
<ul>
	<li><a href="#zshrc">.zshrcを設定する</a></li>
</ul>
</li>
	<li><a href="#viminstall">Portsからvim-liteをインストールする</a>
<ul>
	<li><a href="#vimrc">.vimrcを設定する</a></li>
</ul>
</li>
	<li><a href="#jman">日本語Man環境を整える</a>
<ul>
	<li><a href="#lvjmaninstall">Lvとjmanをインストールする</a></li>
	<li><a href="#manpath">manpathを設定する</a></li>
	<li><a href="#mojibake">おまけ１：FreeBSD 9.0のマニュアルの文字化け対策</a></li>
	<li><a href="#mojibake2">おまけ２：↑のおまけ１をやっても上手くいかない時</a></li>
</ul>
</li>
	<li><a href="#refs">参考</a></li>
</ul>
<h1><a name="lang_char"></a>ログイン時の言語・文字コードを指定する</h1>
ホームディレクトリにある.login_confを修正して、日本語UTF8な環境を作成しましょう。
<pre>$ vi .login_conf
me:\
    :charset=UTF-8:\
    :lang=ja_JP.UTF-8:</pre>
これで日本語＋UTF-8の環境でログインできるようになりました。
<h1><a name="zshinstall"></a>PortsからZshをインストールする</h1>
FreeBSDの標準シェルはCshですが、強力なZshが欲しいのでPortsからインストールします。
<pre class="lang:default decode:true">$ cd /usr/ports/shells/zsh
$ make BATCH=yes install clean
$ rehash
$ chsh -s zsh
Password: ****
chsh: user information updated</pre>
最後の<span class="crayon-inline crayon-selected">chsh -s</span>コマンドを使って標準シェルをZshに指定します。
<h2><a name="zshrc"></a>.zshrcを設定する</h2>
環境変数に関しては、.zprofileを別途用意してそこに書き込み、.zshrcと分けるという管理方法もありだと思いますが、今回は分かりやすさ重視のため、.zshrc１つです。

ホームディレクトリに.zshrcというファイルを作成し、そこに以下のような記述をします。
※ただし、以下の.zshrcの設定はxterm-256colorの黒背景を前提としています。
<pre class="lang:default decode:true" title=".zshrc">#環境変数
export LANG=ja_JP.UTF-8     #シェルの言語は日本語utf8
export LC_CTYPE=ja_JP.UTF-8 #ロケールは日本語utf8
export EDITOR=vim           #標準エディタはvim
export PAGER=lv             #標準ページャはlv
export LV=-Ou8              #lvの出力はutf8
export LSCOLORS=ExFxCxdxBxegedabagacad #lsコマンドの配色
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30' #glsコマンドの配色

#ターミナル操作
autoload -U compinit &amp;&amp; compinit #自動補完の有効化
autoload -U colors &amp;&amp; colors     #プロンプトの色付け
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1 #補完候補を矢印キーで移動する
setopt auto_cd           #ディレクトリ名でcdできるようにする
setopt auto_pushd        #cd -[tab]で移動履歴を表示する
setopt correct           #誤入力すると正しいコマンドをサジェストする
setopt nobeep            #ビープ音を鳴らさない
setopt magic_equal_subst #--prefix=等のイコール後のパスを補完する
setopt list_packed       #lsコマンドの結果を通常より詰めて表示する
bindkey -e #Emacsキーバインドの指定

#プロンプト（特殊キー ^[ は Ctr-v Esc で入力する）
setopt prompt_subst #プロンプトの拡張
PROMPT="%B%{^[[33m%}%n:%{^[[m%}%b " #[host user:]と表示する
PROMPT2="%B%{^[[33m%}%_%{^[[m%}%b "
SPROMPT="%BDid you mean %{^[[31m%}%r? [n,y,a,e]:%{^[[m%}%b "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &amp;&amp; PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
RPROMPT="%{^[[34m%}[%~]%{^[[m%}"     #右側にカレントディレクトリを表示する

#履歴
HISTFILE=~/.zsh_history     #履歴のディレクトリ
HISTSIZE=10000              #履歴最大サイズ
SAVEHIST=10000              #保存数
setopt   hist_ignore_dups   #重複するコマンドを履歴に残さない
setopt   share_history      #コマンド履歴を複数ターミナルで共有する
autoload history-search-end #コマンド履歴検索の有効化
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
bindkey "^P" history-beginning-search-backward-end #Ctr-p で履歴の前コマンドを表示
bindkey "^N" history-beginning-search-forward-end  #Ctr-n で履歴の次コマンドを表示

#エイリアス
setopt complete_aliases
alias j="jobs -l"
alias ls="ls -G -w"
alias ll="la -l"
alias du="du -h"
alias df="df -h"
alias vi="vim"       #viと押せばvim起動
alias jman="env LC_CTYPE=ja_JP.eucJP GROFF_NO_SGR=true jman"
alias -s txt=lv      #txtファイルを指定するとlv
alias -s xml=lv      #xmlファイルを指定するとlv
alias -s conf=lv     #confファイルを指定するとlv
alias -s cnf=lv      #cnfファイルを指定するとlv
alias -s ini=lv      #iniファイルを指定するとlv
alias -s md=lv       #mdファイルを指定するとlv
alias -s markdown=lv #markdownファイルを指定するとlv</pre>
<h1><a name="viminstall"></a>Portsからvim-liteをインストールする</h1>
PortsにあるvimはX環境を想定しており、CUI環境には余計なものがインストールされてしまいます。そこで普通はvimをmakeするときにWITHOUT_X11=yesのオプションをつけたり、X環境の入っていないvim-liteをインストール。今回は後者のvim-liteをインストールします。
<pre>$ cd /usr/ports/editors/vim-lite
$ make BATCH=yes install clean
$ rehash</pre>
<h2><a name="vimrc"></a>.vimrcを設定する</h2>
内容は以前書いた<a title="vimの設定ファイル(.vimrc)を晒してみる" href="http://blog.hifumi.info/dev/vimrc/">《vimの設定ファイル(.vimrc)を晒してみる》</a>と同じです。
<pre class="lang:default decode:true" title=".vimrc">" BEGIN NeoBundle
set nocompatible "Vi互換をオフにしてVimの機能を有効化する
filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

"" NeoBundle経由で入れたいGitHub由来のパッケージリスト
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'wannesm/wmgraphviz.vim'

filetype plugin indent on
" END NeoBundle

" BEGIN ファイル操作
set encoding = UTF-8 "標準文字コードをUTF-8に指定する
set hidden           "ファイル変更中でも他のファイルを開けるようにする
set autoread         "ファイル内容が変更されると自動読み込みする
" END ファイル操作

" BEGIN インデント
set cindent         "C言語のインデントに従って高度な自動インデントを行う
set expandtab       "Tabの代わりにSpaceを挿入する。Tabを打つ時は'Ctr-V Tab'。
set smarttab        "行頭の余白内でTabを打ち込むと、'shiftwidth'の数だけインデントする
set shiftwidth  = 4
set tabstop     = 4 "タブの文字数を設定する
set softtabstop = 4 "ファイル内のTabが対応する空白の数
" END インデント

" BEGIN バックアップ
set backupdir = $HOME/.vim/backup "バックアップ先を指定する
set directory = $HOME/.vim/backup "スワップファイル先を指定する
set browsedir = buffer            "ファイル保存ダイアログの初期位置をバッファファイル先に指定する
set history   = 1000              "履歴数
" END バックアップ

" BEGIN 検索
set incsearch  "インクリメンタルサーチを行う
set hlsearch   "検索結果をハイライトする
set ignorecase "検索時に文字の大小を区別しない
set smartcase  "検索時に大文字を含んでいたら大小を区別する
set wrapscan   "検索をファイルの先頭へループする
" END 検索

" BEGIN 入力操作
"" 挿入モード中に'Ctr-*'でコマンドモードでの移動・削除を可能にする
inoremap &lt;c-d&gt; &lt;delete&gt;
inoremap &lt;c-j&gt; &lt;down&gt;
inoremap &lt;c-k&gt; &lt;up&gt;
inoremap &lt;c-h&gt; &lt;left&gt;
inoremap &lt;c-l&gt; &lt;right&gt;
set backspace = indent,eol,start
set whichwrap = b,s,h,l,&lt;,&gt;,[,] "カーソルを行頭、行末で止まらないようにする
" END 入力操作

" BEGIN 画面表示
colorscheme desert "Vimの色設定
syntax on          "シンタックスカラーリングを設定する
set laststatus = 2 "ステータスラインを常に表示する
set number         "行番号を表示する
set title          "編集中のファイル名を表示する
set showcmd        "入力中のコマンドを表示する
set ruler          "ルーラーを表示する
set showmatch      "閉じ括弧の入力時に対応する括弧を表示する
set matchtime  = 3 "showmatchの表示時間
set list           "タブ、行末等の不可視文字を表示する
set listchars=eol:$,tab:&gt;\ ,extends:&lt; "listで表示される文字のフォーマットを指定する
" END 画面表示

" BEGIN NeoComplcache
let g:neocomplcache_enable_at_startup = 1            "NeoComplcacheを自動起動する
let g:neocomplcache_enable_smart_case = 1            "大文字が入力されるまで大小を無視する
let g:neocomplcache_enable_underbar_completion = 1   "_(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_camel_case_completion = 1 "キャメルケース区切りの補完を有効化
let g:neocomplcache_max_list = 20                    "ポップアップメニューの表示候補数
let g:neocomplcache_min_syntax_length = 3            "シンタックスキャッシュの最小文字長
"" Tabで補完候補の選択を行う
inoremap &lt;expr&gt;&lt;TAB&gt;   pumvisible() ? "\&lt;Down&gt;" : "\&lt;TAB&gt;"
inoremap &lt;expr&gt;&lt;S-TAB&gt; pumvisible() ? "\&lt;Up&gt;"   : "\&lt;S-TAB&gt;"
"" 改行、削除キーで補完ウィンドウを閉じる
inoremap &lt;expr&gt;&lt;CR&gt;  neocomplcache#smart_close_popup() . "\&lt;CR&gt;"
inoremap &lt;expr&gt;&lt;C-h&gt; neocomplcache#smart_close_popup() . "\&lt;C-h&gt;"
inoremap &lt;expr&gt;&lt;BS&gt;  neocomplcache#smart_close_popup() . "\&lt;C-h&gt;"
inoremap &lt;expr&gt;&lt;C-y&gt; neocomplcache#close_popup()  " 選択候補を確定する
inoremap &lt;expr&gt;&lt;C-e&gt; neocomplcache#cancel_popup() " 選択候補をキャンセルする
" END NeoComplcache</pre>
<h1><a name="jman"></a>日本語Man環境を整える</h1>
ZshとVimの設定が終わったら日本語マニュアル関連コマンド群のインストールを行いましょう。
<h2><a name="lvjmaninstall"></a>Lvとjmanをインストールする</h2>
Portsのjapaneseディレクトリにあるmanとman-docを入れます。
<pre>cd /usr/ports/misc/lv
make BATCH=yes install clean
cd /usr/ports/japanese/man
make BATCH=yes install clean
cd /usr/ports/japanese/man-doc
make BATCH=yes install clean
rehash</pre>
《where jman》でパスが表示されればインストール完了です。
<h2><a name="manpath"></a>manpathを設定する</h2>
jmanには/etcにmanpath.configというファイルが必要です。
<pre>$ vi /etc/manpath.config
#MANPATH_MAP path_element manpath_element
MANPATH_MAP    /bin              /usr/share/man
MANPATH_MAP    /usr/bin          /usr/share/man
MANPATH_MAP    /usr/bin          /usr/share/openssl/man
MANPATH_MAP    /usr/local/bin    /usr/local/man</pre>
ここまで設定して、
<pre>jman jman</pre>
でjmanに関しての日本語ドキュメントが化けずに表示されれば完成です。

Unix/Linuxを使用する以上、英語で読むのも大切かと思いますが、わたしは<a title="Standing on the shoulders of giants - WikiPedia English" href="http://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants" target="_blank">巨人の肩の上に立つ</a>気持ちで先人が作った日本語docをありがたく読むことにします。。。ϵ( 'ω' )϶
<h2><a name="mojibake"></a>おまけ１：FreeBSD 9.0のマニュアルの文字化け対策</h2>
どうやらFreeBSD 9.0には以下の様な仕様変更に基づく問題があるようです。
<blockquote>FreeBSD 9.0(10/24時点では9.0-RC1)ではオンラインマニュアルの整形関係の処理が変更されたらしく，portsからインストールしたjmanコマンドを用いて英文のマニュアルを整形すると以下のように書体変更のためのエスケープ文字がそのまま出力されてしまうことがあります．
<pre>1mNAME0m</pre>
</blockquote>
現状では環境変数を《GROFF_NO_SGR=true》とする解決策があるようですが、.zshrcにexportして書くのもあまり宜しくないらしいので、以下の様なエイリアスを用意しました。
<pre>alias jman="env LC_CTYPE=ja_JP.eucJP GROFF_NO_SGR=true jman"</pre>
なお、このアイリアスは上記の.zshrcに既に記述されています。
<h2><a name="mojibake2"></a>おまけ２：↑のおまけ１をやっても上手くいかない時</h2>
以下のディレクトリの中にある**.*.gzファイルを全て削除してください。手動でrmし続ける作業になりますが、これらはキャッシュのようなもので、これを消さない限りmanページは再度生成されません。
<pre>/usr/local/man/
├── cat1
├── ...
├── cat9
├── catl
├── catn
└── ja
    ├── cat1
    ├── ...
    ├── cat9
    ├── catl
    └── catn</pre>
<h1><a name="refs"></a>参考</h1>
<ul>
	<li><a href="http://news.mynavi.jp/column/zsh/index.html" target="_blank">漢のzsh｜コラム｜エンタープライズ｜マイナビニュース</a></li>
	<li><a title="2. 入手方法と使い方 - Japanese Manual Project for FreeBSD(How to use)" href="http://www.jp.freebsd.org/man-jp/howto.html" target="_blank">2. 入手方法と使い方 - Japanese Manual Project for FreeBSD(How to use)</a></li>
	<li><a title="FreeBSD/Ports/Japanese/jman - Cocelo Style" href="http://cocelo.s201.xrea.com/freebsd/index.php?FreeBSD%2FPorts%2FJapanese%2Fjman" target="_blank">FreeBSD/Ports/Japanese/jman - Cocelo Style</a></li>
	<li><a title="FreeBSDで日本語環境（UTF-8対応）を整える - レンタルサーバー・自宅サーバーの設定・構築のヒント" href="http://sakura.off-soft.net/freebsd/freebsd_japanease.html" target="_blank">FreeBSDで日本語環境（UTF-8対応）を整える - レンタルサーバー•自宅サーバーの設定•構築のヒント</a></li>
	<li><a title="jmanで日本語マニュアルが読めない…… - night and sundial" href="http://d.hatena.ne.jp/mohri/20041215/jless" target="_blank">jmanで日本語マニュアルが読めない…… - night and sundial</a></li>
	<li><a title="FreeBSD 9.0のマニュアルの文字化け対策 - 石樂庵" href="http://d.hatena.ne.jp/pebblescabin/20111024/1319452009" target="_blank">FreeBSD 9.0のマニュアルの文字化け対策 - 石樂庵</a></li>
</ul>
[amazon asin=4774150479&amp;template=iframe image&amp;chan=default]
