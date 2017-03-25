---
date: 2017-02-23T07:10:27+09:00
title: HTTPS時代のホスティングを支える動的証明書読み込みとngx_mrubyによる実践
cover: /images/2017/02/13/nagoyark03.jpg
draft: true
tags:
- ngx_mruby
- nginx
- mruby
---
ホスティングサービスにおいて独自ドメインにHTTPSをサポートするケースも出てきた。

ホスティングサービスと独自ドメイン、そしてHTTPS
------------------------

クラウドやVPS, レンタルサーバ、ウェブサイトビルダ、ブログ、ショッピングカート...広い意味でのホスティングサービスにおいて、

レンタルサーバーやウェブサイトビルダー[^1]、ブログサービスはにおいて、独自ドメインのサポートはさほど珍しくないだろう。ユーザに hfm.awesome-blog.jp（サブドメイン方式）や awesome-blog.jp/hfm（URLパス方式と呼べばいいのだろうか）といったURLアドレスを提供し、オプションで独自ドメインを接続するサービス形態だ。独自ドメインのサポートは有料コンテンツの場合もある[^2]が、Tumblr や GitHub Pages のように無料提供されているものもある。

レンタルサーバーやウェブサイトビルダー[^1]、ブログサービスにおいて、独自ドメインのサポートはさほど珍しくないだろう。ユーザに hfm.awesome-blog.jp（サブドメイン方式）や awesome-blog.jp/hfm（URLパス方式と呼べばいいのだろうか）といったURLアドレスを提供し、オプションで独自ドメインを接続するサービス形態だ。独自ドメインのサポートは有料コンテンツの場合もある[^2]が、Tumblr や GitHub Pages のように無料提供されているものもある。

Google Chrome も HTTP 接続を non-secure と表現する[^3]など、HTTPS の流れが本格化して久しいが、

CloudFlare や Amazon CloudFront を使う手もある。CloudFlare は Universal SSL[^4] という無償提供のSSL証明書

CloudFlare はSAN (Subject Alt Name) を用いて共用の SSL 証明書

また、WordPressは2014年からサブドメインのHTTPSをサポートしてきたが、去年の6月からLet's Encryptを使って独自ドメインのHTTPS化をサポートし始めた[^5]。

通常、Webサーバで大量ドメインの証明書を取り扱おうとすると、設定ファイルの長大化やメモリの肥大化を招いてしまうなど非効率な面が目立つ。しかし、ngx_mrubyを用いた動的証明書読み込みなら、簡潔な設定と省メモリで実現することができる。

### HTTP to HTTPS

しかし、Google Chromeを始めとしたブラウザがHTTPS接続を強く推奨するようになり、2017年に入ってからその流れは加速しているように見える https://techcrunch.com/2016/09/08/chrome-is-helping-kill-http/

### 大量ドメインとTLS証明書の課題と解決

- [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について \- 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)

#### TLS SNI拡張

SNI (Server Name Indication)[^6] はクライアントがアクセスしたいホスト名を ClientHello の server_name に含んでサーバに通知し、サーバ側がその server_name に応じた証明書を使い分けるための TLS 拡張仕様である。1つのIPアドレスで複数ドメインのSSL証明書を提供できるようになる。

この拡張仕様は以前からある。nginx は2007年5月30日の http://hg.nginx.org/nginx/rev/86c5c9288acc のコミットからSNIをサポートしている。リリースバージョンはv0.5.23だ。

[SNIで1台のサーバ上に複数のSSLサイトを運用 – 前編 \- さくらのナレッジ](http://knowledge.sakura.ad.jp/tech/3160/)

しかし、このHTTPS時代において

#### nginxに大量ドメイン用の設定ファイルと証明書を読み込ませる

通常、Webサーバで大量ドメインの証明書を取り扱おうとすると、設定ファイルの長大化やメモリの肥大化を招いてしまうなど非効率な面が目立つ。

以下は、Dockerコンテナを検証環境として、1万のドメイン証明書を読み込んだnginxプロセスを動かしたときのRSSである。RSSの単位はキロバイトなので、master と worker をあわせて500MB以上のメモリを要求していることになる。

```console
[root@2be3ca1fae41 /]# ps axfo rss,cmd | grep [n]ginx
256164 nginx: master process nginx
258476  \_ nginx: worker process
```

HUPシグナルを送るとRSSが倍増する。

```console
[root@2be3ca1fae41 /]# pkill -HUP -u root -f nginx
[root@2be3ca1fae41 /]# ps axfo rss,cmd | grep [n]ginx
514352 nginx: master process nginx
512636  \_ nginx: worker process
```

このような環境を再現できるDockerfileを以下のGistに公開した。OpenSSL による大量の証明書生成処理に大変時間がかかるので、試す場合は気長に待ってほしい。

- https://gist.github.com/hfm/4a045a429f9303c90eac7c348d1a424a

ngx_mrubyを用いた動的証明書読み込み
----------------------

### 証明書を要求されたタイミングで任意のコールバック関数を実行する OpenSSL 1.0.2で追加されたSSL_CTX_set_cert_cb関数

2015年1月にリリースされたOpenSSL 1.0.2に、しれっと重要な関数が追加されている。

> \*) Add certificate callback. If set this is called whenever a certificate is required by client or server. An application can decide which certificate chain to present based on arbitrary criteria: for example supported signature algorithms. Add very simple example to s_server.  This fixes many of the problems and restrictions of the existing client certificate callback: for example you can now clear an existing certificate and specify the whole chain. [Steve Henson]
> _https://www.openssl.org/news/cl102.txt_

これだけだと、一体どの関数を指しているのかわかりづらいが、この証明書コールバック関数が[SSL_CTX_set_cert_cb](https://www.openssl.org/docs/man1.0.2/ssl/SSL_CTX_set_cert_cb.html)である。調べるの大変だった[^4]。この関数は常にクライアントとサーバーの両方から呼び出され、デフォルトの証明書を変更できる。

blockquote class="twitter-tweet" data-lang="ja"><p lang="en" dir="ltr">ngx_mruby supports dynamic certificate change each tls sessions / “Support ssl_handshake handler and dynamic certi…” <a href="https://t.co/PK7qGv5ctP">https://t.co/PK7qGv5ctP</a></p>&mdash; 松本 亮介 / まつもとりー (@matsumotory) <a href="https://twitter.com/matsumotory/status/685341115814289408">2016年1月8日</a></blockquote>

### アーキテクチャ


```nginx
mruby_ssl_handshake_handler /path/to/ssl_handler.rb cache;
```

#### 素朴な実装
#### DBに証明書を管理させる
#### キャッシュサーバで応答を高速化

### 実装

#### nginx workerの初期化

mruby_init_worker.rb

```rb
# Initialize redis connection
redis = Redis.new '<redis-server>', 6379
Userdata.new("redis_#{Process.pid}").redis_connection = redis unless redis.nil?

# Initialize mysql connection
mysql = MySQL::Database.new('host', 'user', 'pass', 'db')
Userdata.new("mysql_#{Process.pid}").mysql_connection = mysql unless mysql.nil?
```

mruby_exit_worker.rb

```rb
# Close all connections

redis = Userdata.new("redis_#{Process.pid}").redis_conn
redis.close unless redis.nil?

mysql = Userdata.new("mysql_#{Process.pid}").mysql_conn
mysql.close unless mysql.nil?
```

#### "MySQL server has gone away." 対策

reconnection

```rb
def mysql_reconnect
  mysql = MySQL::Database.new('host', 'user', 'pass', 'db')
  Userdata.new("mysql_#{Process.pid}").mysql_conn = mysql
end

...

begin
  row = mysql.execute('SELECT crt, key FROM db.ssl WHERE domain = ?', servername)
rescue
  mysql_reconnect
  retry
end
```

```rb
def get_crt_and_key
  crt = ''
  key = ''

  if cached?
    crt, key = redis.hmget domain, 'crt', 'key'
  else
    begin
      row = mysql.execute('SELECT crt, key FROM db.ssl WHERE domain = ?', servername)
    rescue
      mysql_reconnect
      retry
    end
    crt, key = row.next
    row.close

    redis.hmset domain, 'crt', crt, 'key', key unless crt.nil?
    redis.expire domain, EXPIRE_TIME if cached?
  end

  if crt.nil?
    [nil, nil]
  else
    [concat_crts(crt.chomp), key]
  end
end
```

```rb
def redis
  Userdata.new("redis_#{Process.pid}").redis_connection
end

def mysql
  Userdata.new("mysql_#{Process.pid}").mysql_connection
end
```

```rb
ssl = Nginx::SSL.new
crt, key = GoopeFetchCrt.new(ssl.servername).get_crt_and_key

if crt.nil? or key.nil?
  ssl.certificate = '/path/to/wildcard.example.com.crt'
  ssl.certificate_key = '/path/to/wildcard.example.com.key'
else
  ssl.certificate_data = crt
  ssl.certificate_key_data = key
end
```

### テスト

[mruby のテスト用に MySQL 環境を自動で構築する mruby\-test\-mysqld を書いた](/2016/09/06/mruby-test-mysqld/)

iframe src="//www.slideshare.net/slideshow/embed_code/key/j0PpI67kQB6Gqg" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hsbt/20150525-testing-casualtalks" title="How to test code with mruby" target="_blank">How to test code with mruby</a> </strong> from <strong><a target="_blank" href="//www.slideshare.net/hsbt">Hiroshi SHIBATA</a></strong> </div>

### LRUキャッシュによる更なる応答高速化

Webサーバでデータベースやキャッシュにアクセスするとなると、パフォーマンスの低下が気になってくると思う。

実際のところ、動的証明書読み込みによるレイテンシは無視できるほど小さくて、それよりもアプリケーションのレイテンシの方が非常に大きい。アプリケーションのパフォーマンスが悪いということではなく、両者のレイテンシを比べると、片方が無視できるほどに小さいというだけ。

ngx_lua (OpenResty) による別解
-------------------------

ngx_luaの[ssl_certificate_by_lua\*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block)ディレクティブを使えば同様の仕組みを実現できる。

[OpenResty で証明書の動的読み込み \- Qiita](http://qiita.com/Hexa/items/07e8b0d942576375d1f7)

名古屋Ruby会議03
-----------

2/11(土)に開催された[名古屋Ruby会議03](http://regional.rubykaigi.org/nagoya03/)にて、"Dynamic certificate internals with ngx_mruby" というタイトルで発表した。昨年[GMO HosCon 2016](https://gmohoscon.connpass.com/event/41490/)の10分LT枠で話した[動的証明書読み込み ngx_mruby編](https://speakerdeck.com/hfm/gmo-hoscon-2016)の拡張版という位置づけで、動的証明書読み込みの必要性と実装について話してきた。

script async class="speakerdeck-embed" data-id="7164b59d4d25446aa6f4569440e2fc52" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

発表の舞台は大須演芸場という寄席。太鼓の出囃子で入場し、座布団に座って発表するという一風変わった舞台だった。意気込んで英語スライドを引っさげて行ったので、和洋混在になってしまったがよしとする。

blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">英字の発表で、和と洋が入り乱れてる感しゅごい。<a href="https://twitter.com/hashtag/nagoyark03?src=hash">#nagoyark03</a> <a href="https://t.co/qJTDRWDfQ4">pic.twitter.com/qJTDRWDfQ4</a></p>&mdash; だびっつ (@dabits) <a href="https://twitter.com/dabits/status/830289736056991744">2017年2月11日</a></blockquote>
script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

参考
---

- https://github.com/mruby/mruby
- [200万 Webサイトを支える ロリポップ！と mruby](https://speakerdeck.com/harasou/200mo-websaitowozhi-eru-roripotupu-to-mruby)
- [ngx_mruby の Nginx::Var クラスの実装を理解する〜変数取得編](/2016/11/07/ngx_mruby-nginx-var-using-method-missing/)
- How to build ngx_mruby:
  - https://github.com/matsumotory/ngx_mruby/wiki/Install
  - https://github.com/hsbt/ngx_mruby-package-builder
  - https://hub.docker.com/r/hfmgarden/ngx_mruby
  - https://github.com/giraffi/docker-nginx-mruby-base
- https://goope.jp
- https://gist.github.com/hfm/4a045a429f9303c90eac7c348d1a424a
- https://www.openssl.org/docs/man1.0.2/ssl/SSL_CTX_set_cert_cb.html
- https://twitter.com/matsumotory/status/685341115814289408
- [ngx_mruby に mruby_ssl_handshake_handler を実装した](http://blog.hifumi.info/2016/10/03/ngx_mruby-mruby_ssl_handshake_handler/)
- [mruby のテスト用に MySQL 環境を自動で構築する mruby-test-mysqld を書いた](http://blog.hifumi.info/2016/09/06/mruby-test-mysqld/)
- [How to test code with mruby](http://www.slideshare.net/hsbt/20150525-testing-casualtalks)
- [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について \- 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)

[^1]: デザインテンプレート等を用いて、コーディング知識不要でウェブサイトを構築、公開できるサービス。国内だとホームページ作成サービス等とも呼ばれる
[^2]: 独自ドメインの設定自体は無料だが、それを適用できるプランにお金がかかるとか、色々ある
[^3]: https://security.googleblog.com/2016/09/moving-towards-more-secure-web.html
[^4]: https://blog.cloudflare.com/introducing-universal-ssl/
[^5]: https://en.blog.wordpress.com/2016/04/08/https-everywhere-encryption-for-all-wordpress-com-sites/
[^6]: https://tools.ietf.org/html/rfc6066#section-3
[^7]: https://www.mail-archive.com/openssl-users@openssl.org/msg72943.html
[萩原栄幸の情報セキュリティ相談室：「HTTP」前提が崩れる――早く「常時SSL」にすべき理由 \(1/3\) \- ITmedia エンタープライズ](http://www.itmedia.co.jp/enterprise/articles/1505/22/news086.html)
