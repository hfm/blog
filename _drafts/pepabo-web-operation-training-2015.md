---
layout: post
date: 2015-07-21 09:00:00 +0900
title: ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています
tags:
- pepabo
---
「[ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)」にも書いたとおり、先月の6/8からペパボ新卒エンジニア研修がスタートしています。
そして 7/3(金) に、約4週間続いた[Web開発研修](http://www.slideshare.net/hifumis/20150609-webdevelopmenttraining)がゴールを迎え、翌週 7/6(月) から新たにWebオペレーション研修が幕を開けました。

今回は、Web開発研修をどのように進めていったかと、Webオペレーション研修の導入のお話をしようと思います。

Web開発研修
---

### どのような進め方だったか

Web開発研修では、[Ruby on Rails Tutorial (en)](https://www.railstutorial.org) を、概ね以下のようなやり方で進めてもらいました。

1. github.com にリポジトリを作る
  - [Joe-noh/sample_app](https://github.com/Joe-noh/sample_app)
  - [alotofwe/sample_app](https://github.com/alotofwe/sample_app)
  - [hanazuki/railstutorial](https://github.com/hanazuki/railstutorial)
  - [komaji/sample_app](https://github.com/komaji/sample_app)
  - [orzup/ruby-on-rails-tutorial](https://github.com/orzup/ruby-on-rails-tutorial)
  - [takuminnnn/sample_app](https://github.com/takuminnnn/sample_app)
1. Chapter を読み進める
1. Exercises は Pull Request を作る
  - 同期同士でレビューする（ピアレビュー）
  - merge 条件は自ら提示する（レビュー人数、特に見てほしい箇所など）
  - （コミットメッセージやPR文などのお作法は、先輩エンジニアもレビューする）
1. 2と3を繰り返す

#### Exerices でのピアレビュー

Exerices では PR を作り、ピアレビューを実践してもらいまいした。
また、Exerices の難易度（あるいはコードへの自信）は、取り組んだ本人が最も分かっているだろうということで、merge 条件を自ら提示してもらうようにしました。

当初は先輩もコードレビューした方が良いだろうと思っていたのですが、素晴らしいピアレビューの様子から、その心配は杞憂に終わりました（一部先輩エンジニアもコメントしてますが）。

- [[Exercise 10.5] Add an integration test for the expired password reset and more by takuminnnn](https://github.com/takuminnnn/sample_app/pull/16)
- [Chapter12のエクササイズをやる by orzup #discussion-diff-33749315](https://github.com/orzup/rails-tutorial/pull/26#discussion-diff-33749315)
- [[Exercise/7.3-4] Refactor and add test for post-signup flash message by hanazuki](https://github.com/hanazuki/railstutorial/pull/13)

### ホワイトボードで毎日の進捗確認

研修では朝会・夕会を導入しており、毎朝夕にホワイトボードの前に集まり、各人の進捗や困っていることなどを共有しています。

この時、作業中にハマったことや共有事項などがホワイトボードにどんどん足されていきます。

#### Before

Web開発研修がスタートした頃のホワイトボードがこちら。

[![](/images/2015/06/14/training02_large.jpg)](/images/2015/06/14/training02_full.jpg)
*始まったばかりで付箋の数もおとなしめ*

#### After

4週間で色々な経験を得た様子がこちら。

[![](/images/2015/07/21/kanban_large.jpg)](/images/2015/07/21/kanban_full.jpg)
*当初の見積りと計画からズレを感じる度に再見積りをしたり、再計画をしたり、付箋を足していった結果*

マグネットやシールなど、賑やかになっている様子が伺えます。
守り神も居られます。

### Web開発研修のふりかえり (KPT) の様子

7/3 のWeb開発研修最終日には、みんなでこの4週間のふりかえり (KPT) を行いました。

[![](/images/2015/07/21/kpt01_large.jpg)](/images/2015/07/21/kpt01_full.jpg)
*「放送室」と呼ばれる会議室にて、この4週間のふりかえりをしている様子*

[![](/images/2015/07/21/kpt02_large.jpg)](/images/2015/07/21/kpt02_full.jpg)
*若干見づらいですが、Web開発研修の KPT です（一部モザイクをかけています）*

色々なテーマが出ましたが、「ピアレビュー」「体調管理」「時間管理」「ボスケテ（後述）」あたりが特に大きいでしょうか。
研修がスタートすると、みんな集中して取り組むのですが、集中しすぎて相当疲労してしまい、1週間のペース配分がうまくいかない大変さがあったようです。

リフレッシュタスクを作ってみるなり、GMOインターネットグループでも推奨されているシエスタ[^1]を実施してみるなど、時間と体調を管理することについてアレコレ議論していました。

ちなみに Try の一番下に「Rails Tutorial を完走しよう」と書かれているのは私のことです...
アレコレ仕事してたら全然進められなかったので、なんとか終わらせようと思います（とはいえ、2年前の新卒時代と、去年の新卒研修でもやったので、都合3回目。）

Webオペレーション研修イントロダクション
---

さて、7/6 からは新たにWebオペレーション研修が始まりました。
初日はイントロダクションとして、Webオペレーション研修やゴールや進め方についてお話させていただきました。

ここにslideshareからスライドを埋め込む。

Webオペレーション研修のゴール
---

Webオペレーション研修では、「アプリが『動く』インフラを、ステップ・バイ・ステップで成長させる」ことをゴールとして、5つのステップを設けました。

![](/images/2015/07/21/goal.png)
*Vagrant編・Nyah編、合わせて5つのステップ*

Nyah とは、ペパボで導入された OpenStack ベースの仮想インフラ基盤です。
Nyah については以下のスライドが詳しいので、そちらをご覧ください。

- [Nyah ポチポチするために ニャーニャーしよう #pbtech](http://www.slideshare.net/ume3_/pb-tc01-bob001)
- [ペパボにおけるOpenStackHacks! 〜僕と夏を一緒にトゥギャザーしま専科！！ 編〜](https://speakerdeck.com/pyama86/pepaboniokeruopenstackhacks)

また、各ステップの課題は以下のとおりです。

- Vagrant編
  1. Web開発研修で作成した Rails アプリを、Vagrant で動かす (manual install)
  1. Serverspec, Infrataster などでサーバの構成・振る舞いをテストする (test)
  1. Itamaeでサーバ構成をコード化する (infra as code)
- Nyah編
  1. Nyah 上の VM でアプリケーションを動かす (trasfer)
  1. 役割ごとに VM を分割し、耐障害性を向上させる (high availability)

ここから、各ステップの課題を説明していきます。

### ステップ1. manual install

Rails Tutorial ではアプリケーションを動かす環境に Heroku を利用していましたが、このステップでは、Rails アプリを Vagrant 上の CentOS 7 で動かせるようにすることが課題です。

Rails アプリを動かすためのミドルウェアについて学ぶこと、それらをどう機能（連携）させるのかを理解すること、また Linux (CentOS) に挑んでもらうことを目的としています。

（実際はもっと細かく多いですが）以下のような作業内容を想定しています。

- Rails アプリを MariaDB, Unicorn に対応させる (Heroku では PostgreSQL, Puma だった)
- MariaDB をインストールする
- Nginx をインストールする
- Ruby 2.2 をインストールする
- Rails アプリケーションを設置する
- systemd で各種ミドルウェア、アプリケーションをサービスとして動作させる

Linux や [Vagrant](https://www.vagrantup.com/)、[FHS](http://www.pathname.com/fhs/pub/fhs-2.3.html)、パーミッション、所有者・グループ、ファイアウォール、リポジトリ、systemd、データベース、Web サーバ、UNIX ドメインソケット、...
若干盛り込み過ぎに見えなくもないですが、後続のステップでも繰り返し復習しますので、ステップごとに内容の理解を深めていってもらいたいと考えています。

### ステップ2. test

manual install のステップで Rails アプリを動かすサーバの構成が出来ましたが、それらが正しく動いていることを保証するテストは重要です。

そこでこのステップでは、[Serverspec](http://serverspec.org), [Infrataster](https://github.com/ryotarai/infrataster) を使ってサーバテストを導入していきます。
（ただしメインは Serverspec で、Infrataster は余裕のある場合のエクストラ課題という位置づけにしています。）

[![](https://avatars2.githubusercontent.com/u/3970679?s=400)](https://github.com/serverspec/serverspec)

manual install でインストールしたパッケージ、変更した設定ファイル、有効化したサービス、自動起動の設定、ポートのリスン、アクセス権（パーミッションや所有者・グループ）など、ステップ1で実施した内容のテストをザッと書いてもらいます。

なお、研修ではこのタイミングで2人1組のチームを組んでもらい、「どのようなテストを書けばよいのか」についてはチームで話し合って決めてもらいます。

### ステップ3. infra as code

サーバテストを導入した次のステップでは、構成管理ツールを導入し、インフラのコード化を課題としています。
構成管理ツールには[@ryot_a_rai](https://twitter.com/ryot_a_rai)君が作っている [Itamae](https://github.com/itamae-kitchen/itamae) を採用しました。

[![](/images/2015/07/21/itamae.png)](https://github.com/itamae-kitchen/itamae)  
*正式なロゴらしいです*

「ステップ2で書いたテストが十分であれば、それをそのままコード化すれば『動く』だろう」という前提で挑んでもらいますが、実際にそうなることは難しいでしょう。
manual install の内容をキチンとテストに落とし込めていたかどうか、足りないとすればそれは何だったのか、これまでにやった内容を反復していくことで、

### ステップ4. transfer

Nyah 上の VM でアプリケーションを動かす。

1. Nyah の VM を1個作る
1. Itamae でサーバ構築
1. テストをオールグリーンにする

### 5. high availability

役割ごとに VM を分割し、耐障害性を向上させる。

プロダクション環境における「High」には到底及ばないものの、「可用性」を求めるとはどういうことか、という理解を深めていってもらうのがこの研修の目的です。

なお、スライド公開時とは内容が多少異なっていますので、その点も合わせて説明します。

#### 5.1 app/dbを分離

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

### 5.2 dbの冗長化

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

### 5.4 ストレージの分離

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

- [WebオペレーションのVagrant編 ログ · Issue #29 · orzup/rails-tutorial](https://github.com/orzup/rails-tutorial/issues/29)

### ボスケテについて

スライド中では特に説明もなく使用していたのですが、「ボスケテ」は漫画『セクシーコマンドー外伝　すごいよ!!マサルさん』が元ネタです。
「助けて」よりも語感がカジュアルで、コミュニケーションや困ってることを共有するのに便利です。

元々このフレーズは [@ume3_](https://twitter.com/ume3_) さんのいるチームが、チームビルディングにおいて使い始めました。
入社したばかりのスタッフでも、緊張せずカジュアルに質問できるような環境づくりや、

<iframe src="//www.slideshare.net/slideshow/embed_code/key/2apyPGVBKVbPUU?startSlide=19" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ume3_/20140805-teambuilding-reportsabaten" title="インフラで実践したチームビルディングそれはサバ天" target="_blank">インフラで実践したチームビルディングそれはサバ天</a> </strong> from <strong><a href="//www.slideshare.net/ume3_" target="_blank">ume3_</a></strong> </div>


[^1]: https://www.gmo.jp/news/article/?id=3972
