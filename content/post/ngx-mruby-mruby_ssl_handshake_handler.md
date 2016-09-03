---
date: 2016-09-03T04:32:43+09:00
title: ngx_mruby に mruby_ssl_handshake_handler() を実装した
cover: /images/2016/08/19/mruby_logo_red.png
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---
ngx_mruby には動的に
ngx_mruby で大量ドメインの証明書を動的に処理する1には OpenSSL 1.0.2e 以上が必要となる2。しかし、CentOS, Ubuntu, Debian の中では Xenial しか OpenSSL 1.0.2 をサポートしていない3。それ以外の OS では、OpenSSLを自前ビルドするか静的リンクするのが良さそうだ。


- [Implement mruby\_ssl\_handshake\_handler\(\) by hfm · Pull Request \#205 · matsumoto\-r/ngx\_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/205)

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

[^1]: [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について - 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)
