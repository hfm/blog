---
date: 2015-07-20T14:32:49+09:00
title: ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています
tags:
- pepabo
---
「[ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)」にも書いたとおり、先月の6/8からペパボ新卒エンジニア研修がスタートしています。

そして 7/3(金) に、約4週間続いた[Web開発研修](http://www.slideshare.net/hifumis/20150609-webdevelopmenttraining)がゴールを迎え、翌週 7/6(月) から新たにWebオペレーション研修が幕を開けました。

今回は、Web開発研修をどのように進めていったかと、Webオペレーション研修の話をしようと思います。

Web開発研修
---

### どのような進め方だったか

Web開発研修では、[Ruby on Rails Tutorial (en)](https://www.railstutorial.org) を、概ね以下のようなやり方で進めてもらいました。

1. [github.com](https://github.com/) にリポジトリを作る
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

Exerices では PR を作り、ピアレビューを実践してもらいました。
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

[![](/images/2015/07/20/kanban_large.jpg)](/images/2015/07/20/kanban_full.jpg)
*当初の見積りと計画からズレを感じる度に再見積りをしたり、再計画をしたり、付箋を足していった結果*

マグネットやシールなど、賑やかになっている様子が伺えます。
守り神も居られます。

### Web開発研修のふりかえり (KPT) の様子

7/3 のWeb開発研修最終日には、みんなでこの4週間のふりかえり (KPT) を行いました。

[![](/images/2015/07/20/kpt01_large.jpg)](/images/2015/07/20/kpt01_full.jpg)
*「放送室」と呼ばれる会議室にて、この4週間のふりかえりをしている様子*

[![](/images/2015/07/20/kpt02_large.jpg)](/images/2015/07/20/kpt02_full.jpg)
*若干見づらいですが、Web開発研修の KPT です（一部モザイクをかけています）*

色々なテーマが出ましたが、「ピアレビュー」「体調管理」「時間管理」「ボスケテ（後述）」あたりが特に大きいでしょうか。
研修の始めの頃はみんな集中して取り組むのですが、集中しすぎて疲れてしまい、1週間のペース配分がうまくいかない大変さがあったようです。

リフレッシュタスクを作ってみるなり、GMOインターネットグループでも推奨されているシエスタ[^1]を実施してみるなど、時間と体調を管理することについてアレコレ議論していました。

ちなみに Try の一番下に「Rails Tutorial を完走しよう」と書かれているのは私のことです...
アレコレ仕事してたら全然進められなかったので、なんとか終わらせようと思います（とはいえ、2年前の新卒時代と、去年の新卒研修でもやったので、都合3回目。）

### ボスケテについて

「ボスケテ」は漫画『セクシーコマンドー外伝　すごいよ!!マサルさん』が元ネタです。
「助けて」よりも語感がカジュアルで、コミュニケーションや困ってることを共有するのに便利です。

元々このフレーズは [@ume3_](https://twitter.com/ume3_) さんのいるチームが、チームビルディングにおいて使い始めました。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/2apyPGVBKVbPUU?startSlide=19" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ume3_/20140805-teambuilding-reportsabaten" title="インフラで実践したチームビルディングそれはサバ天" target="_blank">インフラで実践したチームビルディングそれはサバ天</a> </strong> from <strong><a href="//www.slideshare.net/ume3_" target="_blank">ume3_</a></strong> </div>

Webオペレーション研修イントロダクション
---

さて、7/6 からは新たにWebオペレーション研修が始まりました。
初日はイントロダクションとして、Webオペレーション研修やゴールや進め方についてお話させていただきました。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/oyv7b8dDabkH9" width="714" height="440" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hifumis/20150706-weboperationtraining" title="2015年GMOペパボ新卒エンジニア研修 Webオペレーション研修イントロダクション" target="_blank">2015年GMOペパボ新卒エンジニア研修 Webオペレーション研修イントロダクション</a> </strong> from <strong><a href="//www.slideshare.net/hifumis" target="_blank">Takahiro Okumura</a></strong> </div>

新卒の[@orzup](https://twitter.com/orzup)が研修のログを残してくれていますので、当人たちがどのように取り組んでいるのかを知るには以下をご覧ください。

- [WebオペレーションのVagrant編 ログ · Issue #29 · orzup/rails-tutorial](https://github.com/orzup/rails-tutorial/issues/29)

Webオペレーション研修のゴール
---

「アプリが『動く』インフラを、ステップ・バイ・ステップで成長させる」ことをゴールとして、5つのステップを設けました。

![](/images/2015/07/20/goal.png)
*Vagrant編・Nyah編（後述）、合わせて5つのステップ*

各ステップの課題は以下のとおりです。

- Vagrant編
  1. Web開発研修で作成した Rails アプリを、Vagrant で動かす (manual install)
  1. Serverspec, Infrataster などでサーバの構成・振る舞いをテストする (test)
  1. Itamaeでサーバ構成をコード化する (infra as code)
- Nyah編
  1. Nyah 上のインスタンスで Rails アプリケーションを動かす (trasfer)
  1. 役割ごとにインスタンスを分割し、耐障害性を向上させる (high availability)

また、この研修ではチーム制を導入しており、**test** のステップから2人1組のチームを結成して課題に取り組んでもらっています。

### ステップ1. manual install

Rails Tutorial ではアプリケーションを動かす環境に Heroku を利用していましたが、このステップでは、Rails アプリを Vagrant 上の CentOS 7 で動かせるようにすることが課題です。

[![](/images/2015/07/20/vagrant.png)](https://www.vagrantup.com/)

Rails アプリに必要なミドルウェアやそれらの機能を学ぶこと、また Linux に挑んでもらうことを目的としています。

（実際はもっと細かく多いですが）以下のような作業内容を想定しています。

- Rails アプリを MariaDB, Unicorn に対応させる (Heroku では PostgreSQL, Puma だった)
- MariaDB をインストールする
- Nginx をインストールする
- Ruby 2.2 をインストールする
- Rails アプリを設置する
- systemd で各種ミドルウェア、Rails アプリをサービスとして動作させる

Linux や [Vagrant](https://www.vagrantup.com/)、[FHS](http://www.pathname.com/fhs/pub/fhs-2.3.html)、パーミッション、所有者・グループ、ファイアウォール、リポジトリ、systemd、データベース、Web サーバ、UNIX ドメインソケット、...
若干盛り込み過ぎに見えなくもないですが、続くステップで繰り返し復習し、段々と理解を深めていってもらいたいと考えています。

### ステップ2. test

先のステップで構築した Rails アプリサーバが、意図通り動いていることを保証するテストは重要です。

そこでこのステップでは、[Serverspec](http://serverspec.org), [Infrataster](https://github.com/ryotarai/infrataster) を使ってサーバテストを導入していきます。
（ただし、Infrataster は余裕のある場合のおかわり課題という位置づけです。）

[![](https://avatars2.githubusercontent.com/u/3970679?s=400)](https://github.com/serverspec/serverspec)

manual install でインストールしたパッケージ、変更した設定ファイル、有効化したサービス、自動起動の設定、ポートのリスン、アクセス権（パーミッションや所有者・グループ）など、ステップ1で実施した内容のテストをザッと書いてもらいます。

なお、研修ではこのタイミングで2人1組のチームを組んでもらい、「どのようなテストを書けばよいのか」についてはチームで話し合って決めてもらいます。
ただし、この段階ではあまり時間をかけず、続く infra as code のステップで更にテストを内容を充実させていってもらいます。

### ステップ3. infra as code

サーバテストを導入した次のステップでは、構成管理ツールを導入し、インフラのコード化を課題としています。
構成管理ツールには[@ryot_a_rai](https://twitter.com/ryot_a_rai)君の OSS プロダクトである [Itamae](https://github.com/itamae-kitchen/itamae) を採用しました。

[![](/images/2015/07/20/itamae.png)](https://github.com/itamae-kitchen/itamae)  
*正式なロゴらしいです*

このステップでは、主に以下の様な作業内容を想定しています。

1. ステップ2で書いたテストをもとに、manual installの手順を Itamae でコード化する
2. 新規 VM に Itamae レシピを適用する
3. Serverspec でテストが全て通ること、Rails アプリが動くことを確認する

このステップでは、これまでにやった内容の復習も兼ねており、manual install の内容を十分とテストに落とし込めていたかどうか、足りないとすればそれは何だったのか等を確認していってもらいます。

### ステップ4. transfer

さて、ここからは後半の Nyah 編です。

Nyah は OpenStack ベースのペパボの仮想インフラ基盤で、AWS のように任意のタイミングで必要なリソースを持つサーバを簡単に作成することができます。

![](/images/2015/07/20/nyah.png)  
*Nyah のロゴです。[suzuri にもあるよ](https://suzuri.jp/search?q=nyah)*

Nyah に関する更なる詳細は以下のスライドをご覧ください。

- [Nyah ポチポチするために ニャーニャーしよう #pbtech](http://www.slideshare.net/ume3_/pb-tc01-bob001)
- [ペパボにおけるOpenStackHacks! 〜僕と夏を一緒にトゥギャザーしま専科！！ 編〜](https://speakerdeck.com/pyama86/pepaboniokeruopenstackhacks)

このステップでは Nyah にインスタンスを作成し、そこで Rails アプリを動かすことが課題です。
OpenStack のセキュリティグループや鍵管理、インスタンスの扱いなど、Nyah (OpenStack) のアーキテクチャ、コンポーネントを知ってもらうことも目的の1つです。

### 5. high availability

ここまでのステップでは、1つのサーバの中に複数のコンポーネントが同居していました。
可用性を考えると、このようなリソースを喰い合うサーバ構成は好ましくありません。

そこでこのステップでは、役割ごとにインスタンスを用意し、連携させ、（厳密には「High」までいかないものの、）可用性を図ることを課題としています。
ネットワークアクセス可能なサービス単位でシステムを分割[^2]していく中で、個々のミドルウェアの理解を深めてもらうことが目的の1つです。

※なお、スライド公開時とは内容が多少異なっていますので、その点も合わせて説明します。

#### 5.1 app/dbを分離

このサブステップでは、 app (+ web) と db の2つの役割に分割します。

```
      +-----+
      | app |
      +-----+
         |
      +-----+
      | db  |
      +-----+
```

### 5.2 dbの冗長化

このサブステップでは、db のレプリケーション（Master/Slave 構成）を作成します。

```
      +-----+
      | app |
      +-----+
         |
    +--------+   +---------+
    | master |---| replica |
    +--------+   +---------+
```

### 5.3 リバースプロキシの導入

このサブステップでは、（ネットワーク的な意味で）app サーバの前にリバースプロキシを設置します。
（5.3と5.4のサブステップは、前後を入れ替えても特に問題はありません。）

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

### 5.4 ストレージの分離

このサブステップでは、app サーバからストレージサーバを分離します。
（これはスライドには無く、途中で追加されたものです）

Rails Tutorial で導入した [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) を介して、Rails アプリに POST されたメディアデータをストレージサーバに保存出来るようにします。
ペパボにはレンタルサーバ[^3]や写真保存サービス[^4]もあるので、イチからストレージサーバを構築してもらうことは想定していません。

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

※ Rails Tutorial では S3 を利用していますが、ローカル保存に変更してもらっていました。

### 5.5 app の冗長化

複数台の app サーバを用意し、 reverse proxy でアクセスを振り分けます。

5.4 でストレージサーバを分離させたのは、このサブステップでストレージを共有化させる必要があるからです。

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

このサブステップでは、セッションサーバを用意して、セッション情報を共有します。
ただしこれは、ここまでのステップが全て完了した人へのおかわり課題です。

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

おわりに
---

Webオペレーション研修が始まって2週間が過ぎ、いよいよ明日から後半戦がスタートします。
この2週間でステップ3まで完了し、次からは Nyah 編に突入し、残り3週間でステップ4と5を進めていきます。

暑い時期が続きますが、夏の気温に負けないように100倍でバリュー出していくぞ!!1

<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-version="4" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:8px;"> <div style=" background:#F8F8F8; line-height:0; margin-top:40px; padding:50% 0; text-align:center; width:100%;"> <div style=" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAAGFBMVEUiIiI9PT0eHh4gIB4hIBkcHBwcHBwcHBydr+JQAAAACHRSTlMABA4YHyQsM5jtaMwAAADfSURBVDjL7ZVBEgMhCAQBAf//42xcNbpAqakcM0ftUmFAAIBE81IqBJdS3lS6zs3bIpB9WED3YYXFPmHRfT8sgyrCP1x8uEUxLMzNWElFOYCV6mHWWwMzdPEKHlhLw7NWJqkHc4uIZphavDzA2JPzUDsBZziNae2S6owH8xPmX8G7zzgKEOPUoYHvGz1TBCxMkd3kwNVbU0gKHkx+iZILf77IofhrY1nYFnB/lQPb79drWOyJVa/DAvg9B/rLB4cC+Nqgdz/TvBbBnr6GBReqn/nRmDgaQEej7WhonozjF+Y2I/fZou/qAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;"></div></div> <p style=" margin:8px 0 0 0; padding:0 4px;"> <a href="https://instagram.com/p/4rNIHOEvEz/" style=" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;" target="_top">100倍だ!!1</a></p> <p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;">A photo posted by Takahiro Okumura (@hfm) on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2015-07-03T13:07:08+00:00">Jul 3, 2015 at 6:07am PDT</time></p></div></blockquote>
<script async defer src="//platform.instagram.com/en_US/embeds.js"></script>

求人
---

ペパボでは2016年4月に入社していただく新卒エンジニアの募集を行っています。
ご興味あるかたは是非 ;-)

[![](/images/2015/07/20/team.jpg)](https://www.wantedly.com/projects/25397)
*[未来のトップエンジニアを大募集！技術力で世界をもっとおもしろくしよう - GMOペパボ株式会社の求人 - Wantedly](https://www.wantedly.com/projects/25397)*

[^1]: https://www.gmo.jp/news/article/?id=3972
[^2]: Web Operations: Chapter.5 Infrastructure As Code
[^3]: http://lolipop.jp/, http://heteml.jp/
[^4]: https://30d.jp/
