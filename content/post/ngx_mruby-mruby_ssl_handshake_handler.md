---
date: 2016-10-03T09:37:37+09:00
title: ngx_mruby に mruby_ssl_handshake_handler を実装した
tags:
- mruby
- nginx
- ngx_mruby
---
少し前になるが、[ngx_mruby v1.18.4 がリリースされた](https://github.com/matsumoto-r/ngx_mruby/releases/tag/v1.18.4)。このリリースには私が実装した mruby_ssl_handshake_handler ディレクティブが含まれている。

- [Implement mruby\_ssl\_handshake\_handler\(\) by hfm · Pull Request \#205 · matsumoto\-r/ngx\_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/205)

mruby_init_worker(\_code) や mruby_content_handler(\_code) といった他のハンドラでは既にあるディレクティブだったが、mruby_ssl_handshake_handler はまだ無かった。業務で欲しくなったので、慣れないC言語と格闘しながら実装した。

mruby_ssl_handshake_handler ディレクティブの使い方
---

mruby_ssl_handshake_handler ディレクティブは、Ruby スクリプトをインラインではなく外部ファイルから読み込んで実行する。第2引数に cache を指定すると、インライン同様にコードをキャッシュする。

例えば以下のような使い方が出来る。

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
```ruby
# /path/to/ssl_handshake_handler.rb
ssl = Nginx::SSL.new

redis = Redis.new*'redis-server', 6379
crt, key = redis.hmget ssl.servername, 'crt', 'key'

ssl.certificate_date = crt
ssl.certificate_key_date = key
```

この例は Redis サーバから対象の servername の証明書と秘密鍵を取り出し、nginx にセットしている。プロダクション用途で使うには、もう少しエラーハンドリングを厚くしたり、クラス化したり、テストを追加する必要があるだろう。そのようにコードが肥大化する場合には、インラインで書くよりもファイルに切り出した方が取り回しやすい。

nginx ならびに ngx_mruby への新規ディレクティブの追加
---

ここからは実装の話をしていく。今回は nginx の server コンテキストに ngx_mruby 関連の新しいディレクティブを追加した。[Pull request の Files changed](https://github.com/matsumoto-r/ngx_mruby/pull/205/files) にコードはあるのだが、差分がややこしくなってしまったので、ここで解説してみることにする。

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
- `NULL` : ポストプロセッサ。とくに無い場合は NULL。

なお、ngx_command_t は typedef で宣言された ngx_command_s 構造体である。これについて、「[NginxでのModuleの作り方](http://yone098.hatenablog.com/entry/20090930/1254275423)」や「[ngx\_mrubyから学ぶnginxモジュールの作り方](http://blog.matsumoto-r.jp/?p=2841)」に詳しい解説がある。

### ngx_http_mruby_ssl_handshake_phase() 関数

mruby_ssl_handshake_handler ディレクティブが検出されると、ngx_http_mruby_ssl_handshake_phase() 関数が呼ばれる。この関数は、指定されたファイルからコードを読み込み、場合によってはキャッシュする。ちなみに、読み込んだコードの実行は、この関数ではなく [ngx_http_mruby_ssl_cert_handler()](https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.4/src/http/ngx_http_mruby_module.c#L2474-L2596) が担っている。

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

エラー処理で行数が嵩んでいるものの、やっていることはシンプルだ（私の理解が間違っていなければ）。

1. `value = cf->args->elts;` で引数を取得する
1. `code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);` でファイルパスを取得
1. value[2] に cache という文字が含まれていればキャッシュを有効化
1. `mscf->ssl_handshake_code = code;` でファイル情報を server コンテキスト用の構造体に格納する
1. `rc = ngx_http_mruby_shared_state_compile(cf, mscf->state, code);` でファイルを読み込み、コードをパースし、実行コードを生成する（ここはちょっと理解が怪しい）

#### 引数を取得する

`value = cf->args->elts;` の cf->args は、ディレクティブの引数情報の入った配列 ([ngx_array_t](https://github.com/nginx/nginx/blob/release-1.11.3/src/core/ngx_array.h#L16-L22)) である。 elts は要素数 elements の略語だろう。value の各要素には ngx_str_t 型の値が入っていて、おそらく以下のようになっている。

- value[0] : mruby_ssl_handshake_handler
- value[1] : /path/to/ssl_handshake_handler.rb
- value[2] : (あれば) cache

#### ファイルパスを取得

引数を value に格納したら、ngx_http_mruby_mrb_code_from_file() でファイルパスを取得する。ちなみにインライン用に ngx_http_mruby_mrb_code_from_string() というのもある。

```c
  code = ngx_http_mruby_mrb_code_from_file(cf->pool, &value[1]);
  if (code == NGX_CONF_UNSET_PTR) {
    ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, MODULE_NAME " : mruby_ssl_handshake_phase mrb_file(%s) open failed",
                       value[1].data);
    return NGX_CONF_ERROR;
  }
```

#### キャッシュを有効化

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

#### ファイル情報を server コンテキスト用の構造体に格納する

`mscf->ssl_handshake_code = code;` でファイル情報を格納する。mscf は ngx_http_mruby_srv_conf_t 構造体のポインタで、SSLハンドシェイク時に実行するコードや servername や証明書、秘密鍵といったデータを格納する。ちなみに、ファイルの場合とインラインの場合とで保存するフィールドは分かれている。

```c
typedef struct {
  ngx_mrb_state_t *state;
  ngx_mrb_code_t *ssl_handshake_code;
  ngx_mrb_code_t *ssl_handshake_inline_code;
  ngx_str_t *servername;
  ngx_str_t cert_path;
  ngx_str_t cert_key_path;
  ngx_str_t cert_data;
  ngx_str_t cert_key_data;
#if (NGX_HTTP_SSL) && OPENSSL_VERSION_NUMBER >= 0x1000205fL
  ngx_connection_t *connection;
#endif
} ngx_http_mruby_srv_conf_t;
```

#### ファイルを読み込み、コードをパースし、実行コードを生成する

mscf にコードを入れたあと、ngx_http_mruby_shared_state_compile() で実行コードを生成する。mrb_parse_file() で解析し、得られた構文木を mrb_generate_code() につっこんで実行コードを生成しているらしい。

```c
  rc = ngx_http_mruby_shared_state_compile(cf, mscf->state, code);
  if (rc != NGX_OK) {
    ngx_conf_log_error(NGX_LOG_EMERG, cf, 0, MODULE_NAME " : mruby_ssl_handshake_phase mrb_file(%s) open failed",
                       value[1].data);
    return NGX_CONF_ERROR;
  }

  return NGX_CONF_OK;
```

この関数を読み解くうえで、以下のブログ記事を参考にした。

- [Big Sky :: mruby\(Lightweight Ruby\) をプログラムに組み込んでみる](http://mattn.kaoriya.net/software/lang/ruby/20120420121729.htm)
- [mruby/スクリプト解析を読む \- Code Reading Wiki](http://www.dzeta.jp/~junjis/code_reading/index.php?mruby%2F%A5%B9%A5%AF%A5%EA%A5%D7%A5%C8%B2%F2%C0%CF%A4%F2%C6%C9%A4%E0)
- [mruby/実行コード生成を読む \- Code Reading Wiki](http://www.dzeta.jp/~junjis/code_reading/index.php?mruby%2F%BC%C2%B9%D4%A5%B3%A1%BC%A5%C9%C0%B8%C0%AE%A4%F2%C6%C9%A4%E0)

ここまでの一連の手続きをつつがなく行えれば、NGX_CONF_OK が返ってくる。

おわりに
---

nginx の世界と mruby の世界を行き来し、各々の世界から得られる情報をうまく相互変換していけば、ngx_mruby のディレクティブをなんとか実装できるという感触を得られた。nginx と mruby の API を活用しているため、ソースコードはもちろんのこと、以下の API 一覧は大変参考になった。

参考
---

- https://www.nginx.com/resources/wiki/extending/api/
- https://www.nginx.com/resources/wiki/extending/api/configuration/
- http://mruby.org/docs/api/
- http://www.nginxguts.com/2011/09/configuration-directives/
