---
date: 2016-10-07T09:57:37+09:00
title: ngx_mruby に Nginx::SSL.errlogger を実装してログを出力できるようにした
tags:
- mruby
- nginx
- ngx_mruby
---
[ngx_mruby v1.18.5](https://github.com/matsumoto-r/ngx_mruby/releases/tag/v1.18.5) から Nginx::SSL.errlogger と Nginx::SSL.log メソッドが使えるようになった。この2つのメソッドは同じはたらきで、mruby_ssl_handshake_handler ディレクティブの中でエラーログを出力するために用いる。

- [Implement Nginx::SSL.errlogger (and Nginx::SSL.log) by hfm · Pull Request #215 · matsumoto-r/ngx_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/215)

使い方は Nginx.errlogger や Nginx::Stream.errlogger とまったく同じで、以下のように書くことができる。

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

        mruby_ssl_handshake_handler_inline '
          ssl = Nginx::SSL.new
          Nginx::SSL.errlogger, Nginx::LOG_NOTICE, "Servername is #{ssl.servername}"
        ';
    }
}
```

クラスメソッドの定義
---

[前回](/2016/10/03/ngx_mruby-mruby_ssl_handshake_handler/)同様、実装の話をしていく。まず、mruby API を使ってクラスメソッドを定義するためには mrb_define_class_method()[^1] を用いる。今回は errlogger と log を追加し、どちらのメソッドも ngx_mrb_ssl_errlogger() が呼ばれるようにした。

```c
mrb_define_class_method(mrb, class_ssl, "errlogger", ngx_mrb_ssl_errlogger, MRB_ARGS_ANY());
mrb_define_class_method(mrb, class_ssl, "log", ngx_mrb_ssl_errlogger, MRB_ARGS_ANY());
```

ちなみに mruby API には mrb_define_alias() や mrb_alias_method()[^2] もあるのだが、Nginx.errlogger などの実装に合わせて採用しなかった。

メソッドの実装
---

ngx_mrb_ssl_errlogger() は以下のような実装になっている。メソッドから引数を受け取り、引数情報を検査したあと、Nginx のエラーログに書き出す。

```c
// https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.5/src/http/ngx_http_mruby_ssl.c#L64-L99
static mrb_value ngx_mrb_ssl_errlogger(mrb_state *mrb, mrb_value self)
{
  mrb_value *argv;
  mrb_value msg;
  mrb_int argc;
  mrb_int log_level;
  ngx_http_mruby_srv_conf_t *mscf = mrb->ud;
  ngx_connection_t *c = mscf->connection;

  if (c == NULL) {
    mrb_raise(mrb, E_RUNTIME_ERROR, "can't use logger at this phase. only use at request phase");
  }

  mrb_get_args(mrb, "*", &argv, &argc);
  if (argc != 2) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: argument is not 2", MODULE_NAME, __func__);
    return self;
  }
  if (mrb_type(argv[0]) != MRB_TT_FIXNUM) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: argv[0] is not integer", MODULE_NAME, __func__);
    return self;
  }
  log_level = mrb_fixnum(argv[0]);
  if (log_level < 0) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: log level is not positive number", MODULE_NAME, __func__);
    return self;
  }
  if (mrb_type(argv[1]) != MRB_TT_STRING) {
    msg = mrb_funcall(mrb, argv[1], "to_s", 0, NULL);
  } else {
    msg = mrb_str_dup(mrb, argv[1]);
  }
  ngx_log_error((ngx_uint_t)log_level, c->log, 0, "%s", mrb_str_to_cstr(mrb, msg));

  return self;
}
```

はじめは mrb_get_args() で引数を受け取る。`Nginx::SSL.errlogger Nginx::LOG_*, "Message"` という形式になっているか確かめる必要があるので、まずは引数の数 argc が2つであることを確認している。

```c
  mrb_get_args(mrb, "*", &argv, &argc);
  if (argc != 2) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: argument is not 2", MODULE_NAME, __func__);
    return self;
  }
```

次に、第1引数を log_level に代入する。ログレベルには `Nginx::LOG_ERR` や `Nginx::LOG_INFO` などの定数が期待される。これらの定義は [ngx_http_mruby_core.c](https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.6/src/http/ngx_http_mruby_core.c#L432-L441) にあり、[ngx_log.h](https://github.com/nginx/nginx/blob/release-1.11.4/src/core/ngx_log.h#L16-L24) の NGX_LOG\_\* 定数が用いられている。

```c
  if (mrb_type(argv[0]) != MRB_TT_FIXNUM) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: argv[0] is not integer", MODULE_NAME, __func__);
    return self;
  }
  log_level = mrb_fixnum(argv[0]);
  if (log_level < 0) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: log level is not positive number", MODULE_NAME, __func__);
    return self;
  }
```

次は第2引数を msg に代入するのだが、もし第2引数の型が mruby の String (MRB_TT_STRING) と一致しなければ、`to_s` メソッドを呼び出して mruby の String に変換している。mrb_funcall()[^3] は C 言語から mruby で定義したメソッドを呼び出すための関数である。

```c
  if (mrb_type(argv[1]) != MRB_TT_STRING) {
    msg = mrb_funcall(mrb, argv[1], "to_s", 0, NULL);
  } else {
    msg = mrb_str_dup(mrb, argv[1]);
  }
```

引数の検査がひと通り済んだ後、ようやくログに書き出す。

ここまでに何度か登場している ngx_log_error() は Logging API[^4] という奴で、その名の通り Nginx のログファイルに書き出すための関数である。コネクションに関する情報を持つ構造体 ngx_connection_t[^5] の中に、ログのハンドラのポインタ ngx_log_t \*log がいるので、出力先はこのポインタに向ければ良い。

また、変数 msg は mrb_value 型なので、mruby の String を C 言語の文字列に直す必要がある。このような目的に適う API は3種類あり、今回は mrb_str_to_cstr() を用いた。各種 API の違いについては、以下の記事を参考にされたい。

- [[O]mruby の String から C 言語の文字列を取り出す正しい方法 - Qiita](http://qiita.com/tsahara@github/items/b2a442af95ac893e10a1)

```c
  ngx_log_error((ngx_uint_t)log_level, c->log, 0, "%s", mrb_str_to_cstr(mrb, msg));
```

ここまで読んだら分かる通り、 Nginx::SSL.errlogger および Nginx::SSL.log の実装の正体は、ほとんど引数のチェックに過ぎない。mruby の世界から取り出した情報を Nginx が読み取れるようにひたすら確認し、変換していく素朴な作業が続く。

[^1]: http://mruby.org/docs/api/headers/mruby.h.html#mrb_define_class_method-function
[^2]: https://github.com/mruby/mruby/blob/1.2.0/src/class.c#L1662-L1680
[^3]: http://mruby.org/docs/api/headers/mruby.h.html#mrb_funcall-function
[^4]: https://www.nginx.com/resources/wiki/extending/api/logging/
[^5]: https://www.nginx.com/resources/wiki/extending/api/main/#ngx-connection-t
