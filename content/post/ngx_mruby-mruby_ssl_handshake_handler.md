---
date: 2016-09-07T00:16:18+09:00
title: ngx_mruby に mruby_ssl_handshake_handler() を実装した
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---
ngx_mruby v1.18.4 がリリースされた[^1]。このリリースには私が実装した mruby_ssl_handshake_handler() が含まれている。このリリースから、ngx_mruby で mruby_ssl_handshake_handler ディレクティブが利用可能となる。

- [Implement mruby\_ssl\_handshake\_handler\(\) by hfm · Pull Request \#205 · matsumoto\-r/ngx\_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/205)

mruby_ssl_handshake_handler ディレクティブ
---

mruby_ssl_handshake_handler ディレクティブは、Ruby スクリプトをインラインではなく外部ファイルから読み込んで実行する。第2引数に cache を指定すると、インライン同様にコードをキャッシュする。

```nginx
events {
    worker_connections  1024;
}

http {
    server {
        listen      443 ssl http2;
        server_name _;

        ssl_protocols       TLSv1.2;
        ssl_ciphers         AESGCM:HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers on;
        ssl_dhparam         /etc/nginx/dhparam.pem;
        ssl_certificate     /etc/nginx/certs/dummy.crt;
        ssl_certificate_key /etc/nginx/certs/dummy.key;

        mruby_ssl_handshake_handler /path/to/ssl_handshake_handler.rb cache;
    }
}
```

mruby_init_worker(\_code) や mruby_content_handler(\_code) といった他のハンドラでは既にあるディレクティブだったが、mruby_ssl_handshake_handler はまだ無かったので足してみた、という感じだ。

動的証明書読み込みでは、SNI の servername に合致した証明書ファイルを読み込むが、ドメイン数が多い場合、各ホストに大量の証明書ファイルを設置するのは現実的ではない。KVS や RDBMS に証明書ファイルを保存し、必要に応じて取り出したりする必要があるだろう。

<script async class="speakerdeck-embed" data-slide="18" data-id="61747efd172644c681f1787b75010f76" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>


例えば、弊社インフラエンジニア [@takumakume](https://twitter.com/takumakume) が取り組んでいる「[ngx\_mrubyで転送先を外部参照するリバースプロキシを構築する](http://blog.konbu.link/2016/05/10/ngx_mruby/)」では、 nginx (ngx_mruby) から KVS や RDBMS へのアクセスを想定しており、インラインで書くには多少複雑なコードになる。

ngx_mruby 

mruby_ssl_handshake_handler ディレクティブを定義には、ngx_command_t 型の ngx_http_mruby_commands に要素を追加する。

```c
static ngx_command_t ngx_http_mruby_commands[] = {

#if (NGX_HTTP_SSL)

    /* server config */
    {ngx_string("mruby_ssl_handshake_handler"), NGX_HTTP_SRV_CONF | NGX_CONF_TAKE12,
     ngx_http_mruby_ssl_handshake_phase, NGX_HTTP_SRV_CONF_OFFSET, 0, NULL},

    ...

#endif /* NGX_HTTP_SSL */

    ...

    ngx_null_command};
```

ngx_command_t は typedef で宣言された ngx_command_s 構造体である。「[NginxでのModuleの作り方 - よねのはてな](http://yone098.hatenablog.com/entry/20090930/1254275423)」や「[ngx\_mrubyから学ぶnginxモジュールの作り方](http://blog.matsumoto-r.jp/?p=2841)」に詳しい解説がある。

```c
// https://github.com/nginx/nginx/blob/release-1.11.3/src/core/ngx_core.h#L22
typedef struct ngx_command_s     ngx_command_t;

// https://github.com/nginx/nginx/blob/release-1.11.3/src/core/ngx_conf_file.h#L77-L84
struct ngx_command_s {
    ngx_str_t             name;
    ngx_uint_t            type;
    char               *(*set)(ngx_conf_t *cf, ngx_command_t *cmd, void *conf);
    ngx_uint_t            conf;
    ngx_uint_t            offset;
    void                 *post;
};
```

つまり、 mruby\_ssl\_handshake\_handler は server コンテキスト (NGX\_HTTP\_SRV\_CONF) で有効となり、1つまたは2つの引数を必要とする (NGX\_CONF\_TAKE12)。また、このディレクティブが検出されたら ngx\_http\_mruby\_ssl\_handshake\_phase() がコールバック関数として呼ばれる。(NGX\_HTTP\_SRV\_CONF\_OFFSET, 0)。ポストプロセッサは NULL で特に無い。

```c
  code = ngx_http_mruby_mrb_code_from_string(cf->pool, &value[1]);
  code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);
```

[^1]: https://github.com/matsumoto-r/ngx_mruby/releases/tag/v1.18.4
[^2]: [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について - 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)
[^3]: http://www.nginxguts.com/2011/09/configuration-directives/
