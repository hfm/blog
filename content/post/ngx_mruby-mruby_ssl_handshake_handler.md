---
date: 2016-09-18T06:10:02+09:00
title: ngx_mruby に mruby_ssl_handshake_handler を実装した
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---
少し前になるが、ngx_mruby v1.18.4 がリリースされた[^1]。このリリースには私が実装した mruby_ssl_handshake_handler ディレクティブが含まれている。

- [Implement mruby\_ssl\_handshake\_handler\(\) by hfm · Pull Request \#205 · matsumoto\-r/ngx\_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/205)

mruby_init_worker(\_code) や mruby_content_handler(\_code) といった他のハンドラでは既にあるディレクティブだったが、mruby_ssl_handshake_handler はまだ無かった。業務で欲しくなったので、慣れないC言語と格闘しながら実装した。

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

ここからは実装の話をしていく。今回は nginx の server コンテキストに ngx_mruby 関連の新しいディレクティブを追加した。[Pull request の Files changed](https://github.com/matsumoto-r/ngx_mruby/pull/205/files) にコードはあるのだが、差分がややこしくなってしまった。

### ディレクティブの定義

まず、 mruby_ssl_handshake_handler ディレクティブを定義するには、[ngx_command_t](https://www.nginx.com/resources/wiki/extending/api/configuration/#ngx-command-t) 型の配列を定義し、要素を追加する。ngx_mruby の場合は ngx_http_mruby_commands[] に追加すれば良い。

```c
// https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.4/src/http/ngx_http_mruby_module.c#L169
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

{ngx_string("mruby_ssl_handshake_handler"), ..., NULL} のひとまとまりには、6つの要素がある。

- `ngx_string("mruby_ssl_handshake_handler")` : ディレクティブの名前。
- `NGX_HTTP_SRV_CONF | NGX_CONF_TAKE12` : コンテキストやその引数。今回は server コンテキストの中で、引数は1つまたは2つとした。1つ目はファイル名、2つ目は cache の判定に用いる。
- `ngx_http_mruby_ssl_handshake_phase` : ディレクティブから呼ばれるコールバック関数。
- `NGX_HTTP_SRV_CONF_OFFSET, 0` : データを保存する場所とオフセット。
- `NULL` : ポストプロセッサを指定するのだが、とくに無い場合は NULL。

なお、ngx_command_t は typedef で宣言された ngx_command_s 構造体である。これについて、「[NginxでのModuleの作り方](http://yone098.hatenablog.com/entry/20090930/1254275423)」や「[ngx\_mrubyから学ぶnginxモジュールの作り方](http://blog.matsumoto-r.jp/?p=2841)」に詳しい解説がある。

### ngx_http_mruby_ssl_handshake_phase() 関数

mruby_ssl_handshake_handler ディレクティブが検出されると、ngx_http_mruby_ssl_handshake_phase() 関数が呼ばれる。ハンドラとして指定されたファイルからコードを読み込み、場合によってはキャッシュする。ちなみに、コードの実行は [ngx_http_mruby_ssl_cert_handler()](https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.4/src/http/ngx_http_mruby_module.c#L2474-L2596) が担っている。

```c
// https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.4/src/http/ngx_http_mruby_module.c#L1041-L1082
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

エラー処理で行数が嵩んでいるものの、実際の処理はシンプルだ。

1. `value = cf->args->elts;` で引数を取得する
1. `code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);` でハンドラファイルからコードを読み込む
1. cache する場合は有効化
1. `mscf->ssl_handshake_code = code;` でコードを構造体に格納する
1. `rc = ngx_http_mruby_shared_state_compile(cf, mscf->state, code);` で

`value = cf->args->elts;` の cf->args は、ディレクティブの引数情報の入った配列 ([ngx_array_t](https://github.com/nginx/nginx/blob/release-1.11.3/src/core/ngx_array.h#L16-L22)) である。 elts は要素数 elements の略語だろう。value の各要素には ngx_str_t 型の値が入っている。


- value[0] : mruby_ssl_handshake_handler
- value[1] : /path/to/ssl_handshake_handler.rb
- value[2] : (あれば) cache

引数を value に格納した次は、ngx_http_mruby_mrb_code_from_file() を使って指定されたファイルからコードを読み込む。ちなみにインラインで書いたコードを読み込む場合は ngx_http_mruby_mrb_code_from_string() を使う。

```c
  code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);
  if (code == NGX_CONF_UNSET_PTR) {
    ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, MODULE_NAME " : mruby_ssl_handshake_phase mrb_file(%s) open failed",
                       value[1].data);
    return NGX_CONF_ERROR;
  }
```

cf->args->nelts は args の要素数である。ディレクティブに cache を指定した時（nelts が 3 の時）、code->cache のフラグを立て、キャッシュを有効にする。

```c
  if (cf->args->nelts == 3) {
    if (ngx_strcmp(value[2].data, "cache") == 0) {
      code->cache = ON;
    } else {
      ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, "invalid parameter \"%V\", vaild parameter is only \"cache\"",
                         &value[2]);
      return NGX_CONF_ERROR;
    }
  }
```

mscf->ssl_handshake_code には

```c
  mscf->ssl_handshake_code = code;
  rc = ngx_http_mruby_shared_state_compile(cf, mscf->state, code);
  if (rc != NGX_OK) {
    ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, MODULE_NAME " : mruby_ssl_handshake_phase mrb_file(%s) open failed",
                       value[1].data);
    return NGX_CONF_ERROR;
  }

  return NGX_CONF_OK;
```

[^1]: https://github.com/matsumoto-r/ngx_mruby/releases/tag/v1.18.4
[^2]: [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について - 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)
[^3]: http://www.nginxguts.com/2011/09/configuration-directives/
[^4]: https://github.com/nginx/nginx/blob/release-1.11.4/src/core/ngx_string.h#L40
