---
date: 2015-04-24T07:08:18+09:00
title: mysqladminつらい。
tags:
- mysql
---
昨日めっちゃハマってつらい思いをしたので。

パーミションと実行ユーザつらい
---

muninのMySQLプラグインのいくつかは`mysqladmin`を実行する。
mysql_connectionsとかmysql_threadsとか。

それらがうまく動かないと思ったら、`/var/lib/mysql`が700で`mysql.sock`にアクセス出来てなかった。

`/etc/munin/plugin-conf.d/mysql`に以下のように書き、実行ユーザをrootに切り替えてなんとかした。

```ini
[mysql*]
user root
```

muninでrootアクセスするのはなるべく少ない方がいいと思うんだけど、`/var/lib/mysql`を755にするのはもっと変な気がするし、かといってmuninからmysqlユーザでアクセスするのも怖い。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">実行ユーザとパーミッションに振り回されてた...</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/591160833343795200">2015, 4月 23</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

mysqladminのオプションの書き順つらい
---

`--defaults-extra-file`を使う時はあるが、どうやら`--`から始まるいくつかのオプションは、コマンドの最初の引数にしなければならないらしい。
よく見ればhelpにもそう書いてた。

間違って以下のように実行したら`unknown option '--no-defaults'`で社会は厳しい。

```console
$ mysqladmin -u user --no-defaults ping
mysqladmin: unknown option '--no-defaults'
```

この問題について、[@rrreeeyyy](https://twitter.com/rrreeeyyy)君がソースコードから調べてくれた。
どうやら、MySQLのコマンド全体に共通する引数 defaults 系と、mysqladminやmysqldump等の個別のコマンド引数が別々に読み込まれる仕様になってるらしい。

> https://github.com/mysql/mysql-server/blob/mysql-5.5.32/client/mysqladmin.cc#L305-L320
>
> ```c++
> int main(int argc,char *argv[])
> {
>   int error= 0, ho_error;
>   MYSQL mysql;
>   char **commands, **save_argv;
>
>   MY_INIT(argv[0]);
>   mysql_init(&mysql);
>   if (load_defaults("my",load_default_groups,&argc,&argv))
>    exit(1);
>   save_argv = argv;				/* Save for free_defaults */
>   if ((ho_error=handle_options(&argc, &argv, my_long_options, get_one_option)))
>   {
>     free_defaults(save_argv);
>     exit(ho_error);
>   }
> ```

↑の`load_defaults`から`mysys/default.c`に飛んでアレコレ読んでると、--no-defaultsの位置が決め打ちになってたりして、おやおや〜〜！！って気持ちになってくる。

> https://github.com/mysql/mysql-server/blob/mysql-5.5.32/mysys/default.c#L530
>
> ```c++
> if (*argc >= 2 && !strcmp(argv[0][1],"--no-defaults"))  // argv[0][1] の扱いに厳しいコードだ
> ```

`load_defaults -> my_load_defaults -> get_defaults_options`辺りまで読んでいくと、argcやargv、`--`系オプションの扱いについてなるほどといった気持ちになる。

--no-defaultsや--defaults-extra-fileを使いたいときは、オプションの指定順序に気をつけないと死ぬ。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">mysql周りの何かを改善しようとすると、関係ないとこでハマりまくるからホントつらい</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/591171262291922944">2015, 4月 23</a></blockquote>

my.cnfのuser, passwordつらい
---

パスワード入力が面倒くさいので、localhostならパス無しで打てるように`GRANT SELECT ON *.* TO 'ro'@'localhost'`みたいなユーザを作ったりする (本番ではあまりやらない方がいい)。

この時、`/etc/my.cnf` `/root/.my.cnf` `~/my.cnf`あたりに、以下のような設定があると地味にハマる。

```ini
[mysqladmin]
user=foo
password=bar
```

この時、`mysqladmin -u ro ping`と打つとアクセスに失敗してしまう。

```console
$ mysqladmin -u ro ping
mysqladmin: connect to server at 'localhost' failed
error: 'Access denied for user: 'ro@localhost' (Using password: YES)'
```

my.cnfに書いた`user=foo`は`ro`に上書きされるが、`password=bar`はそのまま使われてしまうらしい。

考えてみれば、my.cnfはデフォルトを設定するもので、userを上書きしたらpasswordもクリアしてくれる、なんてことは無いのだ。

しかし、verboseに出力してもどの値を使ってるのかイマイチ分からないし、デバッグしにくくてしょうがない。

こういう時は`--no-defaults`や`--defaults-file` `--defaults-extra-file`を使って、読み込むべきmy.cnfを操作する。

```
mysqladmin --defaults-file=/path/to/special-my.cnf
mysqladmin --no-defaults -u ro
```

mysqladminつらい。
---

あとmuninもつらい。

おわりに
---

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">またMySQLで消耗する話題を１個手に入れてしまった</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/591170622606086144">2015, 4月 23</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">mysqlの問題に遭遇する度に二度と触りたくないって思うんだけど、しばらくするとまたmysqlのチューニングとかアーキテクチャを考えてる自分がいる…こっ、これはもしや恋</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/591179396574117888">2015, 4月 23</a></blockquote>
