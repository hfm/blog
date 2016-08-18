---
date: 2016-08-17T20:17:46+09:00
title: mruby-redis に送った HMSET, HMGET のパッチ
draft: true
cover: /images/2016/08/18/mruby_logo_red.png
tags:
- mruby
- redis
---
[mruby-redis](https://github.com/matsumoto-r/mruby-redis) で Redis の [HMGET](http://redis.io/commands/hmget) と [HMSET](http://redis.io/commands/hmset) を使いたかったのでパッチを送った。

- [Implement Redis\#HMGET and Redis\#HMSET by hfm · Pull Request \#58 · matsumoto\-r/mruby\-redis](https://github.com/matsumoto-r/mruby-redis/pull/58)

mruby も [hiredis](https://github.com/redis/hiredis) もよくわからない状態からの出発だったので、小さいパッチの割に時間がかかってしまった。hiredis は README.md に書かれている API の説明を読み、mruby はソースコードのコメントアウトに書かれた仕様を読み漁った。

調べたことの正確性は保証出来ないが、ソースコードと一緒に備忘録として書いておく。なお、mruby はバージョン 1.2.0 時点のものである。

HMGET の実装
---

まず、HMGET のコードは以下の通りである。HMSET も似たような実装なので、そちらは割愛する。

```c
static mrb_value mrb_redis_hmget(mrb_state *mrb, mrb_value self)
{
  mrb_value *mrb_argv;
  mrb_int argc = 0;

  mrb_get_args(mrb, "*", &mrb_argv, &argc);
  argc++;

  const char *argv[argc];
  size_t argvlen[argc];
  argv[0] = "HMGET";
  argvlen[0] = sizeof("HMGET") - 1;

  int ai = mrb_gc_arena_save(mrb);
  for (mrb_int argc_current = 1; argc_current < argc; argc_current++) {
    mrb_value curr = mrb_str_to_str(mrb, mrb_argv[argc_current - 1]);
    argv[argc_current] = RSTRING_PTR(curr);
    argvlen[argc_current] = RSTRING_LEN(curr);
    mrb_gc_arena_restore(mrb, ai);
  }

  mrb_value array = mrb_nil_value();
  redisContext *rc = DATA_PTR(self);
  redisReply *rr;
  rr = redisCommandArgv(rc, argc, argv, argvlen);
  if (rr->type == REDIS_REPLY_ARRAY) {
    if (rr->elements > 0) {
      array = mrb_ary_new(mrb);
      for (int i = 0; i < rr->elements; i++) {
        if (rr->element[i]->len > 0) {
          mrb_ary_push(mrb, array, mrb_str_new(mrb, rr->element[i]->str, rr->element[i]->len));
        } else {
          mrb_ary_push(mrb, array, mrb_nil_value());
        }
      }
    }
  } else {
    mrb_raise(mrb, E_ARGUMENT_ERROR, rr->str);
  }

  freeReplyObject(rr);
  return array;
}

...

mrb_define_method(mrb, redis, "hmget", mrb_redis_hmset, (MRB_ARGS_REQ(2) | MRB_ARGS_REST()));
```

最終行の mrb\_define\_method で Redis#redis メソッドを定義している。次は mrb\_define\_method を見ていく。

mrb\_define\_method
---

mrb\_define\_method はメソッドを定義する mruby API である。第2引数がクラス名、第3引数がメソッド名、第4引数がメソッドの呼び出す関数、第5引数はメソッドの引数の数やキーワード、ブロックを指定する。

```c
// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L260
MRB_API void mrb_define_method(mrb_state *mrb, struct RClass *cla, const char *name, mrb_func_t func, mrb_aspec aspec);
```

ソースコードのコメントアウトに *"Defines a global function in ruby."* と書かれている通り、第2引数に mrb->kernel_module を指定し、Kernelモジュールにグローバル関数を定義することもできる。

今回の実装では、`redis` クラスの `hmget` メソッドを呼び出すと、 `mrb_redis_hmget` 関数が呼ばれる。また、HMGET key field [field ...] というコマンドなので、引数は `(MRB_ARGS_REQ(2) | MRB_ARGS_REST())` で「2つまたはそれ以上」としたつもり。

引数に関するマクロは [include/mruby.h](https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h) に定義があるので参考にされたい。今回使った MRB\_ARGS\_REQ(n) と MRB\_ARGS\_REST() は以下のように定義されている。

```c
// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L688
#define MRB_ARGS_REQ(n)     ((mrb_aspec)((n)&0x1f) << 18)

// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L709
#define MRB_ARGS_REST()     ((mrb_aspec)(1 << 12))
```

次は mrb\_redis\_hmget を見ていく。

mrb\_redis\_hmget
---

mrb\_redis\_hmget の冒頭で、引数の中身を取得している。

```c
static mrb_value mrb_redis_hmget(mrb_state *mrb, mrb_value self)
{
  mrb_value *mrb_argv;
  mrb_int argc = 0;

  mrb_get_args(mrb, "*", &mrb_argv, &argc);
  argc++;
```

mrb\_get\_args は引数を取得する mruby API である。HMGET は引数が何個入ってくるかわからないので、 mrb\_args\_format は引数を配列として受け取る `*` にした（今思えば `a` で良かったかもしれない）。フォーマットの詳細は [mruby/mruby\.h#L732-L758](https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L732-L758) を参考にされたい。

```c
MRB_API mrb_int mrb_get_args(mrb_state *mrb, mrb_args_format format, ...);
```

続いて、取得した引数の数 argc を元に、Redis サーバにリクエストするための配列を組み立てていく。 argv と argvlen に引数の中身とその長さを各要素ごとに代入している。

```c
  const char *argv[argc];
  size_t argvlen[argc];
  argv[0] = "HMGET";
  argvlen[0] = sizeof("HMGET") - 1;

  int ai = mrb_gc_arena_save(mrb);
  for (mrb_int argc_current = 1; argc_current < argc; argc_current++) {
    mrb_value curr = mrb_str_to_str(mrb, mrb_argv[argc_current - 1]);
    argv[argc_current] = RSTRING_PTR(curr);
    argvlen[argc_current] = RSTRING_LEN(curr);
    mrb_gc_arena_restore(mrb, ai);
  }
```

また、 mrb_value curr は一時的なオブジェクトなので、mrb_gc_arena_save() と mrb_gc_arena_restore() で GC arena 領域の消費を抑えている。 GC arena の詳細は Matz の日記を参考にされたい。

- [mrubyのmrb_gc_arena_save()/mrb_gc_arena_restore()の使い方 - Matzにっき\(2013\-07\-31\)](http://www.rubyist.net/~matz/20130731.html#p01)

上記の for ループの後、 argv は以下のようになる。最初の引数は `HMGET` という文字列に固定し、それ以降は Redis#hmget の引数が代入される。また、argvlen には argv の各要素の長さが格納されている。

```
    0           1            2                  argc - 1
+-------+-------------+-------------+-----+--------------------+
| HMGET | mrb_argv[0] | mrb_argv[1] | ... | mrb_argv[argc - 1] |
+-------+-------------+-------------+-----+--------------------+
                          *argv[argc]
```

例えば、 `client.hmget "myhash", "field1", "field2"` のようにコマンドを実行すると、 argv は以下のようになるだろう。

```
    0       1        2        3
+-------+--------+--------+--------+
| HMGET | myhash | field1 | field2 |
+-------+--------+--------+--------+
              *argv[4]
```

`const char *argv[argc]` を hiredis の API を透して Redis サーバに投げると、結果を得られる。イメージとしては、まず以下の図のように `const char *argv[argc]` の各要素を決定する。0番目の HMGET はコマンド名で、1番目がハッシュ名、2番目以降が取り出したい値を指すキー名が並ぶ。

`const char *argv[argc]` を hiredis の API を透して Redis サーバに投げると、結果を得られる。HMGET, HMSET は任意のキー数を指定できるので、関数 redisCommandArgv を用いた。

```c
rr = redisCommandArgv(rc, argc, argv, argvlen);
```

関数 redisCommandArgv を通じて Redis サーバにリクエストを送ると、redisReply 型で結果が返ってくる。コード中では `rr` という変数が redisReply 型で宣言されている。 redisReply は redisCommand や redisCommandArgv の結果を格納する構造体で、Redis サーバから得られたオブジェクト (INTEGER, STRING, ARRAY など) が入っている。

```c
/* This is the reply object returned by redisCommand() */
typedef struct redisReply {
    int type; /* REDIS_REPLY_* */
    long long integer; /* The integer when type is REDIS_REPLY_INTEGER */
    size_t len; /* Length of string */
    char *str; /* Used for both REDIS_REPLY_ERROR and REDIS_REPLY_STRING */
    size_t elements; /* number of elements, for REDIS_REPLY_ARRAY */
    struct redisReply **element; /* elements vector for REDIS_REPLY_ARRAY */
} redisReply;
```

関数 `mrb_ary_push` を用いて `mrb_ary_new(mrb)` で Array クラス

関数 `mrb_ary_new(mrb)` は Ruby の `Array.new`

```c
mrb_ary_push(mrb, array, mrb_str_new(mrb, rr->element[i]->str, rr->element[i]->len));
```

```
        0                 1         ...         N
+----------------+----------------+-----+----------------+
| rr->element[0] | rr->element[1] | ... | rr->element[N] |
+----------------+----------------+-----+----------------+
                          array
```

```c
  mrb_value array = mrb_nil_value();
  redisContext *rc = DATA_PTR(self);
  redisReply *rr;
  rr = redisCommandArgv(rc, argc, argv, argvlen);
  if (rr->type == REDIS_REPLY_ARRAY) {
    if (rr->elements > 0) {
      array = mrb_ary_new(mrb);
      for (int i = 0; i < rr->elements; i++) {
        if (rr->element[i]->len > 0) {
          mrb_ary_push(mrb, array, mrb_str_new(mrb, rr->element[i]->str, rr->element[i]->len));
        } else {
          mrb_ary_push(mrb, array, mrb_nil_value());
        }
      }
    }
  } else {
    mrb_raise(mrb, E_ARGUMENT_ERROR, rr->str);
  }
```
```c
  freeReplyObject(rr);
  return array;
```
