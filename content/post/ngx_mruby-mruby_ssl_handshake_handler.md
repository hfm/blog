---
date: 2016-09-18T06:10:02+09:00
title: ngx_mruby に mruby_ssl_handshake_handler() を実装した
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---
先日、ngx_mruby v1.18.4 がリリースされた[^1]。このリリースには私が実装した mruby_ssl_handshake_handler() が含まれている。このリリースから、ngx_mruby で mruby_ssl_handshake_handler ディレクティブが利用可能となる。

- [Implement mruby\_ssl\_handshake\_handler\(\) by hfm · Pull Request \#205 · matsumoto\-r/ngx\_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/205)

mruby_init_worker(\_code) や mruby_content_handler(\_code) といった他のハンドラでは既にあるディレクティブだったが、mruby_ssl_handshake_handler はまだ無かった。ちょうど業務で欲しくなったので、慣れないC言語と格闘しながら実装した。

mruby_ssl_handshake_handler ディレクティブの使い方
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

nginx ならびに ngx_mruby への新規ディレクティブの追加
---

今回は nginx の server コンテキストに ngx_mruby 関連の新しいディレクティブを追加した。どういうコードを書くかは [Pull request の Files changed](https://github.com/matsumoto-r/ngx_mruby/pull/205/files) を見てもらうのが一番かもしれないが、差分が少々ややこしくなってしまったので、ここで解説することにする。

### ディレクティブの定義

まず、 mruby_ssl_handshake_handler ディレクティブを定義するには、[ngx_command_t](https://www.nginx.com/resources/wiki/extending/api/configuration/#ngx-command-t) 型の配列を定義し、要素を追加する。ngx_mruby の場合は ngx_http_mruby_commands[] に追加すれば良い。

```c
static ngx_command_t ngx_http_mruby_commands[] = {

#if (NGX_HTTP_SSL)

    /* server config */
    {ngx_string("mruby_ssl_handshake_handler"), NGX_HTTP_SRV_CONF | NGX_CONF_TAKE12, ngx_http_mruby_ssl_handshake_phase,
     NGX_HTTP_SRV_CONF_OFFSET, 0, NULL},

    ...

#endif /* NGX_HTTP_SSL */

    ...

    ngx_null_command};
```

{ngx_string ... NULL } は、 ngx_command_s 型の

- `ngx_string("mruby_ssl_handshake_handler")` ... ディレクティブ名を決める。 ngx_string [^4] というマクロにディレクティブ名を入れる。今回は mruby_ssl_handshake_handler という名前。
- `NGX_HTTP_SRV_CONF | NGX_CONF_TAKE12` ... ディレクティブの引数を決める。今回は
- `ngx_http_mruby_ssl_handshake_phase` ... ディレクティブに対応するコールバック関数を定義する。コールバック関数の戻り値は NGX_CONF_OK か NGX_CONF_ERROR のどちらか。
- `NGX_HTTP_SRV_CONF_OFFSET` ... ディレクティブの値を保存すべきロケーションを指定する...らしい。HTTP, MAIL, STREAM の各コンテキストを指定できるのだが、効果があまりわかっていない。
- `0` ... ディレクティブのデータを保存する構造体のオフセットらしい。上記とセットで使うものなんだろうか、これもよくわかっていない。
- `NULL` ... ポストプロセッサとなる関数を指定する。

ngx_command_t 型の配列の終端は ngx_null_command となるように求められている。これは
[src/core/ngx_conf_file.h#L86](https://github.com/nginx/nginx/blob/release-1.11.3/src/core/ngx_conf_file.h#L86) で { ngx_null_string, 0, NULL, 0, 0, NULL } と定義されているだけだ。

ngx_command_t は typedef で宣言された ngx_command_s 構造体である。「[NginxでのModuleの作り方](http://yone098.hatenablog.com/entry/20090930/1254275423)」や「[ngx\_mrubyから学ぶnginxモジュールの作り方](http://blog.matsumoto-r.jp/?p=2841)」に詳しい解説がある。

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

つまり、 mruby_ssl_handshake_handler は server コンテキスト (NGX_HTTP_SRV_CONF) で有効となり、1つまたは2つの引数を必要とする (NGX_CONF_TAKE12)。また、このディレクティブが検出されたら ngx_http_mruby_ssl_handshake_phase() がコールバック関数として呼ばれる。(NGX_HTTP_SRV_CONF_OFFSET, 0)。ポストプロセッサは NULL で特に無い。

```c
  code = ngx_http_mruby_mrb_code_from_string(cf->pool, &value[1]);
  code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);
```

```c
static char *ngx_http_mruby_ssl_handshake_phase(ngx_conf_t *cf, ngx_command_t *cmd, void *conf)
{
  ngx_http_mruby_srv_conf_t *mscf = ngx_http_conf_get_module_srv_conf(cf, ngx_http_mruby_module);
  ngx_http_mruby_main_conf_t *mmcf = ngx_http_conf_get_module_main_conf(cf, ngx_http_mruby_module);
  ngx_str_t *value;
  ngx_mrb_code_t *code;
  ngx_int_t rc;

  if (mscf->ssl_handshake_code != NGX_CONF_UNSET_PTR) {
    return "is duplicated";
  }

  /* share mrb_state of preinit */
  mscf->state = mmcf->state;

  value = cf->args->elts;

  code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);
  if (code == NGX_CONF_UNSET_PTR) {
    ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, MODULE_NAME " : mruby_ssl_handshake_phase mrb_file(%s) open failed",
                       value[1].data);
    return NGX_CONF_ERROR;
  }
  if (cf->args->nelts == 3) {
    if (ngx_strcmp(value[2].data, "cache") == 0) {
      code->cache = ON;
    } else {
      ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, "invalid parameter \"%V\", vaild parameter is only \"cache\"",
                         &value[2]);
      return NGX_CONF_ERROR;
    }
  }
  mscf->ssl_handshake_code = code;
  rc = ngx_http_mruby_shared_state_compile(cf, mscf->state, code);
  if (rc != NGX_OK) {
    ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, MODULE_NAME " : mruby_ssl_handshake_phase mrb_file(%s) open failed",
                       value[1].data);
    return NGX_CONF_ERROR;
  }

  return NGX_CONF_OK;
}
```

[^1]: https://github.com/matsumoto-r/ngx_mruby/releases/tag/v1.18.4
[^2]: [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について - 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)
[^3]: http://www.nginxguts.com/2011/09/configuration-directives/
[^4]: https://github.com/nginx/nginx/blob/release-1.11.4/src/core/ngx_string.h#L40
