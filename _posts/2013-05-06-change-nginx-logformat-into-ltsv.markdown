---
layout: post
title: サーバで動かしているnginxのログをLTSVに変更した
categories:
- Dev
tags:
- FreeBSD
- Nginx
- Suburi
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  dsq_thread_id: '1266014741'
  _aioseop_keywords: FreeBSD, Development, nginx
  _aioseop_description: nginxのアクセスログをLTSVに変更しました。LTSVはLabeled Tab-separated Valuesの略称で、アクセスログの各パラメータを「label-name:value」と表記し、それらをタブ区切りでつなげるシンプルな構造から、パースの容易さや他プログラムとの連携の強さに特徴があります。
  _aioseop_title: サーバで動かしているnginxのログをLTSVに変更した
---
このブログはさくらVPS上の<strong>nginx</strong>で動いています。

nginx（エンジンエックス）はApacheと同じWebサーバの一種で、メモリ使用量の少なさ等の特徴から、低スペックなサーバでの安定した動作に定評があります。詳細については<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4048702270/hifumiass-22/ref=nosim/" target="_blank" name="amazletlink">ハイパフォーマンスHTTPサーバ Nginx入門</a>を、実際の導入や動作は<a title="入門！ nginx" href="http://d.hatena.ne.jp/shim0mura/20120110/1326198429" target="_blank">こちらのブログ記事</a>が詳しいです。

今回は、nginxのログを標準形式から<strong>LTSV形式</strong>へと変更しました。ゆくゆくはfluentdとGrowthForecastを導入し、ログを可視化してみようと考えていて、そのためのワンステップという位置づけです。

<!--more-->
<h1>LTSVなnginxのログ形式</h1>
LTSVは<strong>Labeled Tab-separated Values</strong>の略称です。

アクセスログから得られる各パラメータを「label-name:value」と表記し、それらをタブ区切りでつなげるシンプルな構造から、パースの容易さや他プログラムとの連携の強さに特徴があるようです。
<blockquote>Labeled Tab Separated Values (LTSV) ノススメ
<p style="text-align: right;">stanaka's blog - <a title="Labeled Tab Separated Values (LTSV) ノススメ" href="http://blog.stanaka.org/entry/2013/02/05/214833" target="_blank">http://blog.stanaka.org/entry/2013/02/05/214833</a></p>
</blockquote>
実際、私が運用しているFreeBSD上のnginxでは次のようなログフォーマットを定義しています。
<pre class="lang:default decode:true" title="nginx.conf">log_format  ltsv    "time:$time_local"
                    "\thost:$remote_addr"
                    "\tuser:$remote_user"
                    "\tmethod:$request_method"
                    "\turi:$request_uri"
                    "\tprotocol:$server_protocol"
                    "\treq:$request"
                    "\tstatus:$status"
                    "\tsize:$body_bytes_sent"
                    "\treferer:$http_referer"
                    "\tua:$http_user_agent"
                    "\treqtime:$request_time"
                    "\tcache:$upstream_http_x_cache"
                    "\truntime:$upstream_http_x_runtime"
                    "\tvhost:$host";
access_log  /var/log/nginx/access.log  ltsv;</pre>
次のようなログが出力されます。
<pre class="lang:default decode:true" title="LTSVフォーマットなnginxログ">time:06/May/2013:19:10:29 +0900 host:***.***.***.***     user:-  method:GET      uri:/feed/      protocol:HTTP/1.1       req:GET /feed/ HTTP/1.1 status:200      size:27655      referer:-       ua:**** http://****/    reqtime:0.000
   cache:- runtime:-       vhost:blog.hifumi.info</pre>
ブログ上では半角スペースになってしまっていますが、サーバのログには正しくTabが挿入されています。また、「<em>method:GET</em>」や「<em>uri:/feed/</em>」のように、各パラメータの名前と値が非常にシンプルな関係で配置されています。
<h1>（補足）デフォルトのnginxのログ形式</h1>
ちなみに、nginxが標準で用意しているログフォーマットは次のとおりです。
<pre class="lang:default decode:true" title="nginx.conf-dist">log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                  '$status $body_bytes_sent "$http_referer" '
                  '"$http_user_agent" "$http_x_forwarded_for"';</pre>
次のようなログが出力されます。
<pre class="lang:default decode:true" title="デフォルトのログ">127.0.0.1 - - [06/May/2013:19:39:27 +0900] "POST /wp-admin/admin-ajax.php HTTP/1.0" 200 342 "http://blog.hifumi.info/wp-admin/post.php?post=4339&amp;action=edit&amp;message=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.73 Safari/537.36" "***.***.***.***, ***.***.***.***"</pre>
このログを各パラメータごとに適切にパースしてDB等に格納したりして…という手順を考えるに結構な手間です。それに比べると、LTSVは非常に簡潔な表記で、分かりやすいです。
<h1>参考</h1>
<ul>
	<li><a title="入門！ nginx" href="http://d.hatena.ne.jp/shim0mura/20120110/1326198429" target="_blank">入門！ nginx</a></li>
	<li><span style="line-height: 13px;"><a title="Labeled Tab-separated Values" href="http://ltsv.org/" target="_blank">Labeled Tab-separated Values</a>
</span></li>
	<li><a title="Labeled Tab Separated Values (LTSV) ノススメ" href="http://blog.stanaka.org/entry/2013/02/05/214833" target="_blank">Labeled Tab Separated Values (LTSV) ノススメ</a></li>
	<li><a title="【今北産業】3分で分かるLTSV業界のまとめ【LTSV】" href="http://d.hatena.ne.jp/naoya/20130207/1360240992" target="_blank">【今北産業】3分で分かるLTSV業界のまとめ【LTSV】</a></li>
	<li><a title="LTSV FAQ - LTSV って何? どういうところが良いの?" href="http://d.hatena.ne.jp/naoya/20130209/1360381374" target="_blank">LTSV FAQ - LTSV って何? どういうところが良いの?</a></li>
</ul>
