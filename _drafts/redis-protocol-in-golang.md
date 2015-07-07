---
layout: post
date: 2015-05-07 07:47:44 +0900
title: Go言語を使ってRedis Protocol (RESP) でおしゃべりする
tags:
- golang
- redis
---
最近、[Go Newsletter](http://golangweekly.com/)に登録して、Go言語に関する記事を毎週読んでいる。
今のところ、惹かれたタイトルの記事をとりあえず読んでみるくらいの感覚で続いてる。

その中で、[Reading and Writing Redis Protocol in Go](http://www.redisgreen.net/blog/reading-and-writing-redis-protocol/)という、Go言語を使ってRedis Protocolの一部を実装してみようという記事を見つけた。
Redisはなんとなく程度の浅い理解しか持っていなかったので、Go言語の勉強も兼ねて、あれこれ調べつつ手を動かしてみることにした。

RESP (REdis Serialization Protocol)
---

Redisを知るにはまずプロトコルから、ということでRedisのクライアント・サーバ間通信で用いられるRESPについて少し調べた。

RESPはテキストベースなプロトコルで、クライアント・サーバ間の通信で利用される (例外的に、Redis Clusterはノード間メッセージ通信に異なるバイナリプロトコルを使っているらしい)。

RESP自体はTCPに限定された技術では無いものの、その実装であるRedisではTCP接続が用いられている (あるいはUNIXドメインソケットのようなストリーム志向の接続方式)。
ちなみにデフォルトで使われるTCPポートは6379番である。

### RESPがサポートする5つの型

RESPは5つの型が存在する。
また、いずれの型にも共通した開始文字と終端記号がある。

#### 型とそれぞれのprefix

RESPでは、5つの型と、それらを区別するために最初の1バイト目を次のように規定している。

TYPES          | PREFIX
---------------|-------
Simple strings | `+`
Errors         | `-`
Integers       | `:`
Bulk strings   | `$`
Arrays         | `*`

#### 終端記号 CRLF

RESPでは、1つのデータの終端記号として `\r\n` (CRLF)を利用している。

### RESPの型のそれぞれの特徴

各型には、prefixと終端記号の他に、以下のような特徴がある。

#### Simple strings

- `+` 記号に続いて、 `OK` や `PONG` といった短い文字列
- 最小のオーバヘッドで、非バイナリセーフな文字列を送る際に用いられる
- バイナリセーフな文字列の送信には、Bulk stringsを代わりに用いる

例：

```
+OK\r\n
+PONG\r\n
```

#### Errors

- `-` 記号に続いて、エラー内容が書かれた文字列
- それ以外はSimple stringsとほぼ同じ
- **Error Prefix** と呼ばれるエラーの型と、エラーメッセージを同梱する方法が一般的

例：

```
-ERR unknown command 'foobar'
-WRONGTYPE Operation against a key holding the wrong kind of value
```

#### Integers

- `:` 記号に続いて、整数が入る

例：

```
:100\r\n
```

#### Bulk strings

- `$` 記号に続いて、格納されている文字列のバイト数、続いてCRLF
- その後に続いて、実際の文字列

例：

```
$0\r\n\r\n
$3\r\nfoo\r\n
$9\r\nfoobarbaz\r\n
```

あと、 **Null Bulk String** と呼ばれる、Nullを示すBulk stringは以下のように表現される。

```
$-1\r\n
```

#### Arrays

- `*` 記号に続いて、配列の要素数、続いてCRLF
- その後に続いて、格納されている要素がそれぞれ入る

例：

```
*2\r\n$4\r\nhoge\r\n$4\r\nfuga\r\n
```

ややこしいが、上の例は `hoge` と `fuga` という2つの文字列が格納されたArraysである。

まずはtelnetで遊んでみる
---

RESPは大体分かってきたので、実際にデータをやりとりしてみる。
まずはササッと試せるtelnetで。

### redisサーバの起動

OSXで、homebrewからインストールしたredisサーバを起動する。
redis.confは特に編集してないので、素の状態で起動しているはず。

```
$ redis-server /usr/local/etc/redis.conf
60828:M 07 May 18:57:21.556 * Increased maximum number of open files to 10032 (it was originally set to 2560).
                _._
           _.-``__ ''-._
      _.-``    `.  `_.  ''-._           Redis 3.0.0 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 60828
  `-._    `-._  `-./  _.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |           http://redis.io
  `-._    `-._`-.__.-'_.-'    _.-'
 |`-._`-._    `-.__.-'    _.-'_.-'|
 |    `-._`-._        _.-'_.-'    |
  `-._    `-._`-.__.-'_.-'    _.-'
      `-._    `-.__.-'    _.-'
          `-._        _.-'
              `-.__.-'
```

### telnetアクセス

localhostの6379番にtelnetアクセスし、プロトコルとおしゃべり。
各コマンドに対する返り値はいずれもRESPの通りで、これを理解しているとちゃんと読めるなあという感じ。
以下の例で、 `★` をつけたところは注釈である。

```
$ telnet 127.0.0.1 6379
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
ping                    ★pingと打ったらPONGと返ってくるようになってる (Simple Strings)
+PONG
keys *                  ★保存されてるキー一覧取得
*0
set a_key a_value       ★a_key/a_value というkey/value値を保存
+OK
keys *
*1                      ★key/value が1組増えたので 1 に増加
$5
a_key
get a_key               ★a_key の中身を確認
$7
a_value
del a_key               ★a_key を削除
:1
keys *
*0
^]
telnet> quit
```

Go言語によるRESPの実装
---



参考
---

- [A Beginner's Guide to the Redis Protocol](http://www.redisgreen.net/blog/beginners-guide-to-redis-protocol/)
- [Redis Protocol specification – Redis](http://redis.io/topics/protocol)
- [Reading and Writing Redis Protocol in Go](http://www.redisgreen.net/blog/reading-and-writing-redis-protocol/?utm_source=golangweekly&utm_medium=email)
