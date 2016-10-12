---
date: 2016-11-07T09:00:00+09:00
title: ngx_mruby の Nginx::Var クラスの実装を理解する〜変数取得編
tags:
- mruby
- nginx
- ngx_mruby
---
[ngx_mruby](https://github.com/matsumoto-r/ngx_mruby) には nginx の変数を操作するための [Nginx::Var クラス](https://github.com/matsumoto-r/ngx_mruby/wiki/Class-and-Method#nginxvar-class)があります。対象となる変数は [refs: nginx core variables](https://github.com/matsumoto-r/ngx_mruby/wiki/Class-and-Method#refs-nginx-core-variables) の他、[Alphabetical index of variables](http://nginx.org/en/docs/varindex.html) などをご参照ください。

例えば以下のようなコードで、Nginx の [$date_local](http://nginx.org/en/docs/http/ngx_http_ssi_module.html#var_date_local) を参照することが出来ます。

```ruby
v = Nginx::Var.new
Nginx.rputs v.date_local
#=> Friday, 14-Oct-2016 02:20:00 JST

# ngx_http_geoip_module を使用している場合
Nginx.rputs v.geoip_country_name
#=> Japan
```

Nginx::Var クラスはこれら数多くの nginx 変数をどうやって取得しているのでしょうか。新たに変数が追加された場合はどのように対応しているのでしょうか。ngx_mruby の Nginx::Var クラスが実装されているファイル [ngx_http_mruby_var.c](https://github.com/matsumoto-r/ngx_mruby/blob/master/src/http/ngx_http_mruby_var.c) を見てみようと思います。バージョンは v1.18.7 です。

Nginx::Var クラスの宣言とメソッド一覧
---

Nginx::Var クラスの宣言は ngx_mrb_var_class_init() で行われています。このクラスには method_missing, exist?, set の3つしかメソッドがありません。

```c
// https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.7/src/http/ngx_http_mruby_var.c#L259-L267
void ngx_mrb_var_class_init(mrb_state *mrb, struct RClass *class)
{
  struct RClass *class_var;

  class_var = mrb_define_class_under(mrb, class, "Var", mrb->object_class);
  mrb_define_method(mrb, class_var, "method_missing", ngx_mrb_var_method_missing, MRB_ARGS_ANY());
  mrb_define_method(mrb, class_var, "exist?", ngx_mrb_var_exist, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, class_var, "set", ngx_mrb_var_set_func, MRB_ARGS_REQ(2));
}
```

nginx 変数の呼び出しは全て Nginx::Var#method_missing 経由で行われます。nginx 側の変数の変化に対し、ngx_mruby 側はコードを変更することなく対応できるように設計されています。

Nginx::Var#method_missing の実装
---

Nginx::Var#method_missing の実装は ngx_mrb_var_method_missing() です。シンボル（メソッド名）とメソッドに渡された引数を受け取り、ゲッタかセッタかを判定し、それ専用の関数を呼び出します。

```c
// https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.7/src/http/ngx_http_mruby_var.c#L117-L143
static mrb_value ngx_mrb_var_method_missing(mrb_state *mrb, mrb_value self)
{
  mrb_value name, *a;
  int alen, c_len;
  mrb_value s_name;
  char *c_name;
  ngx_http_request_t *r;

  r = ngx_mrb_get_request();

  // get var symble from method_missing(sym, *args)
  mrb_get_args(mrb, "n*", &name, &a, &alen);

  // name is a symble obj
  // first init name with mrb_symbol
  // second get mrb_string with mrb_sym2str
  s_name = mrb_sym2str(mrb, mrb_symbol(name));
  c_len = RSTRING_LEN(s_name);
  c_name = ngx_palloc(r->pool, c_len);
  ngx_memcpy(c_name, RSTRING_PTR(s_name), c_len);

  if (c_name[c_len - 1] == '=') {
    return ngx_mrb_var_set(mrb, self, strtok(c_name, "="), a[0], r);
  } else {
    return ngx_mrb_var_get(mrb, self, c_name, c_len, r);
  }
}
```

まず、mrb_get_args() で Nginx::Var#method_missing に渡された引数を取得します。 mrb_get_args() の第2引数は String や Array, ブロックといったフォーマットの指定（[mrb_args_format](http://mruby.org/docs/api/headers/mruby.h.html#mrb_args_format-typedef) で定義される）です。`name` にはメソッド名が Symbol で渡され、 `a` と `alen` にはメソッドに渡された引数とその個数が渡されます。

```c
  // get var symble from method_missing(sym, *args)
  mrb_get_args(mrb, "n*", &name, &a, &alen);
```

続いて、取得した引数情報からメモリ領域を確保します。`s_name` にはメソッド名が String に変換されて渡されます。`c_len` にはメソッド名の長さが渡されます。`c_name` には nginx のメモリプールから `c_len` の長さ分だけ確保されたメモリ領域が渡されます。なお、nginx のメモリプールに関しては[nginxソースコードリーディング その4〜コアAPI\(メモリプール\)〜 \- Qiita](http://qiita.com/cubicdaiya/items/09f495da6ac9d889d6f8)が参考になります。

最後に、 `ngx_memcpy()` で `c_name` へメソッド名をコピーします。ここまでの処理で、Ruby の文字列を nginx 側に渡すことができました。

```c
  // name is a symble obj
  // first init name with mrb_symbol
  // second get mrb_string with mrb_sym2str
  s_name = mrb_sym2str(mrb, mrb_symbol(name));
  c_len = RSTRING_LEN(s_name);
  c_name = ngx_palloc(r->pool, c_len);
  ngx_memcpy(c_name, RSTRING_PTR(s_name), c_len);
```

次はいよいよ nginx から変数を取得します。以下の条件分岐では、メソッド名の最後に `=` が付いているかどうかで、セッタかゲッタを判断しています。セッタの場合は ngx_mrb_var_set() が呼ばれ、ゲッタの場合は ngx_mrb_var_get() が呼ばれます。

```c
  if (c_name[c_len - 1] == '=') {
    return ngx_mrb_var_set(mrb, self, strtok(c_name, "="), a[0], r);
  } else {
    return ngx_mrb_var_get(mrb, self, c_name, c_len, r);
  }
```

nginx 変数を取得する関数 ngx_mrb_var_get()
---

ngx_mrb_var_get() の実装は以下の通りです。ngx_http_get_variable() を介して nginx の変数を取得し、Ruby の String に変換して返しています。

```c
static mrb_value ngx_mrb_var_get(mrb_state *mrb, mrb_value self, const char *c_name, size_t c_len,
                                 ngx_http_request_t *r)
{
  ngx_http_variable_value_t *var;
  ngx_str_t ngx_name;

  size_t len;
  ngx_uint_t key;

  ngx_name.len = c_len;
  ngx_name.data = (u_char *)c_name;
  len = ngx_name.len;

  key = ngx_hash_strlow(ngx_name.data, ngx_name.data, len);
  var = ngx_http_get_variable(r, &ngx_name, key);
  if (var == NULL) {
    ngx_log_error(NGX_LOG_ERR, r->connection->log, 0, "%s ERROR %s:%d: %s is NULL", MODULE_NAME, __func__, __LINE__,
                  c_name);
    return mrb_nil_value();
  }

  // return variable value wraped with mruby string
  if (!var->not_found) {
    return mrb_str_new(mrb, (char *)var->data, var->len);
  } else {
    return mrb_nil_value();
  }
}
```

ngx_str_t 型の ngx_name は、文字列へのポインタとその長さの情報を持つ構造体です。この型は nginx の世界における文字列型といった扱いのようです。

```c
// https://github.com/nginx/nginx/blob/release-1.11.5/src/core/ngx_string.h#L16-L19
typedef struct {
    size_t      len;
    u_char     *data;
} ngx_str_t;
```

ngx_hash_strlow() は与えられた文字列を小文字に変換した上で、文字列をハッシュ化して返します。小文字への変換には ngx_tolower() が、文字列のハッシュ化には ngx_hash() が使われています。

```c
  key = ngx_hash_strlow(ngx_name.data, ngx_name.data, len);
```

いよいよここで nginx の変数を取得します。[ngx_http_get_variable()](https://www.nginx.com/resources/wiki/extending/api/variables/#ngx-http-get-variable) が Nginx::Var の肝といってもいいかもしれません。先程ハッシュ化した `key` を用いて、nginx 変数を検索、取得します。

ちなみに ngx_http_get_variable() は ngx_lua でも使われています。詳しくは [ngx_http_lua_variable.c#L39-L129](https://github.com/openresty/lua-nginx-module/blob/v0.10.6/src/ngx_http_lua_variable.c#L39-L129) をご参照ください。

```c
  var = ngx_http_get_variable(r, &ngx_name, key);
  if (var == NULL) {
    ngx_log_error(NGX_LOG_ERR, r->connection->log, 0, "%s ERROR %s:%d: %s is NULL", MODULE_NAME, __func__, __LINE__,
                  c_name);
    return mrb_nil_value();
  }
```

変数を取得できた場合は String にして返します。変数が見つからなかった場合は nil を返します。

```c
  // return variable value wraped with mruby string
  if (!var->not_found) {
    return mrb_str_new(mrb, (char *)var->data, var->len);
  } else {
    return mrb_nil_value();
  }
```

おわりに
---

Nginx::Var#method_missing と ngx_http_get_variable() が nginx 変数を操作するための重要なパーツになっていることが分かりました。nginx 変数の数だけメソッドを定義せずとも、method_missing が柔軟に対応してくれています。

月並みな感想ですが、ngx_mruby 側の変更を最小限に抑える設計はステキな method_missing の活用事例だなあと思いました。

参考
---

- [ngx_mrubyインストール後入門 - ngx_mrubyによるnginx変数の扱い - Qiita](http://qiita.com/matsumotory/items/43f2918c5ef5efd2d4d8)
