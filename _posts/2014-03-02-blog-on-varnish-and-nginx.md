---
layout: post
title: varnish + nginxを導入した際の作業記録
tags:
- varnish
- nginx
---
『[Varnishによる高負荷動的Webサイトの構築［Apache/Nginx対応］](http://www.amazon.co.jp/exec/obidos/ASIN/B00I53Q85A/hifumiass-22/ref=nosim/)』という本を買って、nginxで動かしているこのブログにもVarnishを導入してみた。

[![Varnishによる高負荷動的Webサイトの構築［Apache/Nginx対応］](http://ecx.images-amazon.com/images/I/51lWlSpLltL._SL160_.jpg) Varnishによる高負荷動的Webサイトの構築［Apache/Nginx対応］](http://www.amazon.co.jp/exec/obidos/ASIN/B00I53Q85A/hifumiass-22/ref=nosim/)

### イメージ

```
                + server- - - - - - - - - - - - - - +
                '                                   '
+--------+      ' +------------+     +------------+ '
| client | <--> ' | varnish:80 | --- | nginx:8080 | '
+--------+      ' +------------+     +------------+ '
                '                                   '
                + - - - - - - - - - - - - - - - - - +
```

## install

CentOS 6.5で作業。

```console
# yum install nginx varnish
# /usr/sbin/varnishd -V
varnishd (varnish-2.1.5 SVN )
Copyright (c) 2006-2009 Linpro AS / Verdens Gang AS
```

## setup

varnishのdefault.vclを修正。

 * `/etc/varnish/default.vcl`
   * バックエンドを次のように指定する
   * Varnishがリスンするポートに接続がくると、`<.host>:<.port>`からコンテンツを取ってくる
   * Varnishのリスンポートは後述する

```c
backend default {
  .host = "127.0.0.1";
  .port = "8080";
}
```

[Performance – Varnish](https://www.varnish-cache.org/trac/wiki/Performance)のページを見ながら以下のように設定。

 * `/etc/sysconfig/varnish`
   * `/etc/init.d/varnish start`するときに読み込まれる設定ファイルの1つ
   * Varnishのリスンポートを80番に指定する
   * `VARNISH_STORAGE`をfileからmallocに切り替えて仮想メモリを使う
   * 合わせてサーバが1GBメモリなので、`VARSISH_STORAGE_SIZE`を大体80%ぐらいに設定する

```ini
VARNISH_LISTEN_PORT=80
VARNISH_MIN_THREADS=200
VARNISH_MAX_THREADS=4000
VARNISH_STORAGE_SIZE=820M
VARNISH_STORAGE="malloc,${VARNISH_STORAGE_SIZE}"
```

 * `/etc/nginx/conf.d/blog.conf`
   * リスンポートを8080番にする
   * `/etc/varnish/default.vcl`の`.port`と同じ値を指定する

```nginx
server {
  listen 8080;
  server_name blog.hifumi.info;
  root /var/www/blog;
  index index.html;
}
```

あとはサービスを起動。

```console
# /sbin/service nginx start
Starting nginx:                                            [  OK  ]
# /sbin/service varnish start
Starting varnish HTTP accelerator:                         [  OK  ]
```

これだけで設定完了した。
muninで見る限り、Varnishは元気に動いてくれている様子。

![munin: VarnishのHit rates](/images/2014/03/02/munin-varnish@2x.png)

ただこのレートがいいのか悪いのかがまだよく分かっていない (むしろ平均20%は低い気がする) ので、ドキュメント見つつチューニングしていく予定。
