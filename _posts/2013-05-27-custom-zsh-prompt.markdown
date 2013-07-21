---
layout: post
title: ペパボエンジニア研修の近況報告と、zshのプロンプトをイイカンジにしようとした話
categories:
- Dev
- Mac
tags:
- Diary
- Mac
- Pepabo
- Zsh
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _thumbnail_id: '4636'
  _aioseop_title: ペパボエンジニア研修の近況報告と、zshのプロンプトをイイカンジにしようとした話
---
<img class="aligncenter size-full wp-image-4636" alt="sowecode" src="http://blog.hifumi.info/wp-content/uploads/2013/05/sowecode.png" width="398" height="140" />私を含めた新卒エンジニアsは、ペパボのエンジニア研修の真っ最中です。

目下の取り組みとして、全11章に及ぶ<a title="Ruby on Rails Tutorial Learn Web Development with Rails Michael Hartl" href="http://ruby.railstutorial.org/ruby-on-rails-tutorial-book?version=4.0" target="_blank">Rails Tutorial</a> (Ruby 2.0.0、Rails 4) の踏破を目指し、毎日英語とRubyに触れています。先輩社員の皆さん、いつも社内IRCでガヤガヤしててすみません。

他にも、特定の作業領域に囚われない座学を先輩社員の皆さんに開いていただいています（これは、大学で学んだことの復習としても機能しています）。２ヶ月間かけて行われる座学で、技術にとどまらず、OSSの文化であったり、ウェブの基礎知識や開発・運用等等、たくさんの座学を開いていただく予定です。…果たしてすべてを身につけ制覇することができるのか…いや頑張ります…うーんオツムドライブの容量が…脳クラウド…。

――ともかく、ソフトウェアに関する技術をあまねく理解し、開発力を身につけるべく、日々邁進しております。

はてさて、長い前置きでしたが、ここからが本題です。

<!--more-->
<h1>Rails Tutorialとターミナル</h1>
先ほど書いた『Rails Tutorial』はターミナルでの作業が中心になります。

作ってはGitHubにpushし、<strong>branch</strong>を切り、HerokuとSqaleにデプロイして…と、CLI操作がほとんどです。

特に<strong>branch</strong>を切る作業ですが、１つのGitリポジトリに対して２つも３つもbranchを切っていくので、「いま、どのbranchにいる？」と混乱しがちです。荒唐無稽なターミナルの世界において、git branchでいちいち場所を確認している時間はありません。

from nowhere to nowhereになりかねない状況を脱するべく、プロンプトのイイカンジハックを試みました。

私は<a title="Zsh" href="http://www.zsh.org/" target="_blank">Zsh</a>ユーザです。改造にあたり『<a title="漢のzsh" href="http://news.mynavi.jp/column/zsh/index.html" target="_blank">漢のzsh</a>』はもちろんのこと、branchをプロンプトへの表示方法は、下記のブログを参考にしました。
<blockquote>…研修でRails tutorialをやっているのですが，ちょくちょくGitでブランチを切る機会があります．どのブランチにいるか忘れて「git branch」しまくってるので，zshのプロンプトに表示することにしました．…

<a title="zshのプロンプトにGitのブランチ名を表示する - きたけーTechブログ" href="http://kitak.hatenablog.jp/entry/2013/05/25/103059" target="_blank">zshのプロンプトにGitのブランチ名を表示する - きたけーTechブログ</a></blockquote>
<h1>そして、こういうコードを書きました</h1>
100コメントは1コードに如かず、次のコードを.zshrcに記述しています。
<pre class="lang:default decode:true" title="prompt.zshrc">#=========##
## PROMPT ##
##=========#
autoload -U colors &amp;&amp; colors

PROMPT="%B%F{246}[%n]$%f%b "
PROMPT2="%B%F{246}%_&gt;%f%b "
SPROMPT="Did you mean %B%F{001}%r%f%b? [n,y,a,e]: "

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '%b|%a'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [ -n "$vcs_info_msg_0_" ] &amp;&amp; psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%F{038}[%f%F{077}%1(v|%1v |)%f%F{038}%~]%f"</pre>
このコードでは、次のような表示に変わります。使用環境は<a title="iTerm2 - Mac OS Terminal Replacement" href="http://www.iterm2.com/" target="_blank">iTerm2</a>のxterm-256colorで、カラースキーマは<a title="Solarized - Ethan Schoonover" href="http://ethanschoonover.com/solarized" target="_blank">Solarized</a>です。

[caption id="attachment_4660" align="aligncenter" width="620"]<img class="size-full wp-image-4660" alt="Branch Name" src="http://blog.hifumi.info/wp-content/uploads/2013/05/indicate_branch.png" width="620" height="208" /> 左にユーザ名、右にブランチ名とディレクトリ名。<br />これがイイカンジなのかよ、というMASAKARI-throwは怖いのでおひかえあそばせ…[/caption]

ここから、コードの詳細を説明します。
<h1>現在位置（ディレクトリ）を右側に表示、
Gitリポジトリがあればブランチ名も表示する</h1>
先ほどのコードから9行ほど取り出しました。この部分が、右側にディレクトリ位置と（Gitリポジトリが存在すれば）ブランチ名を表示するコードです。
<pre class="lang:default decode:true" title="プロンプト右側部分に関するコード">autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '%b|%a'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [ -n "$vcs_info_msg_0_" ] &amp;&amp; psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%F{038}[%f%F{077}%1(v|%1v |)%f%F{038}%~]%f"</pre>
まずはautoloadです。ここではvcs_infoというバージョン管理情報を取得する関数を呼び出しています。
<pre class="lang:default decode:true">autoload -Uz vcs_info</pre>
次は要であるブランチ表記です。formatsは通常時に使用される表示フォーマットです。%bが現在のブランチ情報に対応しています。actionformatsはrebaseやmergeの衝突のような特殊操作をする際の表示フォーマットです。%aはそのaction名に対応しています。
<pre class="lang:default decode:true">zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '%b|%a'</pre>
precmdはプロンプトの開始前に実行されるコマンドを記述できます。precmdコマンドは各コマンドラインが表示される毎に一度ずつ実行されます（.zshrc内などに２個以上precmdを書くと、最初の１つしか実行されないため、自前で関数を用意し、preexec_functions等で１つにまとめるのがベターかもしれません）。

この関数のなかでは、「リポジトリが見つかれば、その情報を取ってくる」コードが実行されるようになっています。
<pre class="lang:default decode:true">precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [ -n "$vcs_info_msg_0_" ] &amp;&amp; psvar[1]="$vcs_info_msg_0_"
}</pre>
RPROMPTはzshの右側に情報を表示するディレクティブです。見づらいのですが、<span class="crayon-inline">%F{***}〜%f</span>は色表示をするコードです。<span class="crayon-inline">%1(v|%1v |)</span>がブランチ名の表示、<span class="crayon-inline">%~</span>の部分が現在のディレクトリ位置を表示するためのコードです。
<pre class="lang:default decode:true">RPROMPT="%F{038}[%f%F{077}%1(v|%1v |)%f%F{038}%~]%f"</pre>
また、PROMPTとPROMPT2、SPROMPTは左側のプロンプト表示に関わるディレクティブで、自分のアカウント名を角括弧つきで表示するようにしています。記述方法はほとんど一緒で、PROMPTが通常表示、PROMPT2が複数行のコードを入力するときの２行目以降の表示、SPROMPTはコマンドを打ち間違えた際のサジェストの表示です。

Zshに限らず、ターミナルでの作業が中心の場合、レイアウトはモチベーションを保つ必要不可欠な要素だと思っています。何も手を加えないラフなスタイルも然もありなん、時間のかかりすぎない程度にちょっと手を加えてみるのも乙なものではないでしょうか。

続き ⇒ <a title="Zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜" href="http://blog.hifumi.info/dev/zsh-morimori-diary-1/" target="_blank">zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜</a>
<h1>参考</h1>
<ul>
	<li><a title="zshのプロンプトにGitのブランチ名を表示する - きたけーTechブログ" href="http://kitak.hatenablog.jp/entry/2013/05/25/103059" target="_blank">zshのプロンプトにGitのブランチ名を表示する - きたけーTechブログ</a></li>
	<li><a title="Manual Reference Pages  - ZSHCONTRIB (1) - FreeBSD Man Pages" href="http://www.gsp.com/cgi-bin/man.cgi?section=1&amp;topic=zshcontrib" target="_blank">Manual Reference Pages  - ZSHCONTRIB (1) - FreeBSD Man Pages</a></li>
	<li><a title="【コラム】漢のzsh (9) 世界はモノクロからカラーへ | 開発・SE | マイナビニュース" href="http://news.mynavi.jp/column/zsh/009/index.html" target="_blank">【コラム】漢のzsh (9) 世界はモノクロからカラーへ | 開発・SE | マイナビニュース</a></li>
	<li><a title="yonchu / shell-color-pallet - GitHub" href="https://github.com/yonchu/shell-color-pallet" target="_blank">yonchu / shell-color-pallet • GitHub</a></li>
</ul>
