---
date: 2016-10-03T09:37:37+09:00
title: ngx_mruby に Nginx::SSL.errlogger を実装してログを出力できるようにした
draft: true
tags:
- mruby
- nginx
- ngx_mruby
---
[ngx_mruby v1.18.5](https://github.com/matsumoto-r/ngx_mruby/releases/tag/v1.18.5)から Nginx::SSL.errlogger と Nginx::SSL.log メソッドが使えるようになった。これらは mruby_ssl_handshake_handler ディレクティブで error.log にログ出力するためのメソッドだ。

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

まず、mruby API を使ってクラスメソッドを定義するためには mrb_define_class_method()[^1] を用いる。今回は errlogger と log を追加し、どちらのメソッドも ngx_mrb_ssl_errlogger() が呼ばれるようにした。

```c
mrb_define_class_method(mrb, class_ssl, "errlogger", ngx_mrb_ssl_errlogger, MRB_ARGS_ANY());
mrb_define_class_method(mrb, class_ssl, "log", ngx_mrb_ssl_errlogger, MRB_ARGS_ANY());
```

メソッドの実装
---

ngx_mrb_ssl_errlogger() は以下のようなコードになっている。メソッドから引数を受け取り、Nginxの error.log に書き出すだけの素朴なコードだ。

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

```c
  mrb_get_args(mrb, "*", &argv, &argc);
  if (argc != 2) {
    ngx_log_error(NGX_LOG_ERR, c->log, 0, "%s ERROR %s: argument is not 2", MODULE_NAME, __func__);
    return self;
  }
```

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

```c
  if (mrb_type(argv[1]) != MRB_TT_STRING) {
    msg = mrb_funcall(mrb, argv[1], "to_s", 0, NULL);
  } else {
    msg = mrb_str_dup(mrb, argv[1]);
  }
```

- [[O]mruby の String から C 言語の文字列を取り出す正しい方法 - Qiita](http://qiita.com/tsahara@github/items/b2a442af95ac893e10a1)

```c
  ngx_log_error((ngx_uint_t)log_level, c->log, 0, "%s", mrb_str_to_cstr(mrb, msg));
```

[^1]: http://mruby.org/docs/api/headers/mruby.h.html#mrb_define_class_method-function
