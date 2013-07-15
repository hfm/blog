---
layout: post
title: Zsh成長日記そのニ〜gitのstash数を表示させる〜
categories:
- Dev
tags:
- Git
- Terminal
- Zsh
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: Zsh,git,development,terminal
  _aioseop_description: gitのstash数をzshのプロンプトに表示するにあたって、git stashの簡単な説明と実際に表示するためのコードを紹介しています。
  _aioseop_title: Zsh成長日記そのニ〜gitのstash数を表示させる〜
---
<h2>〜前回までのあらすじ〜</h2>
gitのbranch／action名を右プロンプトに表示させたり、tmuxのウィンドウ／ペイン番号を表示させりするため、.zshrcにあれこれ追記しました。

<a title="Zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜" href="http://blog.hifumi.info/dev/zsh-morimori-diary-1/" target="_blank">Zsh成長日記そのイチ〜tmuxのウィンドウ／ペイン番号を表示させよう〜</a>

<!--more-->

今回は、それに加えてgitのstash数の表示を目指します。
<h1>git stashと、dirtyなstatusのまま行うcheckout branchが引き起こす現象</h1>
<h2>dirty checkout</h2>
git stashは「現在の作業を隠す」ためのコマンドです。隠す、とはどういうことか。

次の図は、簡単なコミット履歴です。masterとworkブランチがありますが、どちらもまだ同じポインタを示しています。
<pre class="marking:false nums:false nums-toggle:false plain:false plain-toggle:false lang:default highlight:0 decode:true" title="masterとworkブランチ（同じブランチポインタを参照）">     [master]
        v
o---o---o
        ^
       work</pre>
ここで、作業ブランチをworkに切り替えましょう。
<pre class="lang:default decode:true" title="Checkout other branch">git checkout work</pre>
<pre class="marking:false nums:false nums-toggle:false plain:false plain-toggle:false lang:default highlight:0 decode:true" title="ブランチの切り替え">      master
        v
o---o---o
        ^
      [work]</pre>
workブランチでファイルの変更を行うと、commitする前のgit statusはdirtyな状態になります。
<pre class="marking:false nums:false nums-toggle:false plain:false plain-toggle:false lang:default highlight:0 decode:true" title="workブランチでファイルを変更">      master
        v
o---o---o
        |
        M
        ^
   　 [work]</pre>
例えばもし、workブランチにいるあなたが、workブランチへcommitしたくないけどmasterブランチへ移動したいような時に、安易にmasterブランチへcheckoutすると、変更されたファイルがcheckout先に移動してしまいます。
<pre class="marking:false nums:false nums-toggle:false lang:default highlight:0 decode:true" title="workでcommitせずにmasterブランチをcheckout">     [master]
        v
o---o---M
        |
        o
        ^
   　  work</pre>
ちなみにこの状態でcommitすると、workで変更したはずのファイルだったにも関わらず、変更内容はmaster上でcommitされ、workへの反映は一切されません。
<pre class="marking:false nums:false nums-toggle:false plain:false plain-toggle:false lang:default highlight:0 decode:true" title="workで作業したはずの内容がmasterのcommitとして反映される">         [master]
            v
o---o---o---o
        ^
   　  work</pre>
<h2> git stashで一時退避</h2>
このような現象を回避するためのコマンドがgit stashです。

先述の通り、dirtyなstatusを作業ブランチの中へ一時的に隠して (stash) しまいます。
<pre class="marking:false nums:false nums-toggle:false lang:default highlight:0 decode:true" title="うまく図示出来ていませんが、変更内容を一時退避している様子です。">      master
        v
o---o---o
        |
        o =&gt; stash(M)
        ^
   　 [work]</pre>
一度stashしてしまえば、workブランチの中身はmasterと同じになっているため、masterブランチをcheckoutしても変更内容まで移り変わってしまうことはありません。

ちなみにstashしたファイルをもとに戻す場合はgit stash popやgit stash apply→git stash dropで可能です。

さて、いよいよ次からZshのプロンプトにgitのstash数を表示するコードとその表示結果の紹介になります。
<h1>Zshのプロンプトにgitのstash数を表示する</h1>
gitのstash数を表示するコードは次のとおりです。branch名の表示スクリプトと併記してますが、主に8-13行、17行がStash数を表示するコード部分になります。
<pre class="lang:default mark:8-13,17 decode:true" title="prompt.zshrc">function _for_prompt() {
    # set git branch-name
    # &gt;&gt; http://www.slideshare.net/tetutaro/zsh-20923001
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_

    # set git stash-num
    # &gt;&gt; http://qiita.com/items/13f85c11d3d0aa35d7ef
    git stash list &gt;&amp;/dev/null
    if [ $? -eq 0 ]; then
        psvar[2]=$(git stash list | wc -l | tr -d ' ')
    fi
}
add-zsh-hook precmd _for_prompt

RPROMPT='%077F%2(v|(%1v @%2v) |)%f'
RPROMPT+='%038F[%~]%f'</pre>
この実装の結果、次のような挙動になります。<span style="color: #008000;">@0</span>や<span style="color: #008000;">@1</span>が現在のstash数を表示している部分です。

[caption id="attachment_4756" align="aligncenter" width="700"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/06/screenshot-2013-06-02-at-2.46.42-AM.png"><img class="size-large wp-image-4756" alt="@の後ろにstash数が表示されています。" src="http://blog.hifumi.info/wp-content/uploads/2013/06/screenshot-2013-06-02-at-2.46.42-AM-700x166.png" width="700" height="166" /></a> @の後ろにstash数が表示されています。[/caption]
<h1>function _for_prompt()</h1>
次のコードについて説明していきます。
<pre class="lang:default decode:true" title="psvar">git stash list &gt;&amp;/dev/null
if [ $? -eq 0 ]; then
    psvar[2]=$(git stash list | wc -l | tr -d ' ')
fi</pre>
<h2>git stash list &amp;&gt;/dev/null</h2>
<span class="lang:default decode:true crayon-inline">git stash list &gt;&amp;/dev/null</span>はgit stash listを結果を、<span class="crayon-inline">/dev/null</span>へリダイレクトするコードです。これは、<span class="lang:default decode:true crayon-inline">git stash list &gt;/dev/null 2&gt;&amp;1</span>と同じ働きをします。また、&gt;&amp;と&amp;&gt;は同じです。

ただし前者のコードは、/dev/nullにあたる部分が数字だと、file descriptorへの複写と解釈されます（例えば、0だと標準入力への複写、&gt;&amp;3だとbad file descriptorエラーになったりします）。

詳しくは、<a href="http://www.manpagez.com/man/1/zshmisc/" target="_blank">zshmiscマニュアルのREDIRECTIONの項目</a>をご覧ください。
<h2>psvar[2]=$(git stash list | wc -l | tr -d ' ')</h2>
<span class="lang:default decode:true crayon-inline">git stash list &gt;&amp;/dev/null</span>がエラーでなければ、つまりGitリポジトリが存在すれば、直前のコマンドの終了ステータスを持つ特殊変数<span class="crayon-inline">$?</span>が0になり、<span class="crayon-inline">psvar[2]</span>にstash数が格納されます。

wcコマンドは単語や行、文字、バイト数をカウントするコマンドです。ただしこのままだと大量の空白が生じてしまうため、trコマンド（文字列の変換コマンド）で空白をトリミングしています。

ちなみにpsvarはプロンプトの文字列として使用出来る配列で、今回は<span class="crayon-inline">psvar[1]</span>にブランチ名を、<span class="crayon-inline">psvar[2]</span>にstash数を入れています。
<h2>RPROMPT</h2>
最後は右プロンプト<span class="crayon-inline">RPROMPT</span>に変数をどんどん代入していきます。1行目ではGit関連情報を、2行目では現在のディレクトリを代入しています。
<pre class="lang:default decode:true" title="RPROMPT">RPROMPT='%077F%2(v|(%1v @%2v) |)%f'
RPROMPT+='%038F[%~]%f'</pre>
<h1>Zshの本</h1>
今回このブログエントリを作成するにあたって、ペパボの大先輩エンジニアである<a href="https://twitter.com/gosukenator/" target="_blank">宮下さん</a>（ペパボではmizzyさんと呼ばれています）に『Zshの本』をお借りしました。

[amazon asin=4774138649&amp;template=wishlist&amp;chan=default]

Gitのstash数を表示するにあたって、Zshの特殊変数だとかコマンドもついでに勉強したくなり、『Zshの本』を片手に作業しながら、時には「そういえばコレってman zshにはなんて書いてるんだろう？」とあっちへ行ったりこっちへ行ったりの作業でした。時間は掛かったものの、色々なことが分かり、非常にタメになりました。
<h1>git-new-workdir</h1>
ところで最近知ったのですが、<a href="https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir" target="_blank">git-new-workdir</a>というツールがあるそうです。

これはリポジトリのブランチを指定してディレクトリをコピーできるようです。そして.git/のいくつかのファイルやディレクトリはsymlinkされるらしく、つまりコミット履歴あたりが共有されるという解釈で良いのでしょうか。

履歴を共有したリポジトリを複製し、かつ別のブランチを指定することで、いちいちcheckoutでリポジトリを切り替えなくとも、複数ブランチを並行に扱えるようです。

ちゃんと調べたわけではないですが、作業内容によっては手間が省けていいですよね。

下手をするとmerge conflictが大変そうですが、別ブランチの中を閲覧したいだけ、という状況なら問題なさそうです。git-new-workdirを使わずとも同じことはできますが、自分の作業環境次第といったところが話の着地点でしょうか。

まだまだやることはあります。勉強ってなんて飽きないんだろう。
<h1>参考</h1>
<ul>
	<li><a title="man page zshmisc section 1" href="http://www.manpagez.com/man/1/zshmisc/" target="_blank">http://www.manpagez.com/man/1/zshmisc/</a></li>
	<li><a title="ブランチ名 + 作業状態 + stash数 をzshのプロンプトに表示" href="http://qiita.com/items/13f85c11d3d0aa35d7ef" target="_blank">ブランチ名 + 作業状態 + stash数 をzshのプロンプトに表示</a></li>
</ul>
