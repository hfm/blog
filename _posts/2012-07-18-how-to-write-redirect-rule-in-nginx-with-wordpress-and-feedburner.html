---
layout: post
title: NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
categories:
- Dev
tags:
- Nginx
- Server
- Wordpress
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/P7Afc4
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/dev/how-to-write-redirect-rule-in-nginx-with-wordpress-and-feedburner/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:12:{i:0;s:169:"【ブログ更新】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:1;s:169:"【ブログ更新】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:2;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:3;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:4;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:5;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:6;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:7;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:8;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:9;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:10;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";i:11;s:169:"【ブログ編集】 NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
    http://bit.ly/P7Afc4 - NGINX   Wordpress   FeedBu";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '1713'
  _aioseop_keywords: Wordpress,NGINX,.htaccess,FeedBurner
  _aioseop_description: NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
  _aioseop_title: NGINXで運営するWordpressのRSSにFeedBurnerを適応する際のRewriteルールの書き方
  dsq_thread_id: '1227693493'
---
[caption id="attachment_1713" align="aligncenter" width="300"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/07/nginx_logo.png"><img class="size-full wp-image-1713" title="nginx_logo" src="http://blog.hifumi.info/wp-content/uploads/2012/07/nginx_logo.png" alt="NGINX" width="300" height="300" /></a> NGINXは素晴らしい[/caption]

NGINX + Wordpress + FeedBurnerの利用には、リダイレクトルールをRewriteする方法がオススメです。

<a href="http://bit51.com/software/primary-feedburner/" target="_blank">Primary Feedburner</a>のようなプラグインはApacheでの動作を前提としておりますので、NGINXではリダイレクトルールがうまく働きません。プラグインは一見便利そうに見えて、サーバとの連携が上手くいかないと途端にポンコツ化するので注意が必要です。Apacheならいいんでしょうね、Apacheなら…。

さて、件の実現を結論から書くと、RewriteルールをNGINX設定ファイルのserverブロックに記述します。次のとおりです。
<pre>if ($http_user_agent !~ FeedBurner) {
    rewrite ^/comment/feed http://feeds.feedburner.com/your.commentfeed.name last;
    rewrite ^/feed http://feeds.feedburner.com/your.feed.name last;
}</pre>
<span style="font-size: 10px;">※リバースプロキシを使用している場合は、フロントエンド（80番ポート）のserverブロックの方に記述します。</span>

これによってFeedBurnerエージェントのアクセス以外は、キチンとブログフィードをFeedBurnerへリダイレクトするようになります。

ここから先は本記述に至るまでのプロセスメモになります。

<!--more-->
<h1>Primary FeedburnerがNGINXで使えない？！</h1>
初めはPrimary Feedburnerプラグインを使用していました。

いちおうブログに見えているフィードアイコンはきちんとFeedBurnerアドレスを示していたので気づかなかったのですが、ふとサーバの方を見ると、Wordpressの.htaccessにこんな記述がありました。
<pre><span style="color: #888888;"><em># BEGIN Primary Feedburner</em></span>
RewriteEngine On
RewriteBase /
RewriteCond %{HTTP_USER_AGENT} !^(FeedBurner|FeedValidator) [NC]
RewriteRule ^feed/?([_0-9a-z-]+)?/?$ http://feeds.feedburner.com/Caci [R=301,NC,L]

RewriteEngine On
RewriteBase /
RewriteCond %{HTTP_USER_AGENT} !^(FeedBurner|FeedValidator) [NC]
RewriteRule ^comments/feed/?([_0-9a-z-]+)?/?$ http://feeds.feedburner.com/hifumi/PBxT [R=301,NC,L]
<span style="color: #888888;"><em># END Primary Feedburner</em></span></pre>
Primary Feedburnerはブログフィードのリンク先をFeedBurnerへと置換するプラグインです。しかし、クローラ等が<a href="http://blog.hifumi.info/feed/" target="_blank">http://blog.hifumi.info/feed/</a>などへ直接アクセスする際には.htaccessのリダイレクトルールで対応していたようでした。

ところがNGINXでは.htaccessは使えません。Apacheなら問題ないのですが、NGINXをWebサーバとして使用する以上、.htaccessではなくNGINXの設定ファイルの方でRewriteを記述していくしかありません。

そしてNGINXの設定ファイルに直接書き込む以上、プラグインって必要ないよね…ということでぼくはPrimary Feedburnerと別れを告げました。
<h1>locationブロックで対応する</h1>
ネットで調べたところ、NGINX + Wordpress + FeedBurnerという組み合わせで運営する方法では以下のブログがまず見つかりました。
<blockquote><a title="nginxでFeedBurnerのクローラーだけ受け入れる方法 - Azrael" href="http://zafiel.wingall.com/archives/3417" target="_blank">nginxでFeedBurnerのクローラーだけ受け入れる方法</a>，Azrael</blockquote>
件のコード部分を引用します。
<pre>location /feed {
<span style="color: #888888;"><em> # FeedburnerのクローラーはWebサーバーに流す </em></span>   if ($http_user_agent ~ ^FeedBurner) {
        proxy_pass http://127.0.0.1:8000/;
        break;
    }

<span style="color: #888888;"><em> # 他はFeedBurnerにリダイレクト </em> </span>   rewrite ^(.*) http://feeds.feedburner.com/azrael last;
    break;
}</pre>
locationブロックを使った対応です。この構成の意図を著者の言葉で表すと、
<blockquote>
<ul>
	<li>一般ユーザーがWordPressのRSS( http://zafiel.wingall.com/feed )を見た場合はFeedBurnerに移動するようにします。</li>
	<li>FeedBurnerのクローラーだけはRSSを読めるようにします。</li>
</ul>
</blockquote>
ということだそうです。その意図を実現する上記のコードについて、紐解いていきましょう。
まず次に示す、最も外側のスコープです。
<pre>location /feed {
    ...
 }</pre>
これは「feedで始まるアドレスへのアクセスがあった場合」という条件分岐になります。RSSフィードへアクセスがあれば、このlocationブロックが対応します。
次です。
<pre>if ($http_user_agent ~ ^FeedBurner) {
    proxy_pass http://127.0.0.1:8000/;
    break;
}</pre>
これは「アクセスしてきたユーザエージェントがFeedBurnerであった場合」という条件分岐になります。FeedBurnerのクローラがアクセスしてきたら、リバースプロキシに直接通してあげよう、つまり勝手にリダイレクトせずにブログを直接見せてあげようというルールになります。これによってFeedBurnerのクローラだけはRSSが読めるようになります。
次です。
<pre>rewrite ^(.*) http://feeds.feedburner.com/azrael last;
break;</pre>
これは先ほどの条件分岐の先にあるので、「FeedBurner以外のアクセスだった場合」に、「feedへのアクセスをFeedBurnerへリダイレクトする」というルールになります。

これで確かにブログフィードへのアクセスがあった場合に、FeedBurnerクローラとそれ以外とを分け、適切にリダイレクトするルールが完成しています。
<h1>Serverブロックで対応する</h1>
先ほどのlocationブロックの記述でも十分対応できるのですが、コードがやや長めです。というのも、
<ol>
	<li>アクセス先（feedかどうか）をチェックする</li>
	<li>ユーザエージェントをチェックする</li>
	<li>全てパスした場合にのみ、リダイレクトする</li>
</ol>
という最大３段階に及ぶ遷移を実現するのに、一つ一つを丁寧に記述したせいで少しコードが冗長化しているように見えます。

他にいい書き方はないものかなあと探していたら、ここへたどり着きました。
<blockquote><a href="http://wiki.dreamhost.com/Nginx#FeedBurner" target="_blank">Nginx</a>，Dreamhost</blockquote>
ここのFeedBurnerの欄に書いてあったコードを引用します。
<pre>rewrite ^/comment/feed/ http://feeds.feedburner.com/your-comment-feed last;
rewrite ^/feed/ http://feeds.feedburner.com/your-feed last;</pre>
最初に示したコードとほとんど一緒で、最終的にぼくはこのコードを流用しています。唯一異なるのは、引用では<em>^/feed/</em>となっているところを改変したコードでは<em>^/feed</em>としているところです。

この違いは、<em>http://blog.hifumi.info/feed/ </em>と <em>http://blog.hifumi.info/feed </em>の違いに対応しています。

どういうことか。実際、http://blog.hifumi.info/feed の方へアクセスがあった場合はどのようになっているか。wgetで実験してみました。
<h1>無駄なリダイレクトは減らしたい</h1>
Dreamhoshにあったリダイレクトの記述は <em>http://blog.hifumi.info/feed/ </em>に対応していましたが、<em>http://blog.hifumi.info/feed </em>には対応していません。別にそれでも問題ないのですが、実はこの設定では <em>http://blog.hifumi.info/feed </em>にアクセスした時に余計な手間が増えています。

実験的に、Dreamhostの設定で <em>http://blog.hifumi.info/feed </em>にアクセスしたらどのようにリダイレクトされるのか確認してみましょう。wgetコマンドをスパイダーモードで試してみました。
<pre><span style="color: #888888;">$ wget -S --spider http://blog.hifumi.info/feed</span>
スパイダーモードが有効です。リモートファイルが存在してるか確認します。
<strong>--2012-07-15 17:55:04-- http://blog.hifumi.info/feed</strong>
blog.hifumi.info (blog.hifumi.info) をDNSに問いあわせています... 219.94.241.187
blog.hifumi.info (blog.hifumi.info)|219.94.241.187|:80 に接続しています... 接続しました。
HTTP による接続要求を送信しました、応答を待っています... 
 HTTP/1.1 301 Moved Permanently
 Server: nginx
 Date: Sun, 15 Jul 2012 08:55:04 GMT
 Content-Type: text/html; charset=UTF-8
 Connection: keep-alive
 X-Pingback: http://blog.hifumi.info/xmlrpc.php
 ETag: "bf4b77627d3be17f62b4b811c8c743b2"
 X-NGINX-CACHED: YES - 600 secs
 X-NGINX-CACHED-AT: 2012-07-15T08:55:04+00:00
 Location: http://blog.hifumi.info/feed/
場所: http://blog.hifumi.info/feed/ [続く]

スパイダーモードが有効です。リモートファイルが存在してるか確認します。
<strong>--2012-07-15 17:55:04-- http://blog.hifumi.info/feed/</strong>
blog.hifumi.info (blog.hifumi.info)|219.94.241.187|:80 に接続しています... 接続しました。
HTTP による接続要求を送信しました、応答を待っています... 
 HTTP/1.1 302 Moved Temporarily
 Server: nginx
 Date: Sun, 15 Jul 2012 08:55:04 GMT
 Content-Type: text/html
 Connection: keep-alive
 Location: http://feeds.feedburner.com/Caci
場所: http://feeds.feedburner.com/Caci [続く]

スパイダーモードが有効です。リモートファイルが存在してるか確認します。
<strong>--2012-07-15 17:55:04-- http://feeds.feedburner.com/Caci</strong>
feeds.feedburner.com (feeds.feedburner.com) をDNSに問いあわせています... 173.194.38.3, 173.194.38.4, 173.194.38.5, ...
feeds.feedburner.com (feeds.feedburner.com)|173.194.38.3|:80 に接続しています... 接続しました。
HTTP による接続要求を送信しました、応答を待っています... 
 HTTP/1.1 200 OK
 Content-Type: text/xml; charset=UTF-8
 ETag: iLzDGMo1+49IMbwMkpBWEwEAKS4
 Last-Modified: Sun, 15 Jul 2012 08:51:04 GMT
 Date: Sun, 15 Jul 2012 08:55:04 GMT
 Expires: Sun, 15 Jul 2012 08:55:04 GMT
 Cache-Control: private, max-age=0
 X-Content-Type-Options: nosniff
 X-XSS-Protection: 1; mode=block
 Server: GSE
 Transfer-Encoding: chunked
長さ: 特定できません [text/xml]
リモートファイルが存在します。</pre>
この通り、<em>http://blog.hifumi.info/feed </em>にアクセスすると、一度 <em>http://blog.hifumi.info/feed/ </em>に飛ばされ、そのあと更にFeedBurnerにリダイレクトされています。

[caption id="attachment_1708" align="aligncenter" width="376"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/07/redirectflow.png"><img class="size-full wp-image-1708" title="redirectflow" src="http://blog.hifumi.info/wp-content/uploads/2012/07/redirectflow.png" alt="" width="376" height="419" /></a> /feed→/feed/への余計なリダイレクトが入る[/caption]

この程度のリダイレクトは気にするほどの大きな遅延でもないのですが、こういうのが積もり積もっていくことでWebサイトはずっしりしていくので、注意していきたいです。
<h1>で、結局</h1>
一番初めに戻って、
<pre>if ($http_user_agent !~ FeedBurner) {
    rewrite ^/comment/feed http://feeds.feedburner.com/your.commentfeed.name last;
    rewrite ^/feed http://feeds.feedburner.com/your.feed.name last;
}</pre>
このリダイレクトルールを書いておけば、こちらは<em>/feed</em>にも<em>/feed/</em>にも対応していますので、どちらにアクセスされても一度の遷移だけで解決してくれます。たかだか小さなことでえらく長いエントリになってしまった…。

[caption id="" align="aligncenter" width="300"]<a href="http://www.amazon.co.jp/gp/product/4048702270/ref=as_li_ss_tl?ie=UTF8&amp;camp=247&amp;creative=7399&amp;creativeASIN=4048702270&amp;linkCode=as2&amp;tag=hifumiass-22" target="_blank"><img class="    " title="ハイパフォーマンスHTTPサーバ Nginx入門" src="http://ecx.images-amazon.com/images/I/51xpswg%2BkkL.jpg" alt="ハイパフォーマンスHTTPサーバ Nginx入門" width="300" height="387" /></a> ハイパフォーマンスHTTPサーバ Nginx入門<br />※画像をクリックするとAmazonのページへ移動します[/caption]
