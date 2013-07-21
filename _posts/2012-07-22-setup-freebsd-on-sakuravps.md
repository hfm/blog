---
layout: post
title: さくらVPS デ FreeBSD ノススメ
categories:
- Dev
tags:
- FreeBSD
- SakuraVPS
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/NpiF4n
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/dev/setup-freebsd-on-sakuravps/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:3:{i:0;s:153:"【ブログ更新】 さくらVPS デ FreeBSD ノススメ http://bit.ly/NpiF4n
    - さくらVPSはデフォルトでCentOSを提供していますが、u";i:1;s:153:"【ブログ編集】 さくらVPS デ FreeBSD ノススメ http://bit.ly/NpiF4n
    - さくらVPSはデフォルトでCentOSを提供していますが、u";i:2;s:153:"【ブログ編集】 さくらVPS デ FreeBSD ノススメ http://bit.ly/NpiF4n
    - さくらVPSはデフォルトでCentOSを提供していますが、u";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _yoast_wpseo_metadesc: さくらVPSをFreeBSD9.0-RELEASEとして活用するために、FreeBSDの導入からちょこっとした初期設定までをザックリ進めていきます。
  _yoast_wpseo_metakeywords: さくらVPS,FreeBSD,サーバ,入門,Linux
  _yoast_wpseo_title: さくらVPSをFreeBSD 9.0-RELEASEとして活用するまでの流れ
  _syntaxhighlighter_encoded: '1'
  _thumbnail_id: '3505'
  _aioseop_keywords: FreeBSD, Unix,さくらVPS,VPS, 入門, SSH, 鍵認証,公開鍵暗号, 初期設定
  _aioseop_description: さくらVPS上でFreeBSD9.0をインストールし、必要環境をセットアップするまでの簡単な流れを紹介します。
  _aioseop_title: さくらVPS デ FreeBSD ノススメ
  dsq_thread_id: '1224728263'
---
<p style="text-align: center;"><a href="http://blog.hifumi.info/wp-content/uploads/2012/08/svps.png"><img class="aligncenter size-large wp-image-3505" style="border: 0px; margin-top: 0px; margin-bottom: 0px; padding: 0px;" alt="sakuraVPS with FreeBSD" src="http://blog.hifumi.info/wp-content/uploads/2012/08/svps-700x150.png" width="700" height="150" /></a></p>
<a title="VPS（仮想専用サーバ）のインターネットさくら" href="http://vps.sakura.ad.jp/" target="_blank">さくらVPS</a>はデフォルトで<a title="CentOS" href="http://www.centos.org/" target="_blank">CentOS</a>を提供していますが、<a title="ubuntu Japanese Team" href="http://www.ubuntulinux.jp/" target="_blank">ubuntu</a>や<a title="Fedora Project" href="http://fedoraproject.org/ja/" target="_blank">Fedora</a>等、他のUnix/LinuxOSを選べる<a title="カスタムOSインストールガイド" href="http://support.sakura.ad.jp/manual/vps/mainte/custom.html" target="_blank"><strong>カスタムOSインストール</strong></a>があります。このブログ（サーバ）はFreeBSDで動かしていますが、遜色なくキビキビ動いてくれています。

そもそもFreeBSDはLinux系ではなくUnix系であり、なので厳密には<a title="Red Hat Japan" href="http://jp.redhat.com/" target="_blank">赤帽子</a>や<a title="Debian JP Project" href="http://www.debian.or.jp/" target="_blank">Debian</a>とは異なる進化の系譜に属すOSのはずなのですが、OS開発経験でも無いと、見た目にはディレクトリ構成くらいしか差が…（＾＾；

[caption id="" align="aligncenter" width="320"]<a href="http://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Unix_history-simple.svg"><img title="複数のUnix系システム間の関連図" alt="複数のUnix系システム間の関連図" src="http://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Unix_history-simple.svg/320px-Unix_history-simple.svg.png" width="320" height="223" /></a> <a href="http://creativecommons.org/licenses/by-sa/3.0/deed.ja" target="_blank">CC BY-SA 3.0</a> by <a href="http://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Unix_history-simple.svg" target="_blank">WikiPedia：複数のUnix系システム間の関連図</a>[/caption]

とはいえその見た目というのも捨てがたいもので、FreeBSDの分かりやすいディレクトリ構成と管理の容易さは魅力的です。また公式によると、
<blockquote>
<h2>1.2.1 FreeBSD で何ができるの?</h2>
<ul>
	<li><em>もう書ききれません!</em></li>
</ul>
<div style="text-align: right;"><a title="1.2 FreeBSD へようこそ!" href="http://www.freebsd.org/doc/ja_JP.eucJP/books/handbook/nutshell.html" target="_blank">1.2 FreeBSD へようこそ!</a>，FreeBSD ハンドブック</div></blockquote>
だそうです。……まあ、僕は今までにCentOS / Debian / openSUSE / Ubuntuの使用経験があるんですが、そのどれと比べても、FreeBSDには "スッキリ" とした印象を持ちます。軽量で頑強な動作にも定評があり、Portsを使ったスケルトン構成による管理方法や豊富なドキュメントなど、概して素敵な使い心地だと思います。

さて、ここではそんなFreeBSDをさくらVPS標準のCentOSから移行した際の、備忘録を兼ねたセットアップの手順を進めていきます。

<!--more-->
<h1>INDEX</h1>
<ol>
	<li><a href="#shift">CentOSからFreeBSD 8.1へ移行する</a></li>
	<li><a href="#editsshd">一時的にクライアントアクセスを可能にする</a></li>
	<li><a href="#upgrade-freebsd">FreeBSD 9.0-RELEASEへアップグレード</a></li>
	<li><a href="#portscollection">Ports Collectionからインストール</a></li>
	<li><a href="#portupgrade">portupgradeを使ってPortsの中身を更新、パッケージの管理をする</a></li>
	<li><a href="#makeinstall" target="_blank">sudoやシェル、エディタを入れる</a></li>
	<li><a href="#firewall">Firewallの設定をする</a></li>
	<li><a href="#ntp">ntpの設定をする</a></li>
	<li><a href="#adduser">ユーザを追加する</a></li>
	<li><a href="#ssh">SSHログインの設定をする</a></li>
</ol>
<h1><a name="shift"></a>CentOSからFreeBSD 8.1へ移行する</h1>
さくらVPSにFreeBSDをインストールする方法は、カスタムOSインストール機能を用いることで簡単に導入できます。手順は<a title="FreeBSD 8.1-RELEASE" href="http://support.sakura.ad.jp/manual/vps/mainte/custom_freebsd.html" target="_blank">FreeBSDカスタムOSインストールガイド</a>に詳述されていますので、そちらをご参考ください。
<h1><a name="editsshd"></a>一時的にクライアントアクセスを可能にする</h1>
さくらVPSのOSをFreeBSDに移行した後、バーチャルコンソールの使い勝手は悪いので、ターミナルからの操作に切り替えましょう。ただし、さくらVPSから入れたFreeBSDの初期状態は、クライアントからのSSHアクセスを禁じています。

そこで、次のように/etc/ssh/sshd_configをいじって一時的にクライアントから簡単にログインできるように設定しましょう。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ vi /etc/ssh/sshd_config
  デフォルトポート番号の変更
- #Port 22
+ Port ****
  ルートログインの許可
- #PermitRootLogin no 
+ PermitRootLogin yes
  RSA鍵認証の停止
- #RSAAuthentication yes
+ RSAAuthentication no
  公開鍵認証の停止
- #PubkeyAuthentication yes
+ PubkeyAuthentication no</pre>
ただし、これはほんとにセキュリティが甘々になっているので、最初のセットアップのみにして下さい。ルートログインを許可してたり、パスワード認証でのログインを許可してたりと非常に危険です。ほんの少しだけ。
<h1><a name="upgrade-freebsd"></a>FreeBSD 9.0-RELEASEへアップグレード</h1>
さくらVPSから入れるFreeBSDのバージョンは8.1-RELEASEです。最新版は9.0-RELEASEなので、アップグレードに躊躇のいらないインストールしたての今こそ入れてしまいましょう。

アップグレードするための手順は次の２つになります。
<h2><strong>8.1-RELEASEをアップデートする</strong></h2>
実行手順は以下のとおりです。
<pre>$ freebsd-update fetch
Looking up portsnap.FreeBSD.org mirrors… 4 mirrors found.
Fetching public key from portnap4.FreeBSD.org… done.
…
<em># qを押して終了 </em>$ freebsd-update install
installing updates…install: ///usr/src/lib/libc/gen/libc_dlopon.c: No such file or directory
done.</pre>
<h2><strong>FreeBSD 9.0 RELEASEへアップグレードする</strong></h2>
FreeBSD 8.1 RELEASEが最新状態にアップデートされたら、次はOSのバージョンアップです。

実行手順は以下のとおりです。
<pre>$ freebsd-update -r 9.0-RELEASE upgrade
…
<em># 途中何度か質問があったら'y'で回答しておく</em>
<em># qを押して終了</em>
$ freebsd-update install
installing updates…rmdir: ///boot/kernel: Directory not empty
Kernel updates have been installed. Please reboot and run “/usr/sbin/freebsd-update install” again to finish installing updates.
$ reboot
$ freebsd-update install</pre>
以上でFreeBSD 9.0RELEASEへのアップグレードは完了です。FreeBSDのバージョンは、
<pre>$ uname -r
9.0-RELEASE</pre>
と入力することで可能です。
<h1><a name="portscollection"></a>Ports Collectionのインストール</h1>
このFreeBSDはminimal installなため、sudo等の重要パッケージが入っていません。ですので、先に<a title="5.5 Ports Collection の利用" href="http://www.freebsd.org/doc/ja_JP.eucJP/books/handbook/ports-using.html" target="_blank">Ports Collection</a>から必要なパッケージだけ入れておきましょう。それにしてもminimal installってsudoも入らないのか…。

Ports Collectionは<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/" target="_blank">Homebrew</a>やyumのようなFreeBSD用パッケージマネージャです。/usr/portsディレクトリ下に配置され、その中に様々なパッケージが用意されています。<a href="http://docs.freebsd.org/doc/4.7-RELEASE/usr/share/doc/ja/books/handbook/ports-using.html" target="_blank">スケルトンと呼ばれる構成</a>が特徴ですが、ここでの説明は割愛。

Ports Collectionの利用にはportsnapを使います。portsnapはPorts Collectionからパッケージを取り込んだり、更新状態を確認するためのツールです。
<h2>portsnapの利用</h2>
最初にportsnap.confを編集しましょう。素の状態でportsnapを利用すると、外国語にローカライズされたパッケージまで入ってしまいます。余計なローカライズパッケージを削除するよう設定してからPortsを取り込みましょう。

実行手順は以下のとおりです。
<pre class="lang:default decode:true"># 日本語以外のローカライズパッケージを除外する
$ vi /etc/portsnap.conf
- # REFUSE arabic chinese french german hebrew hungarian japanese
- # REFUSE korean polish portuguese russian ukrainian vietnamese
+ REFUSE arabic chinese french german hebrew hungarian
+ REFUSE korean polish portuguese russian ukrainian vietnamese

# Ports Collectionを取り込み、展開する
$ portsnap fetch extract
Looking up portsnap.FreeBSD.org mirrors… 4 mirrors found.
Fetching public key from portnap6.FreeBSD.org… done.
…
Building new INDEX files… done.

# crontabに自動アップデートの設定をする
$ vi /etc/crontab
+ 0 4 * * 1 root portsnap cron &amp;&amp; portsnap update &gt; /dev/null</pre>
最後にcrontabという定刻処理をするための設定ファイルがあります。ここの、
<pre>portsnap cron</pre>
は、3600秒以内のランダムなタイミングでPortsの最新データを取得するコマンドです。<strong>定期的な自動アップデート確認</strong>とも言えます。上記の設定では、<strong>毎週日曜午前４時</strong>に実行されるようになっています。crontabの書き方については<a title="crontabの書き方 - Plone" href="http://www.server-memo.net/tips/crontab.html" target="_blank">こちら</a>。

アップデート間隔は適度に開けていいと思いますので、週一あるいは月一ぐらいで十分かと。また、手動でPortsの更新をする場合は以下のコマンドを実行します。
<pre>portsnap fetch update</pre>
<h1><a name="portupgrade"></a>portupgradeを使ってPortsの中身を更新、パッケージの管理をする</h1>
portupgradeはPortsの更新やパッケージのインストール、アップデートなどを簡単に実行するためのパッケージです。Portsの取得後はまずこれを入れましょう。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ cd /usr/ports/ports-mgmt/portupgrade
$ make install clean
...
===&gt; Cleaning for portupgrade-2.4.9.3,2
$ rehash

$ chmod 644 /usr/local/etc/pkgtools.conf
$ vi /usr/local/etc/pkgtools.conf
- MAKE_ARGS = {
- }
+ MAKE_ARGS = {
+     '*' =&gt; [
+         'WITH_BDB_VER=42',
+         'WITHOUT_IPV6=yes',
+         'WITHOUT_X11=yes',
+     ],
+ }

$ vi /etc/make.conf
+ WITHOUT_X11=yes
+ NO_GUI=yes
+ WITHOUT_IPV6=yes</pre>
portupgradeのインストール後、pkgtools.confとmake.confという設定ファイルに同じような記述をしています。これは、
<pre>WITH_BDB_VER=42  : BerkeleyDBのバージョンを42に統一する（最早おまじない）
WITHOUT_IPV6=yes : IPv6関連を不要とする（さくらVPSがIPv4のサポートのみ）
WITHOUT_X11=yes  : X11関連を不要とする（サーバ用途なので）
NO_GUI=yes       : WITHOUT_X11と一緒。片方だけでいいけど念のため。</pre>
という意味になります。
<h1><a name="makeinstall"></a>sudoやシェル、エディタを入れる</h1>
FreeBSDはminimal installの場合、sudoが入っておりません。あとシェルとかエディタとか、ターミナル上で使うには環境が不便すぎるので、adduserする前にまずはこのsudoやvimやらzshやら、最低限必要なものだけ入れてしまいましょう。
<pre>$ cd /usr/ports/security/sudo
$ make BATCH=yes install clean

$ cd /usr/ports/shells/zsh
$ make BATCH=yes install clean

$ cd /usr/ports/editors/vim-lite
$ make BATCH=yes install clean</pre>
sudo, vim-lite, zshだけ入れましたが、これらはBATCH=yesとしています。このオプションを付けておくと、いちいちinstall中にconfig設定を聞かずにデフォルト設定のままコンパイル→インストールしてくれるので便利です。

なお、ZshやVim、その他日本語環境などCUIに関連する項目に関しては<strong><a title="FreeBSDのCUI環境を整える（Zsh/Vim/Lv/Man）" href="http://blog.hifumi.info/dev/freebsd-cui-zsh-vim-lv-man/">《FreeBSDのCUI環境を整える（Zsh/Vim/Lv/Man）》</a></strong>をどうぞ。

これでシェルやらエディタやら、基本道具が揃ったので環境揃えて行きましょう。
<h1><a name="firewall"></a>Firewallを設定する</h1>
<h2>ipfwのルールファイルを作成する</h2>
Firewallの設定はiptablesではなくipfwというもので行います。細かい仕組みに関しては『<a title="パケットフィルタ (ipfw) の設定" href="http://murasaki.cocolog-nifty.com/cloud/2009/08/ipfw-a0b2.html" target="_blank">パケットフィルタ (ipfw) の設定</a>』が詳しいです。ここでは設定項目だけ公開しておきます。

なお、FreeBSDの場合、firewallのルールファイルが/etc/rc.firewallに既にありますが、こちらは使用せずに、
<pre>touch /etc/rc.firewall_local</pre>
と、新たにファイルを作成した上で、このファイルに次のルールを記述します。

実行手順は以下のとおりです。
<pre class="lang:default decode:true" title="/etc/rc.firewall_local">#! /bin/sh
#

ipfw -q -f flush
IPF="ipfw -q add"

#loopback
$IPF 10 allow all from any to any via lo0

$IPF 20 deny all from any to 127.0.0.0/8
$IPF 21 deny all from 127.0.0.0/8 to any
$IPF 22 deny all from any to 172.16.0.0/12
$IPF 23 deny all from 172.16.0.0/12 to any
$IPF 24 deny all from any to 192.168.0.0/16
$IPF 25 deny all from 192.168.0.0/16 to any

$IPF 30 deny tcp from any to any frag

# statefull
$IPF 50 check-state
$IPF 60 allow tcp from any to any established
$IPF 70 allow all from any to any out keep-state
$IPF 80 deny icmp from any to any

# open port ftp (20,21)
$IPF 100 allow tcp from any to any 20 in
$IPF 101 allow tcp from any to any 20 out
$IPF 110 allow tcp from any to any 21 in
$IPF 111 allow tcp from any to any 21 out
# open port ssh (****)
$IPF 150 allow tcp from any to any **** in
$IPF 151 allow tcp from any to any **** out
# open port http (80)
$IPF 120 allow tcp from any to any 80 in
$IPF 121 allow tcp from any to any 80 out
# open port ntp (123)
$IPF 130 allow tcp from any to any 123 in
$IPF 131 allow tcp from any to any 123 out
# open port ssl (443)
# $IPF 140 allow tcp from any to any 443 in
# $IPF 141 allow tcp from any to any 443 out
# open port mysql (3306)
$IPF 160 allow tcp from any to any 3306 in
$IPF 161 allow tcp from any to any 3306 out

# deny and log everything
$IPF 999 deny log all from any to any</pre>
少し解説をすると、
<pre>$IPF 20 deny all from any to 127.0.0.0/8
$IPF 21 deny all from 127.0.0.0/8 to any
$IPF 22 deny all from any to 172.16.0.0/12
$IPF 23 deny all from 172.16.0.0/12 to any
$IPF 24 deny all from any to 192.168.0.0/16
$IPF 25 deny all from 192.168.0.0/16 to any</pre>
ここで自ネットワークと称した外からのアクセスを止めています。オレオレ詐欺防止です。また、
<pre>$IPF 80 deny icmp from any to any</pre>
ここでpingを遮断しています。応答に使えるとはいえ、pingはpingで爆撃対象だったりするので切っておくに越したことはありません。また、
<pre>$IPF 100 allow tcp from any to any 20 in
...
$IPF 161 allow tcp from any to any 3306 out</pre>
ここで主要なサービスのポートを開放しています。sshに関してのみ、通常の22番とは違うポートを開けています。sshのポートは22番以外の穴を自分で決めて秘密にしておくに越したことはありません。そしてssl通信はまだ不要なので、httpsのポートは開けておりません。

ちなみに、MySQLではなくPostgresqlを使用したい場合はポート番号5432を開けておけばいいと思います。
<h2>ipfwの有効化</h2>
次に、firewallを有効化したあと、ipfwを起動します。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ sudo vi /etc/rc.conf
# firowallを有効化する
+ firewall_enable="YES"
# firewallのルールを書いたファイルパスを指定する
+ firewall_script="/etc/rc.firewall_local"

$ service ipfw start</pre>
<h1><a name="ntp"></a>ntpの設定をする</h1>
サーバの時刻設定をします。ntpdを使うので、既にあるntp.confを退避させてからスクリプトを書きます。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ mv /etc/ntp.conf /etc/ntp.conf_default
$ vi /etc/ntp.conf
+ server -4 ntp1.jst.mfeed.ad.jp
+ server -4 ntp2.jst.mfeed.ad.jp
+ server -4 ntp3.jst.mfeed.ad.jp
+ restrict default ignore
+ restrict 210.173.160.27 nomodify nopeer noquery notrap
+ restrict 210.173.160.57 nomodify nopeer noquery notrap
+ restrict 210.173.160.87 nomodify nopeer noquery notrap
+ restrict 127.0.0.1</pre>
スクリプトが出来たら、ntpdを有効化して起動します。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ vi /etc/rc.conf
+ ntpd_enable="YES"
$ service ntpd start</pre>
<h1><a name="adduser"></a>ユーザの追加をする</h1>
ユーザの追加にはadduserコマンドを利用します。

実行手順は以下のとおりです。
<pre>$ adduser
Username: <strong>hoge</strong>
Full name: <strong>hoge</strong>
Uid (Leave empty for default):
Login group [hoge]:
Login group is users. Invite j into other groups? []: <strong>wheel</strong>
Login class [default]:
Shell (sh csh tcsh bash rbash nologin) [sh]: <strong>zsh</strong>
Home directory [/home/hoge]:
Use password-based authentication? [yes]:
Use an empty password? (yes/no) [no]:
Use a random password? (yes/no) [no]:
Enter password: <strong>****</strong>
Enter password again: <strong>****</strong>
Lock out the account after creation? [no]:
Username : hoge
Password : *****
Full Name : hoge
Uid : 1002
Class :
Groups : hoge wheel
Home : /home/hoge
Shell : /usr/local/bin/zsh
Locked : no
OK? (yes/no): yes
adduser: INFO: Successfully added (hoge) to the user database.
Add another user? (yes/no): <strong>no</strong>
Goodbye!</pre>
メインユーザを追加するときにはグループにwheelを加えます。追加が完了したら、visudoコマンドでwheelグループのユーザにsudoを使う権限を与えましょう。
<pre class="lang:default decode:true">$ visudo
- # %wheel ALL=(ALL) ALL
+ %wheel ALL=(ALL) ALL</pre>
<h1><a name="ssh"></a>SSHのログイン設定を行う</h1>
ここまでの操作が完了したら、次はパスワードよりもセキュアにログインするために公開鍵認証を用いたログイン方法を設定します。さくらVPS側の操作と、SSHアクセスするローカル側の操作が必要です。今回は端末にMacを想定していますが、WindowsでもPuTTYとかを使えば同様のことができます。

なお、基本的には<a title="Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証" href="http://blog.hifumi.info/dev/play-with-%e3%81%95%e3%81%8f%e3%82%89vps-vii-%e3%82%bb%e3%82%ad%e3%83%a5%e3%83%aa%e3%83%86%e3%82%a3%e8%a8%ad%e5%ae%9a%e3%81%9d%e3%81%ae2/" target="_blank">以前に書いたもの</a>と同じです。

実行手順は以下のとおりです。
<h2>（Mac）ssh-keygenで公開鍵を生成する</h2>
まずはクライアント側で公開鍵・秘密鍵を作成します。やり方は簡単で、ターミナルからssh-keygenコマンドを打つだけです。（Windowsの公開鍵作成については<a title="公開鍵認証でSSH2サーバにログインする（PuTTY編） - @IT" href="http://www.atmarkit.co.jp/fwin2k/win2ktips/1321putykey/putykey.html" target="_blank">こちら</a>をどうぞ）

実行手順は以下のとおりです。
<pre>$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/hoge/.ssh/id_rsa): /Users/hoge/.ssh/sakura
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/hoge/.ssh/sakura.
Your public key has been saved in /Users/hoge/.ssh/sakura.pub.
The key fingerprint is:
**:**:**:**:**:**:**:**:**:**:**:**:**:**:**:** hoge@pcname.local
The key's randomart image is:
+--[ RSA 2048]----+
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
+-----------------+</pre>
鍵の名前は適宜変更してください。
<h2>（Mac）scpでさくらVPSへ公開鍵を転送する</h2>
scpコマンドで公開鍵（秘密鍵ではありません）をさくらVPSへ転送します。

実行手順は以下のとおりです。
<pre>$ scp sakura.pub user@**.**.**.**:authorized_keys</pre>
**.**.**.**のところには<strong>さくらVPSのIPアドレスかホスト名</strong>を記述してください。あとコロン（：）を忘れないように。

今回は公開鍵（sakura.pub）をauthorized_keysと名称変更してさくらVPSへ転送しています。
<h2>（さくらVPS）.sshディレクトリを準備する</h2>
今度はさくらVPS側での操作です。先ほど作成したユーザでさくらVPSへログインしてもらい、.sshディレクトリを作成します。

実行手順は以下のとおりです。
<pre>$ mkdir .ssh
$ chmod 700 .ssh
$ mv authorized_keys .ssh/
$ chmod 600 .ssh/authorized_keys</pre>
chmodで他人から勝手に触られないよう権限を設定しています。
<h2>（さくらVPS）/etc/ssh/sshd_configを編集する</h2>
Macで生成した公開鍵が無事さくらVPSへわたり、これでMacとさくらVPSをつなぐ認証鍵の条件が揃いました。次は、クライアントから公開鍵認証でさくらVPSへログイン出来るようにsshd_configを編集します。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ vi /etc/ssh/sshd_config
  Rootログインの禁止
- PermitRootLogin Yes
+ PermitRootLogin No
  公開鍵認証を許可
- RSAAuthentication no
- PubkeyAuthentication no
+ RSAAuthentication yes
+ PubkeyAuthentication yes
  鍵のパス指定
- #AuthorizedKeysFile&gt; .ssh/authorized_keys
+ AuthorizedKeysFile&gt; .ssh/authorized_keys
  パスワードログインの禁止
- #PasswordAuthentication yes
+ PasswordAuthentication no
  空のパスワードを禁止
- #PermitEmptyPasswords no
+ PermitEmptyPasswords no
  PAMは使わない
- #UsePAM yes
+ UsePAM no
  sshの使用可能なユーザを指定
+ AllowUsers hoge</pre>
※ここのポート番号はFirewallで設定したsshのポート番号と揃えましょう。
<h2>（さくらVPS）sshdの再起動</h2>
sshdを再起動して、先ほどのsshd_configを有効にしましょう。

実行手順は以下のとおりです。
<pre>$ service sshd reload</pre>
<h2>（Mac）.ssh/configを設定する</h2>
ここまで設定すると、ターミナルからログインするためには
<pre>ssh -p ****(ポート番号) -i ~/.ssh/sakura hoge@**.**.**.**</pre>
等と長めの記述が必要なのですが、.sshディレクトリ以下にconfigというファイルを設定することで簡単にログインできるようになります。

実行手順は以下のとおりです。
<pre class="lang:default decode:true">$ vi ~/.ssh/config
# ホスト名（自由に決める）
+ Host sakura
# さくらVPSからもらったIPアドレスかホスト名を入れる
+ HostName **.**.**.**
# adduserで追加したユーザ名を入れる
+ User hoge
# sshのログインポート（通常は22）
+ Port ****
# 公開鍵認証に使う鍵の指定
+ IdentityFile ~/.ssh/sakura</pre>
これによって、次回以降のログインは、
<pre>ssh sakura // configファイルのHostに指定した名前</pre>
で出来ます。
<h1>おしまい</h1>
セキュリティを中心に手順を進めていきましたが、ひとまずこれにてセットアップは完了です。Portsから好きなパッケージを持ってきて、自由に遊びましょう！
<h1>参考</h1>
<ul>
	<li><a title="FreeBSD ハンドブック" href="http://www.freebsd.org/doc/ja_JP.eucJP/books/handbook/index.html" target="_blank">FreeBSD ハンドブック</a></li>
</ul>
