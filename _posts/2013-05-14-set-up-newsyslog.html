---
layout: post
title: FreeBSDのログローテーションをnewsyslogに移行した
categories:
- Dev
tags:
- FreeBSD
- Suburi
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: FreeBSD, Development
  _aioseop_description: "前回、FreeBSDのログローテーションがうまく動作していなかったので、\r\nlogrotateの設定ファイルを正しく記述しなおしました。\r\nしかし、なんとそのあと、FreeBSDには初めからnewsyslogというツールがあることを知り、今回あらたにlogrotateからnewsyslogへの移行を行いました。"
  _aioseop_title: FreeBSDのログローテーションをnewsyslogに移行した
---
前回、FreeBSDのログローテーションがうまく動作していなかったので、
logrotateの設定ファイルを正しく記述しなおしました。
<blockquote><a title="FreeBSDのログローテーションがおかしかったので直した" href="http://blog.hifumi.info/dev/fixed-logrotate-freebsd/">FreeBSDのログローテーションがおかしかったので直した</a></blockquote>
これでログローテーションもバッチリや〜と思っていたんですが、
なんとそのあと、FreeBSDには初めから<strong>newsyslog</strong>というツールがあることを知り、
今回あらたにlogrotateからnewsyslogへの移行を行いました。

<!--more-->
<h1>newsyslog</h1>
newsyslogは<strong>crontab</strong>で動くように設定されています。

/etc/crontabを見ると、FreeBSDを設定した当初からnewsyslogの設定が書かれています。
※当初はさくらVPSのFreeBSD 8.0-RELEASEで、今は9.1-REALSEまでアップグレードしてます
<pre class="lang:default decode:true" title="/etc/crontab"># Rotate log files every hour, if necessary.
0   *   *   *   *   root    newsyslog</pre>
初期設定を見る限り、毎時0分に、1日24回実行されていることが分かります。
あとはnewsyslogの設定ファイルを変更するだけで良さそうです。

その設定ファイルは<strong>/etc/newsyslog.conf</strong>にあります。
<h1>nginxとclamavの場合</h1>
今回はnginxとclamavのために、/etc/newsyslog.confへ次のスクリプトを追加しました。
<pre class="lang:default decode:true" title="/etc/newsyslog.conf">/var/log/nginx/access.log       644  7  *    $D4   JC  /var/run/nginx.pid
/var/log/nginx/error.log        644  7  *    $D4   JC  /var/run/nginx.pid
/var/log/nginx/wp.access.log    644  7  *    $D4   JC  /var/run/nginx.pid
/var/log/nginx/wp.error.log     644  7  *    $D4   JC  /var/run/nginx.pid
/var/log/clamav/clamd.log       644  3  1024 $M1D3 JC  /var/run/clamd.pid
/var/log/clamav/freshclam.log   644  3  1024 $M1D3 JC  /var/run/freshclam.pid</pre>
newsyslog.confへの記述後、 <span class="lang:default decode:true  crayon-inline ">sudo newsyslog</span>を一度実行し、動作を確認しておきましょう。
実行した例は次のとおりです。
<pre class="lang:default decode:true" title="newsyslogの実行例">$ sudo newsyslog -v -f /etc/newsyslog.conf
Processing /etc/newsyslog.conf
/var/log/all.log &lt;7J&gt;: does not exist, skipped.
/var/log/amd.log &lt;7J&gt;: does not exist, skipped.
/var/log/auth.log &lt;7J&gt;: --&gt; will trim at Wed Jan  1 00:00:00 2014
/var/log/console.log &lt;5J&gt;: does not exist, skipped.
/var/log/cron/cron &lt;3J&gt;: size (Kb): 2 [100] --&gt; skipping
/var/log/daily.log &lt;7J&gt;: does not exist, skipped.
/var/log/debug.log &lt;7J&gt;: size (Kb): 2 [100] --&gt; skipping
/var/log/kerberos.log &lt;7J&gt;: does not exist, skipped.
/var/log/lpd-errs &lt;7J&gt;: size (Kb): 2 [100] --&gt; skipping
/var/log/maillog/maillog &lt;5J&gt;: --&gt; will trim at Wed May 15 00:00:00 2013
/var/log/messages/messages &lt;5J&gt;: --&gt; will trim at Wed Jan  1 00:00:00 2014
/var/log/monthly.log &lt;12J&gt;: does not exist, skipped.
/var/log/pflog &lt;3J&gt;: does not exist, skipped.
/var/log/ppp.log &lt;3J&gt;: size (Kb): 2 [100] --&gt; skipping
/var/log/security &lt;10J&gt;: size (Kb): 2 [100] --&gt; skipping
/var/log/sendmail/sendmail.st &lt;10&gt;:  age (hr): 22 [168] --&gt; skipping
/var/log/utx/utx.log &lt;3&gt;: does not exist, skipped.
/var/log/weekly.log &lt;5J&gt;: does not exist, skipped.
/var/log/xferlog &lt;7J&gt;: size (Kb): 2 [100] --&gt; skipping
/var/log/nginx/access.log &lt;7J&gt;: --&gt; will trim at Tue May 14 04:00:00 2013
/var/log/nginx/error.log &lt;7J&gt;: --&gt; will trim at Tue May 14 04:00:00 2013
/var/log/nginx/wp.access.log &lt;7J&gt;: --&gt; will trim at Tue May 14 04:00:00 2013
/var/log/nginx/wp.error.log &lt;7J&gt;: --&gt; will trim at Tue May 14 04:00:00 2013
/var/log/clamav/clamd.log &lt;3J&gt;: --&gt; will trim at Sat Jun  1 03:00:00 2013
/var/log/clamav/freshclam.log &lt;3J&gt;: --&gt; will trim at Sat Jun  1 03:00:00 2013</pre>
ログファイルそのものが存在しない場合はskippingされ、
既にログローテーションされたものに関しては次回予告が表示されています。

newsyslogの実行によってbzip化されたログ（例：nginx）は次のとおりです。
<pre class="lang:default decode:true" title="/var/log/nginx/">-rw-r--r--  1 root  wheel  943886  5月 14 00:47 wp.access.log
-rw-r--r--  1 root  wheel   60089  5月 13 04:00 wp.access.log.0.bz2
-rw-r--r--  1 root  wheel   81156  5月 12 04:00 wp.access.log.1.bz2
-rw-r--r--  1 root  wheel   85927  5月 11 04:00 wp.access.log.2.bz2</pre>
ちゃんとbzip化されてます。

gzipと違ってちょっと時間のかかるbzipですが、ファイルサイズの圧縮率は高いので、
いたずらに/varを圧迫することも無くなったと思います。

良かった！
<h1>参考</h1>
<ul>
	<li><a title="newsyslog.conf - FreeBSD Man Pages" href="http://www.freebsd.org/cgi/man.cgi?query=newsyslog.conf&amp;apropos=0&amp;sektion=0&amp;manpath=FreeBSD+9.1-RELEASE&amp;arch=default&amp;format=html" target="_blank">newsyslog.conf - FreeBSD Man Pages</a></li>
	<li><a title="/var/logの下がえらいことになっていたでござる。（あるいはFreeBSDでログのローテーション設定をするには(logrotateではなくnewsyslog))。" href="http://april.fool.jp/blogs/?p=1828" target="_blank">/var/logの下がえらいことになっていたでござる。（あるいはFreeBSDでログのローテーション設定をするには(logrotateではなくnewsyslog))。</a></li>
	<li><a title="Rotate Nginx log files under FreeBSD" href="http://charles.lescampeurs.org/2008/07/17/rotate-nginx-log-files-under-freebsd" target="_blank">Rotate Nginx log files under FreeBSD</a></li>
</ul>
