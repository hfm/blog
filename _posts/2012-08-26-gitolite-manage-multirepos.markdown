---
layout: post
title: Gitoliteで複数gitリポジトリを管理する
categories:
- Dev
tags:
- FreeBSD
- Git
- Server
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: ''
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: ''
  _jd_wp_twitter: ''
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '2000'
  _aioseop_keywords: git,サーバ,開発,
  _aioseop_description: Gitによるリポジトリが複数に増えてくると、管理が大変になります。また、複数人での開発において、ユーザごとの柔軟な権限設定は大切です。Gitoliteを使うと、複数Gitリポジトリ及びユーザ、ユーザグループとその権限設定などを柔軟に管理できます。
  _aioseop_title: Gitoliteを入れてサーバ上のgitを綺麗に管理する
  dsq_thread_id: '1224644406'
---
<a href="http://blog.hifumi.info/wp-content/uploads/2012/07/GitBackground.png"><img class="aligncenter size-full wp-image-2000" title="GitBackground" alt="" src="http://blog.hifumi.info/wp-content/uploads/2012/07/GitBackground.png" width="520" height="150" /></a> 前置き長めなので、不要な方は<a href="#install">読み飛ばして</a>ください。
<h1>Gitoliteとは</h1>
<blockquote>Gitolite allows you to host Git repositories easily and securely.
<p style="text-align: right;"><a href="https://github.com/sitaramc/gitolite/wiki" target="_blank">Welcome to the gitolite wiki!!</a></p>
</blockquote>
Gitoliteとは複数Gitリポジトリを簡単で安全に管理できるツールです。だそうです。

でも、もし、あなたが<a href="http://vps.sakura.ad.jp/" target="_blank">さくらVPS</a>や自鯖の所有者だとして、正直Gitoliteは不要かと思います。有料ではあるものの、最近では<a href="https://github.com/" target="_blank">GitHub</a>や<a href="http://www.assembla.com/" target="_blank">Assembla</a>がクローズドな組織向けリポジトリを提供しています。個人開発においてわざわざGitoliteでユーザ管理する必要はありません。

それでも、趣味の範囲程度で、研究室で、あるいは友達同士で、資源管理の必要性やアプリ開発をやる雰囲気が上がってきた時、こういうツールを知っているとひょっとしたら便利かもしれません。

僕がこれを使用した理由は、さくらVPSで自分専用のクラウドサーバを持っていたことと、IT開発系の零細企業でアルバイトをしていることです。勃興するアルバイターとプロジェクトを前に、人材・資源の管理が大変になっていくのを目の当たりにして、「もうちょっとちゃんと管理しようか」となったからです。

必要に迫られてやったわけで、趣味や興味本位でやるもんではないと思います。

ただ、Social CodingやCloud Fundingが興るこのソーシャル時代、北海道と沖縄の住民同士が共同開発をする可能性はあると思いますので、きっとそんな時にGitoliteは役に立つのでしょう。たぶん。しかし、その程度の開発規模ならスカイプでやれって話かもしれません。コレは結構重要です。Skypeチャットの方がソーシャルでアジャイル。

さて、散々に書いたGitoliteですが、ここから先は興味本位のついでにGitoliteを導入する方法や具体的な使い方について紹介します。

ちなみに参考にした《<a title="Git管理の神ツール「Gitolite」なら、ここまでできる！" href="http://www.atmarkit.co.jp/fjava/rensai4/devtool26/devtool26_1.html" target="_blank">Git管理の神ツール「Gitolite」なら、ここまでできる！</a>》は丁寧に解説されていますが、ちょっとバージョンが古くて、書いてあるコマンドをそのまま流用することができません。これが、今回エントリにしようと思ったキッカケです。 使用環境は以下のとおり。
<table border="0">
<tbody>
<tr>
<td>サーバ</td>
<td>クライアント</td>
</tr>
<tr>
<td>FreeBSD 9.0-RELEASE-p3</td>
<td>Mac OS X Lion (10.7.3)</td>
</tr>
<tr>
<td>Git 1.7.11.1</td>
<td>Git 1.7.11.2</td>
</tr>
<tr>
<td>Gitolite 3.03</td>
<td></td>
</tr>
</tbody>
</table>
<!--more-->
<h1>主な機能・特徴</h1>
<ul>
	<li>中央リポジトリのあるサーバにユーザが１人いればよく、ユーザ数が増大しない。</li>
	<li>複数のgitoliteユーザ（各gitリポジトリ専用ユーザ）を管理できる</li>
	<li>複数のgitリポジトリを管理できる</li>
	<li>認証は通常sshdを使用するが、必要であればhttpアクセスもできる</li>
</ul>
<p style="text-align: right;">出典：<a href="http://sitaramc.github.com/gitolite/index.html" target="_blank">http://sitaramc.github.com/gitolite/index.html</a></p>
<p style="text-align: left;">アレだけ貶しておいて今更ですが、gitoliteを使ったら<strong>複数のgitリポジトリを一元管理することが出来る</strong>ようになります。</p>
<p style="text-align: left;">個人プロジェクトを複数抱えて、プロジェクトの場所がシッチャカメッチャカになっているようであれば、この恩恵は大きいかもしれません。</p>
<p style="text-align: left;">しかし、ちなみに、個人プロジェクトであれば、Assemblaあたりが無料のプライベートgitリポジトリを提供してくれていたり、クラウド環境は潤沢です。</p>

<h1><a name="install"></a>サーバにGitoliteをインストールする</h1>
長くなりましたが、ようやくGitoliteの導入に関してのお話です。
<h2>１．《サーバ》Giteliteのインストール</h2>
FreeBSD上にgiteliteをインストールするためには、Ports内にあるgiteliteディレクトリを利用します。
<pre class="lang:default decode:true" title="Gitoliteのインストール">$ cd /usr/ports/devel/gitolite
$ make BATCH=yes install clean
# gitというユーザが作成される</pre>
Gitoliteはこれだけでインストール完了です。vipwコマンドで確認すると、<strong>git</strong>ユーザが新規追加されています。ホームディレクトリは<strong>/usr/local/git</strong>です。
<h2>２．《クライアント》RSA鍵の生成とconfig設定</h2>
今回はクライアントにMacを使用しています。ターミナルからSSH鍵生成を行い、~/.ssh/configにgitサーバの情報登録をしましょう。
<pre class="lang:default decode:true crayon-selected" title="RSA鍵生成">$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/hoge/.ssh/id_rsa): /Users/hoge/.ssh/gitolite
Enter passphrase (empty for no passphrase): ****
Enter same passphrase again: ****
Your identification has been saved in /Users/hoge/.ssh/gitolite
Your public key has been saved in /Users/hoge/.ssh/gitolite.pub.
The key fingerprint is:
**:**:**:**:**:**:**:**:**:**:**:**:**:**:**:** hoge@pcname.local
The key's randomart image is:
+--[ RSA 2048]----+
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
+-----------------+</pre>
~/.sshディレクトリ以下にgitolite/gitolite.pubという秘密鍵／公開鍵のペアが作成されました。

次に、<pre class="inline:1 " >~/.ssh/config</pre>にgitサーバの情報登録です。
<pre class="lang:default decode:true">$ vi ~/.ssh/config
+ Host gitolite
+ HostName ***.***.***.***
+ User git
+ Port ****
+ IdentityFile ~/.ssh/gitolite</pre>
Hostには好きな名前を、HostNameにはgitサーバのIPアドレスやホスト名を、PortにはSSH用ポート番号を、それぞれ記入して下さい。
<h2>３．《クライアント、サーバ》公開鍵の登録</h2>
本エントリでは、<a title="さくらVPS デ FreeBSD ノススメ" href="http://blog.hifumi.info/dev/setup-freebsd-on-sakuravps/">以前のエントリに書いた</a>ような<strong>公開鍵暗号によるSSHログイン認証</strong>を採用していますので、scp操作などの通信は基本的に公開鍵認証方式を想定しています。人によっては適宜読み替えをおねがいします。
<h3>３．１．クライアントでの操作</h3>
まずは<strong>クライアントでの操作</strong>です。<a title="Linuxコマンド集 【 scp 】 リモート・マシン間でファイルをコピーする" href="http://itpro.nikkeibp.co.jp/article/COLUMN/20060227/230878/" target="_blank">scpコマンド</a>を使って、サーバへ公開鍵を転送しましょう。
<pre class="lang:default decode:true" title="scpコマンド">$ scp -p ****                  #sshポート番号
      -i ~/.ssh/sakuravps      #認証用秘密鍵
         ~/.ssh/gitolite.pub   #登録したい公開鍵
         hoge@**.**.**.**:</pre>
<ol>
	<li>ポート番号を指定し（デフォルトの22番なら指定不要です）、</li>
	<li>SSHログイン認証に用いる秘密鍵を指定し（パスワード認証なら指定不要です）、</li>
	<li>先ほどGitolite用に生成した公開鍵を指定し、</li>
	<li>送信先のサーバを指定しましょう。</li>
</ol>
※gitolite.pubの拡張子（.pub）は削除しないで下さい。Gitoliteのセットアップは*.pubの拡張子付きの公開鍵が必要です。

※また、ここではgitユーザではなく普段使いのユーザとして転送していることにご注意下さい。後からユーザとグループを変更します。
<h3>３．２．サーバでの操作</h3>
次に<strong>サーバでの操作</strong>です。上記のコマンドで転送すれば、hogeユーザのホームディレクトリにgitolite.pubが入っています。サーバにログインし、
<pre class="lang:default decode:true" title="gitolite用公開鍵の準備">$ [sudo] mv gitelite.pub /usr/local/git
$ [sudo] chown -R git:git gitolite.pub</pre>
とコマンドを実行して下さい。先ほど転送したGitolite用公開鍵の権限がgitユーザに移ります。

Gitoliteのセットアップにはクライアントで生成した公開鍵を使います。suコマンドでgitユーザになり、ホームディレクトリから以下のようにコマンドを実行しましょう。
<pre class="lang:default decode:true" title="gitユーザから初期セットアップを行う">$ su - git
$ gitolite setup -pk gitolite.pub</pre>
コマンド実行後、次のようなディレクトリ構成が出来上がっていればセットアップは完了です。
<pre class="lang:default highlight:0 decode:true" title="セットアップ後のディレクトリ構成">/usr/local/git
├── .gitolite
│   ├── conf
│   ├── hooks
│   ├── keydir
│   └── logs
├── .gitolite.rc
├── .ssh
├── gitolite.pub
├── projects.list
└── repositories
    ├── gitolite-admin.git
    └── testing.git</pre>
<h2>４．試しにCloneしてみる</h2>
クライアントからGitoliteにアクセスするためのテストリポジトリtestingが標準で用意されているので、コマンドを叩いてみます。
<pre class="lang:default decode:true" title="テスト用リポジトリをcloneして確かめる">$ git clone ssh://gitolite/testing
# gitoliteの部分はクライアントの~/.ssh/configのHost名を用いる</pre>
Cloning into 'testing'...というテキストのあと、パスワードを入力すれば、クライアントのカレントディレクトリにtestingディレクトリがcloneされます。
<h1>Gitoliteのユーザ、リポジトリ管理</h1>
いよいよGitoliteを用いてユーザやリポジトリの管理を行います。

まずはgitolite-adminという管理用リポジトリをcloneしましょう。
<pre class="lang:default decode:true" title="gitolite-adminリポジトリをcloneする">$ git close ssh://gitolite/gitolite-admin</pre>
gitolite-adminディレクトリは次のような構成です。
<pre class="lang:default highlight:0 decode:true" title="cloneしたgitolite-adminのディレクトリ構成">gitolite-admin
├── .git
├── conf
│   └── gitolite.conf
└── keydir
     └── gitolite.pub #先ほどssh-keygenで生成したものと同じ</pre>
.gitは置いといて、Gitoliteはこのconfとkeydirディレクトリを用いて管理します。
<h2>gitoliteにユーザを追加する</h2>
Gitoliteでのユーザ管理は、gitolite-admin/keydirの中に*.pubを追加することで実現します。

例えば別のPCからGitoliteリポジトリへアクセスしたい場合など、複数台の端末からアクセスするためには、keydirディレクトリの中へ各端末から生成した公開鍵を追加します。公開鍵の作成方法は先述のssh-keygenなどで行いましょう。

ただし、keydirに追加するだけではgitolite中に作成したプロジェクトへのアクセス権が無いために操作できません。アクセス権に関しての操作は後述の《<a href="#addrepo">gitoliteにリポジトリを追加する</a>》へどうぞ。
<pre class="lang:default decode:true" title="gitoliteにユーザを追加する">gitolite-admin
└── keydir
  ├── gitolite.pub
  ├── foo.pub #以下、複数の公開鍵を追加することでユーザが追加される
  ├── bar.pub
  ├── ...</pre>
keydirディレクトリに公開鍵を追加後、以下のようにサーバへpushします。
<pre class="lang:default decode:true" title="サーバ（リモートリポジトリ）へadd→commit→pushする">$ git add .
$ git commit -m "新規ユーザ公開鍵を追加登録"
$ git push</pre>
これでユーザの追加は完了です。testingリポジトリをclone出来れば正しく登録されています。
<h2><a name="addrepo"></a>gitoliteにリポジトリを追加する</h2>
新規リポジトリの追加は、<pre class="inline:1 " >gitolite-admin/conf/gitolite.conf</pre>に追記することで実現します。
<pre class="lang:default decode:true" title="初期状態のgitolite.conf">repo gitolite-admin
    RW+     =    gitolite

repo testing
    RW+     =    @all</pre>
これは非常に単純な構成で、
<pre>repo testing
宣言　リポジトリ名
    RW+     =    @all
　　権限　　　　　　付与ユーザ</pre>
となっています。 初期状態から新たにリポジトリ（及びそのリポジトリを使用出来るユーザ）を作成するには、次のように、
<pre class="lang:default decode:true" title="gitoliteによるリポジトリとユーザの管理">repo gitolite-admin
    RW+     =    gitolite

repo testing
    RW+     =    @all

repo new-repo
    RW      =    user-foo user-bar user-hoge
    RW+     =    @admin
    -       =    @fuga</pre>
と追記します。権限の設定に関しては、
<pre>R   … 読み込みのみ可能
RW  … 読み込み／書き込みが可能
RW+ … 読み込み／書き込み／実行のすべての権限が可能
-   … すべての行為を禁止（特別のユーザあるいはグループを指定して禁止する）</pre>
となっています。Rは読み込み可能なので、cloneやfetchが可能です。RWはRに加えて書き込みも可能なので、最新のmasterへpushも可能です。RW+はすべての操作が可能で、tagsやbranchへの細かな操作も可能になります。

また、gitoliteでは複数のユーザをグループとして管理できます。一つだけの特別なグループ名を除けば、自由に名前を決めてユーザを登録できます。
<pre class="lang:default decode:true" title="gitolite.confにユーザグループを作成する">@fuga       =    alice bob foo
@newgroup   =    alice bar tarou
@aiueo      =    jiro hanako

repo new-repo
    RW      =    user-foo user-bar user-hoge
    RW+     =    @fuga
    R       =    @aiueo</pre>
また、gitoliteにはブランチ毎にアクセス権限を設定することができます。
<pre class="lang:default decode:true" title="柔軟（複雑とも言える）な権限設定">repo new-repo
    -  refs/tags/v[0-9] =    alice #各ブランチの過去バージョンへのアクセスを禁止する
    -  master           =    alice #masterブランチへのアクセスを禁止する
    RW                  =    alice #読み込み／書き込みの可能</pre>
これは、aliceユーザが、master以外の全ブランチの最新にのみ読み書きできる権限設定の例です。

これらの権限設定やリポジトリの設定をgitolite.conf内に設定したあと、先述のようにリモートリポジトリへpushすれば、新規リポジトリの作成やユーザの追加及び権限設定などが反映されます。
<pre class="lang:default decode:true" title="サーバ（リモートリポジトリ）へadd→commit→pushする">$ git add .
$ git commit -m "新規ユーザやリポジトリを追加登録"
$ git push</pre>
<h1>終わりに</h1>
まあ、なにはともあれ入門gitとか読めばいいと思います。アジャイルサムライは普通に僕が読みたいだけです。でもgitolite使って開発云々とか考える前にアジャイル知った方がいいと思うのは僕だけでしょうか。ペアプロとか。

※リンクはアマゾンアフィなので、踏む際にはご注意を。

[amazon asin=427406767X,477415184X,4774151041,4274068560&amp;template=wishlist&amp;chan=default]
<h3>参考</h3>
<ul>
	<li><a href="https://github.com/sitaramc/gitolite" target="_blank">GItolite - Github</a></li>
	<li><a title="Git管理の神ツール「Gitolite」なら、ここまでできる！" href="http://www.atmarkit.co.jp/fjava/rensai4/devtool26/devtool26_1.html" target="_blank">Git管理の神ツール「Gitolite」なら、ここまでできる！</a></li>
</ul>
