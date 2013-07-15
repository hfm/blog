---
layout: post
title: FreeBSDのログローテーションがおかしかったので直した
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
  dsq_thread_id: '1265789209'
  _aioseop_keywords: FreeBSD, Development, Diary
  _aioseop_description: FreeBSDのログローテーションがおかしかったので直したんですが、newsyslogの存在を忘れてましたよ、という効率の悪さが目立つ話。
  _aioseop_title: FreeBSDのログローテーションがおかしかったので直した
---
2013.5.14 ⇒ <a title="FreeBSDのログローテーションをnewsyslogに移行した" href="http://blog.hifumi.info/dev/set-up-newsyslog/">ログローテーションをlogrotateからnewsyslogに移行しました</a>

さくらVPS (FreeBSD) で<span class="lang:default decode:true  crayon-inline ">/var</span> の中身が膨れ上がってきていたので中を見てみたら、logrotateがちゃんと動いておらず、nginxやらclamavやらのログファイルが肥大化していました。

<!--more-->
<h1>logrotate</h1>
一応cronもチェックしましたが、こちらの設定は良好。どうやらlogrotate.conf及びlogrotate.d以下の設定ファイルでの記述ミスが原因でした。特にnginxに関して、結構なボリュームのログが非圧縮で放ったらかし…これはいけない。

そんなわけで、設定ファイルを修正し、 <span class="lang:default decode:true  crayon-inline">$ sudo logrotate /usr/local/etc/logrotate.conf</span> を実行。<span class="lang:default decode:true  crayon-inline">/var</span>の中身はだいぶ軽くなりました（ずっと放置していたわけで、お恥ずかしい限りです…）。

https://gist.github.com/Tacahilo/5523440
<h1>轍踏んじゃった</h1>
と、ここまで書いて同じ現象に遭遇されていらっしゃる方がいるのかな？と思ってググってみたら…
<blockquote>/var/logの下がえらいことになっていたでござる。（あるいはFreeBSDでログのローテーション設定をするには(logrotateではなくnewsyslog))。
<p style="text-align: right;">Nobwak's Lair - <a title="■[FreeBSD] /var/logの下がえらいことになっていたでござる。（あるいはFreeBSDでログのローテーション設定をするには(logrotateではなくnewsyslog))。" href="http://april.fool.jp/blogs/?p=1828" target="_blank">http://april.fool.jp/blogs/?p=1828
</a></p>
</blockquote>
バッチリいらっしゃいました。

実は、FreeBSDでは<strong>newsyslog</strong>というcronで動くログ管理システムが機能しており、maillogやらcronやらのログが標準で管理されています。本来ならnewsyslogログローテーションすれば良かったんですが、その存在を忘れて、logrotateに書いてしまいました。

同じことが出来ればそれでいいんですが、newsyslogとlogrotateが併存してるのもあまり気持ちのよい話ではないので、近いうちにnewsyslogに統一してしまいます。

己の効率の悪さを実感した一日でしたm(_ _ )m
<h1>参考</h1>
<ul>
	<li><a title="[FreeBSD] /var/logの下がえらいことになっていたでござる。（あるいはFreeBSDでログのローテーション設定をするには(logrotateではなくnewsyslog))。" href="http://april.fool.jp/blogs/?p=1828" target="_blank">/var/logの下がえらいことになっていたでござる。（あるいはFreeBSDでログのローテーション設定をするには(logrotateではなくnewsyslog))。</a></li>
	<li><a title="newsyslog" href="http://www.wakhok.ac.jp/~kanayama/summer/02/site/node124.html" target="_blank">newsyslog</a></li>
</ul>
