---
layout: post
title: Play with さくらVPS vi セキュリティ設定その1 iptables
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
  _wp_old_slug: play-with-%e3%81%95%e3%81%8f%e3%82%89vps-6-of-steps-%e3%82%bb%e3%82%ad%e3%83%a5%e3%83%aa%e3%83%86%e3%82%a3%e8%a8%ad%e5%ae%9a%e3%81%9d%e3%81%ae1
  _yoast_wpseo_metadesc: 前回（Play with さくらVPS 1 to 5 steps 初期設定）からの続きです。今回はiptablesに関する設定メモです。
  _yoast_wpseo_metakeywords: さくらVPS,CentOS
  _yoast_wpseo_title: Play with さくらVPS 6 of steps セキュリティ設定その1
  _aioseop_keywords: さくらVPS,CentOS,iptables,ファイアウォール
  _aioseop_description: iptablesによるファイアウォールの構築を、さくらVPS上のCentOSで実装する方法。
  _aioseop_title: Play with さくらVPS vi セキュリティ設定その1 iptables
  dsq_thread_id: '1225971110'
---
前回　<a title="Play with さくらVPS" href="http://blog.hifumi.info/dev/play-with-%e3%81%95%e3%81%8f%e3%82%89vps/">Play with さくらVPS 1 to 5 steps 初期設定</a>

前回からの続きです。今回はiptablesに関する設定メモです。
<h1>目次</h1>
<a href="#6-iptables">6. iptablesで設定をする</a>
<a href="#6-1-iptables">6.1. 注意書き</a>
<a href="#6-2-iptables">6.2. iptablesでファイアウォール構築<!--more--></a>
<h1><a name="6-iptables"></a>6. iptablesの設定をする</h1>
<h2><a name="6-1-iptables"></a>6.1. 注意書き</h2>
参考にしたサイトにも書いてあった警告を引用させて頂きます。
<blockquote>ファイルの内容は SyntaxHighlighter Evolved という WordPress プラグインで色つけをおこなっている。しかし現行のバージョン 3.1.1 では、空行が「改行」ではなく「半角スペース + 改行」になってしまう。iptables はそのような行を検出するとエラーとなるため、このページから設定をコピペする場合は、6、17、24、26 行目を「半角スペース + 改行」から「改行」に修正する必要がある。

半角スペースを表示できるテキスト エディタで修正してからコピペするのが安全だと思われる。また、行末に空白が入ったり、最終行の COMMIT 末尾の空白や改行もエラーになるので注意すること。
<p style="text-align: right;">さくらのVPS を使いはじめる 3 – iptables を設定する</p>
</blockquote>
以下の設定をコピペする際は上記の警告をよく読んでお使いください。
<h2><a name="6-2-iptables"></a>6.2. iptablesでファイアウォール構築</h2>
具体的には/etc/sysconfig/iptablesを以下のように設定しました。iptablesという名前のファイルは、標準では無い（iptables.defaultとかになってる）と思うので、viコマンドやtouchコマンドでもなんでもいいので、新規作成しましょう。
<pre>iptablesファイルを作成する
user $sudo vi /etc/sysconfig/iptables</pre>
<pre>/etc/sysconfig/iptablesファイルの設定
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:RH-Firewall-1-INPUT - [0:0]

-A INPUT -j RH-Firewall-1-INPUT
-A FORWARD -j RH-Firewall-1-INPUT
-A RH-Firewall-1-INPUT -i lo -j ACCEPT
-A RH-Firewall-1-INPUT -p icmp --icmp-type any -j ACCEPT
-A RH-Firewall-1-INPUT -p 50 -j ACCEPT
-A RH-Firewall-1-INPUT -p 51 -j ACCEPT
-A RH-Firewall-1-INPUT -p udp --dport 5353 -d 224.0.0.251 -j ACCEPT
-A RH-Firewall-1-INPUT -p udp -m udp --dport 631 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 631 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# SSH, HTTP, HTTPS, FTP1, FTP2, MySQL, PostgreSQL
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 20 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT

-A RH-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited
COMMIT</pre>
上記で開いてるポートは、それぞれSSH用、HTTP/HTTPS用、FTP用（2つ）、MySQL用、そして使うか分からないんですがPostgreSQL用です。

SSHだけ一般的に使われる22番から変更していますが、そのまま書いておきました。変更したい方は19行目の数字を22から好きな番号へ変更してください。

…ファイアウォールの構築（安全なセキュリティ構築）は未だによくわかっていなくて、<a title="【さくらのVPS】iptablesでファイアーウォールを構築してみた" href="http://www.iex3.info/archives/1145" target="_blank">こちらのサイト</a>を見るに、同じさくらVPSの利用者さんとは思えない記述量です。

まあでもポートをちゃんと閉じるだけでもそれなりに効果はあると思うので、最低限これぐらいはやっておきたいですね、というぐらいのつもりでメモしました。

[amazon asin=4798028622&amp;template=wishlist&amp;chan=default]

こういう本を読んで勉強をしたほうがいいのか…Linuxじゃないにしても、ネットワークの知識はどれだけ深くても足りません。時間があるときに図書館にでも寄ってセキュリティの本借りたほうがよさそう。
