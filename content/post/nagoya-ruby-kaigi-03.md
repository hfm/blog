---
date: 2017-02-13T15:51:32+09:00
title: '動的証明書読み込みの必要性とngx_mrubyによる実践 #nagoyark03'
cover: /images/2017/02/13/nagoyark03.jpg
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---
ホスティングサービスやホームページ作成サービス（海外ではWebsite Builder等と呼ばれている）やブログサービスといった、コンテンツプロバイダの中でもユーザがアップロードするコンテンツを提供する類の事業では、サブドメインや

通常、Webサーバで大量ドメインの証明書を取り扱おうとすると、設定ファイルの長大化やメモリの肥大化を招いてしまうなど非効率な面が目立ちます。しかし、ngx_mrubyを用いた動的証明書読み込みなら、簡潔な設定と省メモリで実現することができます。

ngx_mrubyを使えば、Rubyを用いてプログラマブルにnginxを制御することができます。私はngx_mrubyのメンテナを務めており、実際に複数のWebサービスで運用しています。今回の発表では、ngx_mrubyの活用事例として動的証明書読み込みについてお話させていただこうと思っています。

2/11(土)に開催された[名古屋Ruby会議03](http://regional.rubykaigi.org/nagoya03/)にて、"Dynamic certificate internals with ngx_mruby" というタイトルで発表をしてきました。この発表は昨年[GMO HosCon 2016](https://gmohoscon.connpass.com/event/41490/)の10分LT枠で発表した[動的証明書読み込み ngx_mruby編](https://speakerdeck.com/hfm/gmo-hoscon-2016)の拡張版という位置づけです。

script async class="speakerdeck-embed" data-id="7164b59d4d25446aa6f4569440e2fc52" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

また、GMOペパボから [@udzura](https://github.com/udzura) さんも[haconiwa](https://github.com/haconiwa/haconiwa)について、「未来のサーバ基盤へのHaconiwa/mrubyの関わり」というタイトルで発表しています。

- [名古屋Ruby会議03で登壇した #nagoyark03 - ローファイ日記](http://udzura.hatenablog.jp/entry/2017/02/13/134100)

以降では、発表スライドの補足として、動的証明書読み込みの必要性やその効果について解説したいと思います。

動的証明書読み込みの必要性
---

### 大量ドメインとSSL(TLS)証明書の課題と解決
#### TLS SNI拡張
#### nginxに大量ドメイン用の設定ファイルと証明書を読み込ませる

ngx_mrubyを用いた動的証明書読み込み
---

### OpenSSL 1.0.2で追加されたSSL_CTX_set_cert_cb関数
### アーキテクチャ
### 実装
#### ポイント
### テスト
### パフォーマンス

Webサーバでデータベースやキャッシュにアクセスするとなると、パフォーマンスの低下が気になってくると思う。

実際のところ、動的証明書読み込みによるレイテンシは無視できるほど小さくて、それよりもアプリケーションのレイテンシの方が非常に大きい。アプリケーションのパフォーマンスが悪いということではなく、両者のレイテンシを比べると、片方が無視できるほどに小さいというだけ。

おわりに
---

blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">英字の発表で、和と洋が入り乱れてる感しゅごい。<a href="https://twitter.com/hashtag/nagoyark03?src=hash">#nagoyark03</a> <a href="https://t.co/qJTDRWDfQ4">pic.twitter.com/qJTDRWDfQ4</a></p>&mdash; だびっつ (@dabits) <a href="https://twitter.com/dabits/status/830289736056991744">2017年2月11日</a></blockquote>
script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

参考
---

- https://github.com/mruby/mruby
- [200万 Webサイトを支える ロリポップ！と mruby](https://speakerdeck.com/harasou/200mo-websaitowozhi-eru-roripotupu-to-mruby)
- https://github.com/haconiwa/haconiwa
- [ngx_mruby の Nginx::Var クラスの実装を理解する〜変数取得編](/2016/11/07/ngx_mruby-nginx-var-using-method-missing/)
- How to build ngx_mruby:
  - https://github.com/matsumotory/ngx_mruby/wiki/Install
  - https://github.com/hsbt/ngx_mruby-package-builder
  - https://hub.docker.com/r/hfmgarden/ngx_mruby
  - https://github.com/giraffi/docker-nginx-mruby-base
- [100行あったmod_rewirteを ngx_mrubyで書き換えた話](https://speakerdeck.com/buty4649/100xing-atutamod-rewirtewo-ngx-mrubydeshu-kihuan-etahua)
- https://goope.jp
- https://gist.github.com/hfm/4a045a429f9303c90eac7c348d1a424a
- https://www.openssl.org/docs/man1.0.2/ssl/SSL_CTX_set_cert_cb.html
- https://twitter.com/matsumotory/status/685341115814289408
- [ngx_mruby に mruby_ssl_handshake_handler を実装した](http://blog.hifumi.info/2016/10/03/ngx_mruby-mruby_ssl_handshake_handler/)
- [mruby のテスト用に MySQL 環境を自動で構築する mruby-test-mysqld を書いた](http://blog.hifumi.info/2016/09/06/mruby-test-mysqld/)
- [How to test code with mruby](http://www.slideshare.net/hsbt/20150525-testing-casualtalks)
