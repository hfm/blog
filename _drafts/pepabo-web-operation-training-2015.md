---
layout: post
date: 2015-07-13 09:27:00 +0900
title: ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まりました
tags:
- pepabo
---
「[ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)」にも書いたとおり、先月の6/8からペパボ新卒エンジニア研修がスタートしています。
そして先週7/3(金)に、4週間続いた[Web開発研修](http://www.slideshare.net/hifumis/20150609-webdevelopmenttraining)がゴールを迎えました。


この1ヶ月の出来事
---

箇条書きにすると、主に以下の6つの出来事がありました。

- Web開発研修
- Web開発研修ふりかえり会
- Webオペレーション研修イントロダクション
- Webオペレーション研修

ここから、それぞれの出来事についてお話していきます。

Web開発研修
---

### どのような進め方だったか

Web 開発研修では、 [Ruby on Rails Tutorial (en)](https://www.railstutorial.org) を、概ね次のようなやり方で読み進めていました。

1. github.com にリポジトリを作る
  - [Joe-noh/sample_app](https://github.com/Joe-noh/sample_app)
  - [alotofwe/sample_app](https://github.com/alotofwe/sample_app)
  - [hanazuki/railstutorial](https://github.com/hanazuki/railstutorial)
  - [komaji/sample_app](https://github.com/komaji/sample_app)
  - [orzup/ruby-on-rails-tutorial](https://github.com/orzup/ruby-on-rails-tutorial)
  - [takuminnnn/sample_app](https://github.com/takuminnnn/sample_app)
1. Chapterを読み進める
1. ExercisesはPull Requestsを作る
  - 同期同士でレビューする
  - PRのmerge条件は自ら提示する（レビュー人数、特に見てほしい箇所など）
  - （コミットメッセージやPR文などのお作法は先輩エンジニアもレビューする）
1. 2と3を繰り返す

#### Exerices のピアレビュー

Exerices では Pull Requests を作って、ピアレビュー形式で進めてもらいました。

当初は先輩もコードレビューした方が良いだろうと思っていたのですが、新卒同士でも素晴らしいレビューが出来ていたので、その心配は杞憂に終わりました（一部先輩エンジニアもコメントしてますが）。

- [[Exercise 10.5] Add an integration test for the expired password reset and more by takuminnnn](https://github.com/takuminnnn/sample_app/pull/16)
- [Chapter12のエクササイズをやる by orzup #discussion-diff-33749315](https://github.com/orzup/rails-tutorial/pull/26#discussion-diff-33749315)
- [[Exercise/7.3-4] Refactor and add test for post-signup flash message by hanazuki](https://github.com/hanazuki/railstutorial/pull/13)

PR を merge するための条件を自ら提示するというのは、課題の難しさ（あるいは自分の書いたコードへの自信）を最も分かっているのは、それを書いた本人だろうというところから生まれました。
Exerices の中には、ほとんど答えが書かれているような内容もあり、そうした場合はレビューが無くとも本に書いてあるのだからセルフマージしても良いですし、Rails Tutorial 後半の Exerices になると難易度も上がってくるため、最低1人のレビュー、LGTMをもらいたい

### 毎日の進捗確認はカンバン（ホワイトボード）で行う

#### カンバン (Before)

[前回](/2015/06/14/pepabo-engineer-training-2015/)のスタート直後のカンバンがこちら。

[![](/images/2015/06/14/training02_large.jpg)](/images/2015/06/14/training02_full.jpg)

#### カンバン (After)

4週間を経て、いろいろスケジュールを工夫したり、途中で明らかになったタスクなどが盛り込まれたり、色々な経験をヘタカンバンがこちら。

[![](/images/2015/07/13/kanban_large.jpg)](/images/2015/07/13/kanban_full.jpg)

色々と成長している様子が伺えます。

### ふりかえりの様子

[![](/images/2015/07/13/kpt01_large.jpg)](/images/2015/07/13/kpt01_full.jpg)

[![](/images/2015/07/13/kpt02_large.jpg)](/images/2015/07/13/kpt02_full.jpg)

Webオペレーション研修イントロダクション
---

### ボスケテについて

スライド中では特に説明もなく使用していたのですが、「ボスケテ」は漫画『セクシーコマンドー外伝　すごいよ!!マサルさん』が元ネタです。
「助けて」よりも語感がカジュアルで、コミュニケーションや困ってることを共有するのに便利です。

元々このフレーズは [@ume3_](https://twitter.com/ume3_) さんのいるチームが、チームビルディングにおいて使い始めました。
入社したばかりのスタッフでも、緊張せずカジュアルに質問できるような環境づくりや、

<iframe src="//www.slideshare.net/slideshow/embed_code/key/2apyPGVBKVbPUU?startSlide=19" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ume3_/20140805-teambuilding-reportsabaten" title="インフラで実践したチームビルディングそれはサバ天" target="_blank">インフラで実践したチームビルディングそれはサバ天</a> </strong> from <strong><a href="//www.slideshare.net/ume3_" target="_blank">ume3_</a></strong> </div>

Webオペレーション研修（1週目の様子）
---


### 1. manual install
#### 1.0 VirtualBox を Mac にインストールする
#### 1.1 VagrantでCentOS 7のVMを作る
#### 1.2 VM上のWebアプリにアクセス可能にする
- 1.2.1 Rails Tutorial の Web アプリを MySQL (MariaDB) 対応にする
- 1.2.2 VM に Ruby 2.2 をインストールする
- 1.2.3 VagrantにRailsが動く環境を用意する
#### 1.3 WEBrickからNginx + Unicornに切り替える
### 2. test
#### 2.1 Serverspecをインストール
#### 2.2 サーバのテストを書く
#### 2.3 余裕があればInfratasterでのテストも導入する
### 3. infra as code
#### 3.1 Itamaeをインストールする
#### 3.2 manual installの手順をコード化する
#### 3.3 新規VMにItamaeを実行する
#### 3.4 テストをオールグリーンにする
### 4. transfer
#### 4.1 NyahのVMを1個作る
#### 4.2 Itamaeでサーバ構築
#### 4.3 テストをオールグリーンにする
### 5. high availability

#### 5.1 app/dbを分離

keywords: [GRANT Syntax (MySQL)](https://dev.mysql.com/doc/refman/5.7/en/grant.html), `user_specification` (`user_name@host_name`)

app (+ web) と db の2つのロールを分割する

```
      +-----+
      | app |
      +-----+
         |
      +-----+
      | db  |
      +-----+
```

- Vagrantfile に2つ目の define を作る
- Itamae のクックブックを修正する (role ごとに recipe を作成する)
- **Vagrant のVM で**動作確認をする
- **Nyah で**2つ目の VM を作る
- Itamae を **Nyah の VM** に実行する
- Serverspec でオールグリーンであることを確認する

#### ポイント

- [MySQLに外部ホストから接続できるように設定する | Linuxで自宅サーバ構築](http://linuxserver.jp/%E3%82%B5%E3%83%BC%E3%83%90%E6%A7%8B%E7%AF%89/db/mysql/%E5%A4%96%E9%83%A8%E6%8E%A5%E7%B6%9A%E8%A8%B1%E5%8F%AF%E8%A8%AD%E5%AE%9A.php)
- Nyah のセキュリティグループの活用も視野に入れる

### 5.2 dbの冗長化

keywords: master/slave, replication

Master/Slave 構成を作成し、レプリケーションさせる

```
      +-----+
      | app |
      +-----+
         |
    +--------+   +---------+
    | master |---| replica |
    +--------+   +---------+
```

必ずしもこの手順通りでなくとも良いが、参考までに。

- Itamae でレプリカサーバのrecipeを作成
  - マスターとレプリカの `my.cnf` の確認 (`log_bin`, `server_id`, ...)
- レプリケーションアカウントの作成
- レプリカの初期化
  - 3つ目の VM を作る
  - Itamae で構成を揃える
  - マスターデータのダンプ
  - レプリカへのリストア
- レプリケーション開始

※ リストア時にそのままレプリケーション開始させてもよいが、リストア操作とレプリカ操作は別の操作であり、基本的には分けてやることを推奨する

#### ポイント

- MariaDB (MySQL) のレプリケーションの仕組みを理解しているか？
  - SQL thread, I/O thread についての知識
  - MySQL 5.5 Reference Manual
    - [5.2.4 The Binary Log](https://dev.mysql.com/doc/refman/5.5/en/binary-log.html)
    - [17.2.1 Replication Implementation Details](https://dev.mysql.com/doc/refman/5.5/en/replication-implementation-details.html)
    - [17.2.2.1 The Slave Relay Log](https://dev.mysql.com/doc/refman/5.5/en/slave-logs-relaylog.html)
    - [17.2.2.2 Slave Status Logs](https://dev.mysql.com/doc/refman/5.5/en/slave-logs-status.html)
  - 図説できることが好ましい
- レプリケーションはステートメントベース？行ベース？ミックスベース？
  - yum から入る MariaDB 5.5.x のデフォルトを確認してみよう
  - https://dev.mysql.com/doc/refman/5.5/en/replication-formats.html

### 5.3 リバースプロキシの導入

keywords: reverse proxy, upstream, TCP (, ngx_mruby)

app サーバの（ネットワーク的に）前にリバースプロキシを設置する

```
 +---------------+
 | reverse proxy |
 +---------------+
         |
      +-----+
      | app |
      +-----+
         |
    +--------+   +---------+
    | master |---| replica |
    +--------+   +---------+
```

- [NGINX Reverse Proxy | NGINX](https://www.nginx.com/resources/admin-guide/reverse-proxy/)
  - [Module ngx_http_proxy_module#proxy_pass](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass)
  - [Module ngx_http_proxy_module#proxy_buffers](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_buffers)
- [NGINX Load Balancing | NGINX](https://www.nginx.com/resources/admin-guide/load-balancer/)
  - [Module ngx_http_upstream_module](http://nginx.org/en/docs/http/ngx_http_upstream_module.html)

#### ポイント

- これまで「app」と称していたサーバには、実は nginx という Web サーバも同居していた
- リバースプロキシの導入により、 app から Web サーバが分離される

### 5.4 ストレージの分離

keywords: storage

app サーバからストレージを分離する。

```
 +---------------+
 | reverse proxy |
 +---------------+
         |
      +-----+   +---------+
      | app |---| storage |
      +-----+   +---------+
         |
    +--------+   +---------+
    | master |---| replica |
    +--------+   +---------+
```

- app (Rails) では [carrierwaveuploader/carrierwave](https://github.com/carrierwaveuploader/carrierwave) を使って、サーバのローカルにファイルを保存していた
- 5.5 で app の冗長化をするためには、ストレージを共有化させる必要がある
- ストレージサーバは何でも良い
  - Dropbox を使う
    - [robin850/carrierwave-dropbox](https://github.com/robin850/carrierwave-dropbox)
  - WebDAV サーバを建てる
    - [qinix/carrierwave-webdav](https://github.com/qinix/carrierwave-webdav)
    - ヘテムルを使う（依頼する）手もある
  - SFTP サーバを建てる
    - [damncabbage/carrierwave-sftp](https://github.com/damncabbage/carrierwave-sftp)
    - ロリポップ！を使う（依頼する）手もある
  - bayt?

### 5.5 app の冗長化

keywords: scale out

複数台の app サーバを用意し、 reverse proxy でアクセスを振り分ける

```
 +---------------+
 | reverse proxy |
 +---------------+
         |
...................
.                 .
. +-----+ +-----+ .   +---------+
. | app | | app | .---| storage |
. +-----+ +-----+ .   +---------+
...................
         |
    +--------+   +---------+
    | master |---| replica |
    +--------+   +---------+
```

### (Extra) 5.6 セッションサーバの分離

keywords: session server, redis, memcached

app サーバが冗長化されたことにより、セッション情報を共有させなければならない課題が生じる

```
 +---------------+
 | reverse proxy |
 +---------------+
         |
...................   +---------+
.                 .---| storage |
. +-----+ +-----+ .   +---------+
. | app | | app | .   +---------+
. +-----+ +-----+ .---| session |
...................   +---------+
         |
    +--------+   +---------+
    | master |---| replica |
    +--------+   +---------+
```

- [Redis](http://redis.io/)
  - 社内でRails 4.x + Redis なところ
    - https://git.pepabo.com/cmsp/suzuri
    - https://git.pepabo.com/cmsp/colorme-api
- [memcached - a distributed memory object caching system](http://memcached.org/)
  - [mperham/dalli](https://github.com/mperham/dalli)
