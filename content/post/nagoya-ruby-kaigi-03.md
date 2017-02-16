---
date: 2017-02-13T15:51:32+09:00
title: HTTPS時代を支える動的証明書読み込みとngx_mrubyによる実践
cover: /images/2017/02/13/nagoyark03.jpg
draft: true
tags:
- ngx_mruby
- nginx
- mruby
---

- ホスティング系には独自ドメインの接続を提供するサービスがあるが、証明書のセットアップまでを提供する事業は少ない
- ユーザの証明書を管理するコストが今までは大きかった
- しかし、Google Chromeを始めとしたブラウザがHTTPS接続を強く推奨するようになり、2017年に入ってからその流れは加速しているように見える https://techcrunch.com/2016/09/08/chrome-is-helping-kill-http/
- この課題に
- 通常、Webサーバで大量ドメインの証明書を取り扱おうとすると、設定ファイルが長大になり、プロセスのメモリが肥大する等非効率な面が目立つ
- Webサーバの起動時にすべての設定・すべての証明書を読み込もうとする発想を止めて、クライアントからのリクエストに応じて必要な証明書を動的に読み込むアプローチがある
- 今回はngx_mrubyを用いた動的証明書読み込みの導入方法について紹介したい

レンタルサーバーやブログサービスにおいて、独自ドメインのサポートはさほど珍しくないだろう。awesome-blog.jp という仮のブログサービスに対し、契約ユーザには hfm.awesome-blog.jp や awesome-blog.jp/hfm といったURLを提供する。そして希望者には blog.hifumi.info のような独自ドメインの接続を許可する。独自ドメインのサポートは有料コンテンツの場合も多いが、Tumblr や GitHub Pages のように無料提供されている例もある。

Google Chrome も HTTP 接続を non-secure と表現する[^2]など、HTTPSの流れが本格化して久しい。

通常、Webサーバで大量ドメインの証明書を取り扱おうとすると、設定ファイルの長大化やメモリの肥大化を招いてしまうなど非効率な面が目立つ。しかし、ngx_mrubyを用いた動的証明書読み込みなら、簡潔な設定と省メモリで実現することができる。

### 大量ドメインとSSL(TLS)証明書の課題と解決
#### TLS SNI拡張
#### nginxに大量ドメイン用の設定ファイルと証明書を読み込ませる

ngx_mrubyを用いた動的証明書読み込み
---

### OpenSSL 1.0.2で追加されたSSL_CTX_set_cert_cb関数

2015年1月にリリースされたOpenSSL 1.0.2に、しれっと重要な関数が追加されている。

> \*) Add certificate callback. If set this is called whenever a certificate is required by client or server. An application can decide which certificate chain to present based on arbitrary criteria: for example supported signature algorithms. Add very simple example to s_server.  This fixes many of the problems and restrictions of the existing client certificate callback: for example you can now clear an existing certificate and specify the whole chain. [Steve Henson]
> _https://www.openssl.org/news/cl102.txt_

この証明書コールバック関数が[SSL_CTX_set_cert_cb](https://www.openssl.org/docs/man1.0.2/ssl/SSL_CTX_set_cert_cb.html)

blockquote class="twitter-tweet" data-lang="ja"><p lang="en" dir="ltr">ngx_mruby supports dynamic certificate change each tls sessions / “Support ssl_handshake handler and dynamic certi…” <a href="https://t.co/PK7qGv5ctP">https://t.co/PK7qGv5ctP</a></p>&mdash; 松本 亮介 / まつもとりー (@matsumotory) <a href="https://twitter.com/matsumotory/status/685341115814289408">2016年1月8日</a></blockquote>

### アーキテクチャ
### 実装
#### ポイント
### テスト
### パフォーマンス

Webサーバでデータベースやキャッシュにアクセスするとなると、パフォーマンスの低下が気になってくると思う。

実際のところ、動的証明書読み込みによるレイテンシは無視できるほど小さくて、それよりもアプリケーションのレイテンシの方が非常に大きい。アプリケーションのパフォーマンスが悪いということではなく、両者のレイテンシを比べると、片方が無視できるほどに小さいというだけ。

### ngx_lua という競合

名古屋Ruby会議03
---

2/11(土)に開催された[名古屋Ruby会議03](http://regional.rubykaigi.org/nagoya03/)にて、"Dynamic certificate internals with ngx_mruby" というタイトルで発表した。昨年[GMO HosCon 2016](https://gmohoscon.connpass.com/event/41490/)の10分LT枠で話した[動的証明書読み込み ngx_mruby編](https://speakerdeck.com/hfm/gmo-hoscon-2016)の拡張版という位置づけで、動的証明書読み込みの必要性と実装について話してきた。

script async class="speakerdeck-embed" data-id="7164b59d4d25446aa6f4569440e2fc52" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

発表の舞台は大須演芸場という寄席。太鼓の出囃子で入場し、座布団に座って発表するという一風変わった舞台だった。意気込んで英語スライドを引っさげて行ったら、和洋混在の異様となってしまった。

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

[^1]: http://docs.yahoo.co.jp/info/aossl/
[^2]: https://security.googleblog.com/2016/09/moving-towards-more-secure-web.html

[^1]: 海外ではWebsite Builder等と呼ばれており、コーディング不要のウェブサイト構築ツールを提供する事業
