---
layout: post
title: Zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜
categories:
- Dev
tags:
- Terminal
- tmux
- Zsh
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _thumbnail_id: '4701'
  _aioseop_keywords: Zsh,tmux,development,terminal
  _aioseop_description: Zshのプロンプトにtmuxのウィンドウ番号／ペイン番号を表示させるための方法。
  _aioseop_title: Zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜
  _oembed_2aebf2380da4663c049f212d9723ed3a: <iframe allowfullscreen="true" allowtransparency="true"
    frameborder="0" height="438" id="talk_frame_14711" mozallowfullscreen="true" src="//speakerdeck.com/player/4ffa76bf73934c0001004c44"
    style="border:0; padding:0; margin:0; background:transparent;" webkitallowfullscreen="true"
    width="500"></iframe>
  _oembed_708d00d4b7535a8ff53afedce35b157f: <blockquote class="twitter-tweet" width="500"><p>exportしないで
    $() を使ってPROMPTに直接コマンドを埋め込んだ方が楽かと。 / Zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜 | Kitchen
    Garden Blog <a href="https://twitter.com/hfm">@hfm</a> <a href="http://t.co/NyiWNxB25P">http://t.co/NyiWNxB25P</a></p>&mdash;
    Yonchu (@yuyuchu3333) <a href="https://twitter.com/yuyuchu3333/statuses/340794254341324800">June
    1, 2013</a></blockquote><script async src="//platform.twitter.com/widgets.js"
    charset="utf-8"></script>
---
<h1>〜前回のあらすじ〜</h1>
ターミナルから git checkout (-b) したり git branch -d &lt;BRANCH&gt; したり git merge &lt;BRANCH&gt; したりすることが多くなり、Zshのプロンプトにブランチ名やmergeなどのaction名を表示させようと奮起しました。
<blockquote>…作ってはGitHubにpushし、branchを切り、HerokuとSqaleにデプロイして…と、CLI操作がほとんどです。…

<a title="ペパボエンジニア研修の近況報告と、zshのプロンプトをイイカンジにしようとした話" href="http://blog.hifumi.info/mac/custom-zsh-prompt/" target="_blank">ペパボエンジニア研修の近況報告と、zshのプロンプトをイイカンジにしようとした話</a></blockquote>
<!--more-->

今回は、それに加えて次の機能を目指します。
<h1>tmuxのウィンドウ／ペイン番号を表示</h1>
<h2>tmuxについて</h2>
tmuxについての説明は次のスライドが参考になります。

https://speakerdeck.com/chocoby/tmux

Macユーザは<span class="crayon-inline">brew install tmux</span>でインストール可能です。
<h2>スクリプト</h2>
Zshのプロンプトにtmuxのウィンドウ／ペイン番号を表示するよう.zshrcをカスタマイズしました。11, 28, 33行目のディレクティブがtmuxに関する設定です。
<pre class="lang:default mark:11,28,33 decode:true" title="prompt.zshrc">#=========##
## PROMPT ##
##=========#
autoload -U colors &amp;&amp; colors
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

function _for_prompt() {
    # &gt;&gt; http://yonchu.hatenablog.com/entry/20120413/1334341553
    # set tmux window
    [ "$TMUX" ] &amp;&amp; export TMUX_WINDOW=$(tmux display -p '#I-#P')

    # &gt;&gt; http://www.slideshare.net/tetutaro/zsh-20923001
    # set git branch-name
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}
add-zsh-hook precmd _for_prompt

# &gt;&gt; http://kitak.hatenablog.jp/entry/2013/05/25/103059
zstyle ':vcs_info:*' enable git svn cvs
zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'

local p_info="%n@%m" # user and machine name
local p_tmux="${TMUX_WINDOW:+[$TMUX_WINDOW]}" # tmux
local p_giti="%077F%1(v|%1v |)%f" # git
local p_cdir="%038F[%~]%f" # current dir
local p_comd="%B%001F%r%f%b" # suggest command

PROMPT="$p_info$p_tmux %B$%b "
PROMPT2="%_&gt; "
SPROMPT="Did you mean $p_comd? [n,y,a,e]: "
RPROMPT="$p_giti$p_cdir"</pre>
↑この結果、

↓こうなります。左側の[1-0]がtmuxのウィンドウ番号とペイン番号です。

[caption id="attachment_4701" align="aligncenter" width="656"]<img class="size-full wp-image-4701" alt="ver. 2013.6.1" src="http://blog.hifumi.info/wp-content/uploads/2013/06/zshprompt.png" width="656" height="260" /> ver. 2013.6.1 (tmux-powerlineというスクリプトを入れているのですが、ウィンドウを小さくしすぎたため表示されず…)[/caption]
<h2>$TMUXと$TMUX_WINDOW</h2>
$TMUXはtmux起動時にのみ設定される環境変数です。

tmuxを起動していなければ$TMUXはnullのため、「もし$TMUXが存在すれば$TMUX_WINDOWという環境変数にtmuxのウィンドウ番号とペイン番号を格納する」という設定をしています。
<pre class="lang:default decode:true" title="$TMUX_WINDOW">[ "$TMUX" ] &amp;&amp; export TMUX_WINDOW=$(tmux display -p '#I-#P')</pre>
local変数の$p_tmuxに、先ほどの$TMUX_WINDOWという変数がnullでなければ、<span class="crayon-inline">[tmux-window-num]-[tmux-pane-num]</span>というフォーマットの値を代入し、PROMPTに表示します。

これによって、tmuxを起動しているときだけ左プロンプトにtmuxのウィンドウ／ペイン番号を表示させ、not tmux環境では表示させないように出来ます。
<pre class="lang:default decode:true" title="$TMUX_WINDOW">local p_tmux="${TMUX_WINDOW:+[$TMUX_WINDOW]}" # tmux
PROMPT="$p_info$p_tmux %B$%b "</pre>
<h1>追記 (2013.6.1 22:05)</h1>
エントリの公開後、参考にしていたブログ主様から次のようなアドバイスをいただきました。

https://twitter.com/yuyuchu3333/status/340794254341324800

これに伴い、コードを一部改変しました。
<pre class="lang:default decode:true">PROMPT='%n@%m'
PROMPT+='$([ -n "$TMUX" ] &amp;&amp; tmux display -p "[#I-#P]")'
PROMPT+=' %B$%b '</pre>
<span class="crayon-inline">function _for_prompt()</span>の中にあったtmuxに関する設定と<span class="crayon-inline crayon-selected">local p_tmux</span>をまるごと削除し、<span class="crayon-inline">PROMPT+=</span>に移植。行数の削減やコードがひとまとまりになって分かりやすくなりました。

この調子でZshの設定等もカスタマイズしていきたいです。
<h1>参考</h1>
<ul>
	<li><a title="zshのプロンプトにGitのブランチ名を表示する" href="http://kitak.hatenablog.jp/entry/2013/05/25/103059" target="_blank">zshのプロンプトにGitのブランチ名を表示する</a></li>
	<li><a title="Zshでデキるプロンプト" href="http://www.slideshare.net/tetutaro/zsh-20923001" target="_blank">Zshでデキるプロンプト</a></li>
	<li><a title="zshのプロンプトにtmuxのウィンドウ番号とペイン番号を表示" href="http://yonchu.hatenablog.com/entry/20120413/1334341553" target="_blank">zshのプロンプトにtmuxのウィンドウ番号とペイン番号を表示</a></li>
</ul>
