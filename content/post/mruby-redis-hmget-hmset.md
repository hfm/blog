---
date: 2016-08-17T20:17:46+09:00
title: mruby-redis に送った HMSET, HMGET のパッチの話
draft: true
cover: /images/2016/08/18/mruby_logo_red.png
tags:
- mruby
- redis
---
[mruby-redis](https://github.com/matsumoto-r/mruby-redis) で Redis の [HMGET](http://redis.io/commands/hmget) と [HMSET](http://redis.io/commands/hmset) を使いたかったのでパッチを送った。

- [Implement Redis\#HMGET and Redis\#HMSET by hfm · Pull Request \#58 · matsumoto\-r/mruby\-redis](https://github.com/matsumoto-r/mruby-redis/pull/58)

mruby も [Hiredis](https://github.com/redis/hiredis) もよくわからない状態からの出発だったので、小さいパッチの割に時間がかかってしまった。Hiredis は README.md に書かれている API の説明を読み、mruby はソースコードのコメントアウトに書かれた仕様を読み漁った。

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

最終行の mrb\_define\_method() で Redis#redis メソッドを定義している。まずは mrb\_define\_method() から見ていく。

mrb\_define\_method()
---

mrb\_define\_method() はメソッドを定義する mruby API である。第2引数がクラス名、第3引数がメソッド名、第4引数がメソッドの呼び出す関数、第5引数がメソッドの引数情報である。引数が情報には、引数の数やキーワード、ブロックを指定する。

```c
// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L260
MRB_API void mrb_define_method(mrb_state *mrb, struct RClass *cla, const char *name, mrb_func_t func, mrb_aspec aspec);
```

ソースコードのコメントアウトに *"Defines a global function in ruby."* と書かれている通り、第2引数に mrb->kernel_module を指定し、Kernelモジュールにグローバル関数を定義することもできる。

今回の実装では、`redis` クラスの `"hmget"` メソッドが `mrb_redis_hmget` 関数を呼び出す。また、HMGET key field [field ...] というコマンドなので、引数情報は `(MRB_ARGS_REQ(2) | MRB_ARGS_REST())` で「2つまたはそれ以上」としたつもり。

引数に関するマクロは [include/mruby.h](https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h) に定義があるので参考にされたい。今回使った MRB\_ARGS\_REQ(n) と MRB\_ARGS\_REST() は以下のように定義されている。

```c
// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L688
#define MRB_ARGS_REQ(n)     ((mrb_aspec)((n)&0x1f) << 18)

// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L709
#define MRB_ARGS_REST()     ((mrb_aspec)(1 << 12))
```

これで Redis#hmget が定義された。次はメソッドの内部実装である mrb\_redis\_hmget() を見ていく。

mrb\_redis\_hmget()
---

### 引数の取得

mrb\_redis\_hmget() の冒頭で、引数の中身を取得している。

```c
static mrb_value mrb_redis_hmget(mrb_state *mrb, mrb_value self)
{
  mrb_value *mrb_argv;
  mrb_int argc = 0;

  mrb_get_args(mrb, "*", &mrb_argv, &argc);
  argc++;
```

mrb\_get\_args() は引数を取得する mruby API である。HMGET は引数が何個入ってくるかわからないので、 mrb\_args\_format は引数を配列として受け取る `*` にした（今思えば `a` で良かったかもしれない）。フォーマットの詳細は [mruby/mruby\.h#L732-L758](https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L732-L758) を参考にされたい。

```c
// https://github.com/mruby/mruby/blob/1.2.0/include/mruby.h#L773
MRB_API mrb_int mrb_get_args(mrb_state *mrb, mrb_args_format format, ...);
```

### Redis へ送るコマンドの組立

続いて、取得した Redis#hmget の引数を元に、Redis に送信するコマンドを組み立てていく。以下のコードでは、配列 argv の各要素に引数のアドレスを、配列 argvlen の各要素に引数の長さをそれぞれ格納している。最初の要素は `HMGET` という文字列で、それ以降が Redis#hmget の引数である。

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

例えば、 `client.hmget "myhash", "field1", "field2"` のようにコマンドを組み立てた場合、argv は以下のようなイメージになる（はず）。

![](/images/2016/08/18/argv.png)

また、ループ内の mrb\_value curr は一時的なオブジェクトなので、mrb\_gc\_arena\_save() と mrb\_gc\_arena\_restore() で GC arena 領域の消費を抑えている...つもりなのだが、完全に理解できているか分からないので、詳しくは Matz の日記を読んでもらいたい。

- [mrubyのmrb\_gc\_arena\_save()/mrb\_gc\_arena\_restore()の使い方 - Matzにっき\(2013\-07\-31\)](http://www.rubyist.net/~matz/20130731.html#p01)

### Hiredis を使った Redis との通信

コマンドを組み立てたら、次は Hiredis を用いて Redis に送信し、リプライを得る。

以下のコードでは、redisCommandArgv() を用いてコマンドを Redis に送信し、得られたリプライを mrb\_value array に格納している。ただし、引数に問題がある場合は ArgumentError 例外が発生する（この例外が荒っぽいので直したい）。

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

redisContext は Redis との接続状態を保持する構造体である。DATA\_PTR は [include/mruby/data.h](https://github.com/mruby/mruby/blob/1.2.0/include/mruby/data.h#L49) で定義されるマクロである（詳細な解説は「[mruby で C 言語の構造体をラップしたオブジェクトを作る正しい方法](http://qiita.com/tsahara@github/items/86610a696f8ca792db45)」にあるので、詳しくは記事を読んでもらいたい。）mruby-redis での DATA\_PTR(self) は、Redis#new が呼び出す [mrb\_redis\_connect()](https://github.com/matsumoto-r/mruby-redis/blob/10426858941703434e718139b0bc8bb5f7fa724d/src/mrb_redis.c#L103-L128) で、redisContext が格納されている。

redisReply はコマンドに対して返されたリプライを格納する構造体である。HMGET の場合はマルチバルクリプライが返るため、`rr->elements` にリプライの要素数が格納され、`rr->element[..index..]` から各要素の値にアクセスできる。

```c
// https://github.com/redis/hiredis/blob/v0.13.3/hiredis.h#L112-L119
typedef struct redisReply {
    int type; /* REDIS_REPLY_* */
    long long integer; /* The integer when type is REDIS_REPLY_INTEGER */
    int len; /* Length of string */
    char *str; /* Used for both REDIS_REPLY_ERROR and REDIS_REPLY_STRING */
    size_t elements; /* number of elements, for REDIS_REPLY_ARRAY */
    struct redisReply **element; /* elements vector for REDIS_REPLY_ARRAY */
} redisReply;
```

https://github.com/redis/hiredis#sending-commands-contd を参考にされたい。

さて、Hiredis のコマンド送信 API は数種あるが、今回用いた redisCommandArgv() は、第2引数に要素数、第3引数に配列、第4引数に引数ごとの長さを指定することで、任意の引数のコマンドを送信できる。

```c
void *redisCommandArgv(redisContext *c, int argc, const char **argv, const size_t *argvlen);
```

リプライがマルチバルクリプライ (REDIS\_REPLY\_ARRAY) で、要素数が 0 より大きい場合、リプライの各要素を mrb\_ary\_push() で array にプッシュしていく。要素が nil の場合もあるので、要素の長さが 0 の場合は mrb\_nil\_value() をプッシュしている。

```c
MRB_API void mrb_ary_push(mrb_state *mrb, mrb_value array, mrb_value value);
```

### リプライを返す

mrb\_value array にリプライを格納し終えたら、freeReplyObject() で redisReply オブジェクトを解放し、array を返す。

```c
  freeReplyObject(rr);
  return array;
```
