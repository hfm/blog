---
title: はじめてのgdbデバッグ
date: 2013-12-21
tags: 
- debug
- ag
- gcore
- gdb
---
仕事で[ag](https://github.com/ggreer/the_silver_searcher)を利用していた時に出会ったバグを、先輩たちの力を借りてなんとかした話です。

先に結論を書くと、業務に用いていたagのバージョンが古いのが原因のようでした。version 0.15より古いとlockの実装に問題があるようです。

```sh
$ ag --version
ag version 0.14pre
```

以下、問題の発覚からなんとかするまでの記録です。

## 発端

### agが途中で止まる

時折、agのファイル操作が先へ進まなくなってしまう不具合がありました。
操作中に対象ファイルのロック状況が変わるとデッドロックが発生しているのでは？と想像。
気になってstraceでプロセスにアタッチすると、以下で停止していることが分かりました。

```
[pid  4589] futex(0x80517e4, FUTEX_WAIT, 32159, NULL
```

#### FUTEX\_WAIT

[futex(2)](http://linuxjm.sourceforge.jp/html/LDP_man-pages/man2/futex.2.html)を引くと、futex(2)の書式に対する操作FUTEX\_WAITの説明があります。

```c
int futex(int *uaddr, int op, int val, const struct timespec *timeout,
          int *uaddr2, int val3);
```

> [*Man page of FUTEX*](http://linuxjm.sourceforge.jp/html/LDP_man-pages/man2/futex.2.html)
> 
> この操作は futex アドレス uaddr に指定された値 val がまだ格納されているかどうかを不可分操作で検証し、 sleep 状態で この futex アドレスに対して __FUTEX\_WAKE が実行されるのを待つ__。 timeout 引き数が ... __NULL の場合、 呼び出しは無限に停止する。__ 引き数 uaddr2 と val3 は無視される。...

FUTEX\_WAKEがなんらかの理由によって実行されず、待ち状態が終わらないようでした。

## バックトレース

もう少し詳しく調べるため、上記の状態で止まったままのagのコアダンプをgcoreで取得。

```sh
$ gcore -o /tmp/ag_suspended.core 22650
```

コアダンプをgdbで読み込み。

```c-objdump
$ gdb /usr/bin/ag ag_suspended.core.22650
GNU gdb Red Hat Linux (6.3.0.0-1.162.el4rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...(no debugging symbols found)
Using host libthread_db library "/lib/tls/libthread_db.so.1".

Core was generated by `/usr/bin/ag'.
Reading symbols from /lib/libpcre.so.0...(no debugging symbols found)...done.
Loaded symbols for /lib/libpcre.so.0
Reading symbols from /usr/lib/libz.so.1...(no debugging symbols found)...done.
Loaded symbols for /usr/lib/libz.so.1
Reading symbols from /lib/tls/libpthread.so.0...(no debugging symbols found)...done.
Loaded symbols for /lib/tls/libpthread.so.0
Reading symbols from /lib/tls/libc.so.6...(no debugging symbols found)...done.
Loaded symbols for /lib/tls/libc.so.6
Reading symbols from /lib/ld-linux.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /lib/libgcc_s.so.1...(no debugging symbols found)...done.
Loaded symbols for /lib/libgcc_s.so.1

#0  0x0053b7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
```

スレッド数の確認。2つあります。

```c-objdump
(gdb) info thread
  2 process 22650  0x0053b7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
* 1 process 22663  0x0053b7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
```

スレッド1のバックトレース。  
`pthread_cond_wait()`で停止していることが分かります。

```c-objdump
(gdb) bt
#0  0x0053b7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
#1  0x00c65ef6 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/tls/libpthread.so.0
#2  0x0804c9bf in search_file_worker ()
#3  0x00c635cc in start_thread () from /lib/tls/libpthread.so.0
#4  0x0062535e in clone () from /lib/tls/libc.so.6
```

スレッド2のバックトレース。  
`pthread_join()`で停止していることが分かります。

```c-objdump
(gdb) thread 2
[Switching to thread 2 (process 22650)]#0  0x0053b7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
(gdb) bt
#0  0x0053b7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
#1  0x00c64497 in pthread_join () from /lib/tls/libpthread.so.0
#2  0x0804e74c in main ()
```

## the silver searcherのコードを調べる

仕事で使っていたagのversionが0.14preだったため、以下に示すコードのTagも0.14にしています。

### main.c

`pthread_join(3)`は[src/main.cのL127 (at 0.14)](https://github.com/ggreer/the_silver_searcher/blob/0.14/src/main.c#L127) で呼ばれているようです。

```c
int pthread_join(pthread_t th, void **thread_return);
```

> [*Man page of PTHREAD\_JOIN*](http://linuxjm.sourceforge.jp/html/glibc-linuxthreads/man3/pthread_join.3.html)
> 
> pthread\_join は、 呼び出しスレッドの実行を停止し、 th で指定したスレッドが pthread\_exit(3) を呼び出して終了するか、取り消しされて終了するのを待つ。

### search.c

`pthread_cond_wait(3)`は[src/search.cのL265 (at 0.14)](https://github.com/ggreer/the_silver_searcher/blob/0.14/src/search.c#L265) で呼ばれているようです。

> [*Man page of PTHREAD_COND*](http://linuxjm.sourceforge.jp/html/glibc-linuxthreads/man3/pthread_cond_wait.3.html)
> 
>pthread\_cond\_wait は ( pthread\_mutex\_unlock による) mutex のアンロックと条件変数 cond の送信に対する待機を一息で行う。条件変数が送信されるまで スレッドの実行は停止され、CPU 時間を消費することはない。 mutex は、 pthread\_cond\_wait の開始時点で、これを呼び出すスレッドによってロックされていなければ ならない。 呼び出し側のスレッドに戻る前に pthread\_cond\_wait は mutex を ( pthread\_mutex\_lock によって)再び獲得する。
> 
> mutex のアンロックと条件変数に対する待機は一息に行われる。従って、 全てのスレッドが条件を送信する前に常に mutex を獲得するのならば、 スレッドが mutex をアンロックする時点と、それが条件変数を待つ時点 との中間の時点で、条件の送信が行なわれる(従って無視される)ことが 不可能となることが保証される。 

### work\_queue\_mutexのPull Request

上記2つの周辺コードが怪しいのではないか？と調べている内に、自分が遭遇した問題と全く同じIssue、そしてそれを改善しているプルリクを発見。

> [*ensure work_queue_mutex is locked when signaling files_ready.*](https://github.com/ggreer/the_silver_searcher/pull/224)
> 
>  (Apparently) Fixes [#182](https://github.com/ggreer/the_silver_searcher/issues/182)

上のプルリクがmergeされたcommitは [Merge pull request #224 from jmesmon/fix_182 · 83fdc49 · ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher/commit/83fdc4986fab15fe9aefaf451a2b2d4a880fad85) で、このcommitが含まれるagのバージョン一覧を見ると…、


```sh
$ git tag --contain 83fdc49
0.15
0.16
0.17
0.18
0.18.1
```

__0 . 1 5 ! ?__

## 結論

仕事で使っていたagのバージョンは0.14pre、そして上記のバグ修正comittがmergeされたのは0.15以上。

```sh
$ ag --version
ag version 0.14pre
```

とほほ…。

というわけで、早速agのバージョンを上げたのでした。

## 終わりに

問題解決にあたって、[tnmt先輩](https://twitter.com/tnmt)、[hiboma先輩](https://twitter.com/hiboma)、[udzura先輩](https://twitter.com/udzura)にとてもお世話になりました。
社内IRCの#kernelチャンネルでワイワイしていてとても楽しかったです。

プログラムに不審な挙動が見られた時に、どういう順序でアプローチし、解決していけばいいのかということを勉強させていただきました。

結果バージョンアップすれば良いというオチではありましたが、得たものはそれ以上に多かったし大きかったです。

おしまい。

### 参考

 * [Man page of FUTEX](http://linuxjm.sourceforge.jp/html/LDP_man-pages/man2/futex.2.html)
 * [■ gdb のRPM に付属する /usr/bin/gstack, /usr/bin/gcore コマンド](http://d.hatena.ne.jp/hiboma/20130303/1362245908)
 * [ggreer/the\_silver\_searcher](https://github.com/ggreer/the_silver_searcher)
   * [the_silver_searcher/src/search.c at master](https://github.com/ggreer/the_silver_searcher/blob/master/src/search.c#L274)
   * [ensure work_queue_mutex is locked when signaling files_ready. by jmesmon · Pull Request #224](https://github.com/ggreer/the_silver_searcher/pull/224)
   * [Merge pull request #224 from jmesmon/fix_182 · 83fdc49](https://github.com/ggreer/the_silver_searcher/commit/83fdc4986fab15fe9aefaf451a2b2d4a880fad85)
 * [Man page of PTHREAD_JOIN](http://linuxjm.sourceforge.jp/html/glibc-linuxthreads/man3/pthread_join.3.html)
 * [Man page of PTHREAD_COND](http://linuxjm.sourceforge.jp/html/glibc-linuxthreads/man3/pthread_cond_wait.3.html)
