---
date: 2016-08-19T17:19:39+09:00
title: mruby_ssl_handshake_handler
cover: /images/2016/08/19/mruby_logo_red.png
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---


mruby_ssl_handshake_handler ディレクティブを定義には、ngx_command_t 型の ngx_http_mruby_commands に要素を追加する。

```c
static ngx_command_t ngx_http_mruby_commands[] = {

#if (NGX_HTTP_SSL)

    /* server config */
    {ngx_string("mruby_ssl_handshake_handler"), NGX_HTTP_SRV_CONF | NGX_CONF_TAKE12,
     ngx_http_mruby_ssl_handshake_phase, NGX_HTTP_SRV_CONF_OFFSET, 0, NULL},

    {ngx_string("mruby_ssl_handshake_handler_code"), NGX_HTTP_SRV_CONF | NGX_CONF_TAKE1,
     ngx_http_mruby_ssl_handshake_inline, NGX_HTTP_SRV_CONF_OFFSET, 0, NULL},

#endif /* NGX_HTTP_SSL */

    ...

    ngx_null_command};
```

ngx_command_t は typedef で宣言された ngx_command_s 構造体である。

```c
// https://github.com/nginx/nginx/blob/release-1.11.3/src/core/ngx_core.h#L22
typedef struct ngx_command_s     ngx_command_t;
```

[NginxでのModuleの作り方 - よねのはてな](http://yone098.hatenablog.com/entry/20090930/1254275423) の「押さえておきたい構造体1」に詳しい解説がある。

```c
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

つまり、 mruby\_ssl\_handshake\_handler は server コンテキスト (NGX\_HTTP\_SRV\_CONF) で有効となり、1つまたは2つの引数を必要とする (NGX\_CONF\_TAKE12)。また、このディレクティブが検出されたら ngx\_http\_mruby\_ssl\_handshake\_phase() がコールバック関数として呼ばれる。ポストプロセッサは特に無い (NULL)。
