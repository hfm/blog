---
layout: post
title: Play with さくらVPS i to v
categories:
- Dev
tags:
- CentOS
- SakuraVPS
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
  _syntaxhighlighter_encoded: '1'
  _yoast_wpseo_metadesc: さくらVPSをレンタルした際に、はじめにしておいたほうが良い基本的な設定に関する記事です。
  _yoast_wpseo_metakeywords: さくらVPS, CentOS
  _yoast_wpseo_title: Play with さくらVPS
  _aioseop_keywords: さくらVPS,CentOS,初期設定,
  _aioseop_description: さくらVPSに入れたCentOSの初期部分に関する設定紹介です。
  _aioseop_title: Play with さくらVPS i to v
  dsq_thread_id: '1227641309'
---
さくらVPSをレンタルした際に色々設定したものをメモしておこうと思います。

現時点(2011.9.12)でさくらVPSをレンタルすると、CentOS 5.6(x86_64)がついてきます。別のOSにするのも面倒なのでこれはこのままで。

<!--more-->
<h1>目次</h1>
<p style="padding-left: 30px;"><a href="#1-root">1. rootのパスワードの変更</a>
<a href="#2-loginuser">2. ログイン用ユーザの作成</a>
<a href="#3-stopservice">3. 不要なサービスを停止する</a>
<a href="#4-yumcron">4. yum-cronの設定とyum関連のアップデート</a>
<a href="#5-repository">5. yum用リポジトリの追加</a>
<a href="#5-1-repository">5.1. yum-prioritiesをインストールする</a>
<a href="#5-2-repository">5.2. EPEL, RPMForge, Remiリポジトリの追加</a>
<a href="#5-3-repository">5.3. EPEL, RPMForge, Remiリポジトリの修正</a></p>

<h1><a name="1-root"></a>1. rootのパスワードの変更</h1>
アタリマエのことですが、rootのパスワードをデフォルトから変更しておきます。※どうせこのあと、rootからのログインを禁止するのですが…。
<pre class="lang:shell collapse:false title:rootのパスワードを変える">$ passwd</pre>
<h1><a name="2-loginuser"></a>2. ログイン用ユーザの作成</h1>
rootのパスワードは変更しましたが、色んなサイトの方が仰るとおり、rootでログインして色々操作するのは危なっかしいので普段遣いのユーザを作成しましょう。
<h2>2.1.ユーザの作成とパスワードの変更をする</h2>
<pre class="lang:shell collapse:false title:新規ユーザの設定">$ useradd user1 //新規ユーザの作成
$ passwd user1 //指定ユーザのパスワード設定</pre>
<h2>2.2.先ほど追加したユーザにsuコマンド権限を与える</h2>
<pre class="lang:shell collapse:false title:wheelグループに追加する">$ usermod -G wheel user1</pre>
<h2>2.3.suファイルを開いて、次の1行をコメントアウトする</h2>
<pre class="lang:shell collapse:false title:login認証が設定出来るpam.dフォルダのsuファイルをいじくる">$ vi /etc/pam.d/su
//auth required pam_wheel.so use_uid</pre>
<h2>2.4.visudoコマンドを使って次の1行をコメントアウトする</h2>
<pre class="lang:default decode:true crayon-selected" title="Sudoersファイルを設定する">% visudo
- wheel ALL=(ALL) ALL
+ // wheel ALL=(ALL) ALL</pre>
この一連の流れで、新規ユーザuser1をwheelグループに追加し、wheelグループのユーザがsudoコマンドを使えるように権限の設定を変更しました。
<h1><a name="3-stopservice"></a>3. 不要なサービスを停止する</h1>
1番、2番の操作はだいたいみんな一緒なんですが、他のブログとか覗いてると、この後からそれぞれ微妙に順番とかやってることが違ってきて「あれ？あれ？」ってなるんですよね。<strong>iptablesによるファイアウォール</strong>の設定とか<strong>RSA鍵認証</strong>ログインとか<strong>リポジトリ</strong>の追加とか、やってることはみな一緒なんですけど、順番が違うと戸惑いを覚えます。

rootからの操作は危なっかしいと言っておきながら、このへんは何も考えずに下記の数行をコピペして実行しちゃいます。
<pre class="lang:shell collapse:false title:不要なサービスを停止する">chkconfig auditd off
chkconfig autofs off
chkconfig avahi-daemon off
chkconfig bluetooth off
chkconfig cups off
chkconfig firstboot off
chkconfig gpm off
chkconfig haldaemon off
chkconfig hidd off
chkconfig isdn off
chkconfig kudzu off
chkconfig lvm2-monitor off
chkconfig mcstrans off
chkconfig mdmonitor off
chkconfig messagebus off
chkconfig ip6tables off
chkconfig netfs off
chkconfig nfslock off
chkconfig pcscd off
chkconfig portmap off
chkconfig rawdevices off
chkconfig restorecond off
chkconfig rpcgssd off
chkconfig rpcidmapd off
chkconfig smartd off
chkconfig xfs off</pre>
yum-updatesdはさくらVPSでは停止しているので特に操作無し。
<h1><a name="4-yumcron"></a>4. yum-cronの設定とyum upgrade</h1>
繰り返すようですが、この辺りはもう流れ作業に近いので、正確にはRSA鍵認証を設定するまではずっとrootで作業しちゃってます。セキュリティ意識…('A`)
<pre class="lang:shell collapse:false title:yum環境の設定とアップデート">$ yum remove yum-updatesd
$ yum install yum-cron
$ service yum-cron start
$ chkconfig yum-cron on
$ yum upgrade</pre>
<h1><a name="5-repository"></a>5. リポジトリの追加</h1>
yum-prioritiesを入れてpriorityの設定をします。あと、PHPの最新版とかを使いたいので、EPEL, RPMForge, Remiのリポジトリを追加します。dagは別にいいや。
<h2><a name="5-1-repository"></a>5.1. yum-prioritiesをインストールする</h2>
<pre class="lang:shell collapse:false title:yumに優先順序を加えられるパッケージをいれる">$ yum install yum-priorities</pre>
CentOS-Base.repoをちょっと修正。centosplusのenable=0をenable=1に変えて、[contrib]を除く全てのパッケージ(?)にpriority=1を付け加えます。
<pre class="lang:shell collapse:false title:CentOS-Base.repoファイルを開く">$ vi /etc/yum.repo.d/CentOS-Base.repo</pre>
ファイルを以下のように修正。
<pre class="lang:shell collapse:false title:CentOS-Base.repoファイルの編集">[base]
name=CentOS-$releasever - Base
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=os
#baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5
priority=1

#released updates
[updates]
name=CentOS-$releasever - Updates
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=updates
#baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5
priority=1

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=extras
#baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5
priority=1

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=centosplus
#baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5
priority=1

#contrib - packages by Centos Users
[contrib]
name=CentOS-$releasever - Contrib
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=contrib
#baseurl=http://mirror.centos.org/centos/$releasever/contrib/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5</pre>
<h2><a name="5-2-repository"></a>5.2. EPEL, RPMForge, Remiリポジトリの追加</h2>
<pre class="lang:shell collapse:false title:3つのリポジトリを追加する">rpm -ivh http://download.fedora.redhat.com/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivh http://apt.sw.be/redhat/el5/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/5/remi/x86_64/remi-release-5-8.el5.remi.noarch.rpm</pre>
それぞれ現時点(2011.09.12)での最新版です。以下から取得しました。
<ul>
	<li>http://download.fedora.redhat.com/pub/epel/5/x86_64/repoview/epel-release.html</li>
	<li>http://pkgs.repoforge.org/rpmforge-release/</li>
	<li>http://rpms.famillecollet.com/enterprise/5/remi/x86_64/repoview/remi-release.html</li>
</ul>
<h2><a name="5-3-repository"></a>5.3. EPEL, RPMForge, Remiリポジトリの修正</h2>
/etc/yum.repos.d/フォルダ下にあるremi.repo, rpmforge.repo, epel.repoのそれぞれのパッケージにあるenableを全て0にする。
<pre class="lang:shell collapse:false title:*.repoをデフォルトで向こうにする">enable = 0</pre>
デフォルトで0になっているものも幾つかありますが、念のため確認してしまいます…。
これらの設定をすることで、もろもろの設定が終わったあとは
<pre class="lang:shell collapse:false title:yumコマンドを使う時">sudo yum --enablerepo=rpmforge,epel,remi hogehoge</pre>
こんな感じでyumを触ることになるのかと思います。sudoを入れているのは、今後はrootじゃなくて作成した新規ユーザでログイン…操作するからです。

iptablesによるファイアウォールの設定や、RSA鍵認証などのセキュリティ関連の設定は次回。
<h1>参考</h1>
<ul>
	<li><a title="CentOSをサーバーとして活用するための基本的な設定" href="http://tanaka.sakura.ad.jp/archives/001065.html" target="_blank">CentOSをサーバーとして活用するための基本的な設定</a></li>
	<li><a title="はじめてのさくら VPS + CentOS の初期設定からチューニングなどの作業まとめ" href="http://weble.org/2011/05/16/sakura-vps-and-centos" target="_blank">はじめてのさくら VPS + CentOS の初期設定からチューニングなどの作業まとめ</a></li>
</ul>
