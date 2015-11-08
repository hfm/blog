---
date: 2015-11-09T09:00:00+09:00
title: ペパボ新卒エンジニア研修2015・サイクルOJTが始まっています
cover: /images/2015/11/09/cycle-ojt.png
draft: true
tags:
- pepabo
---
2015年6月から始まったペパボ新卒エンジニア研修のうち、ついに「基礎研修」が終わりました。
基礎研修は「Web開発」「Webオペレーション」「モバイルアプリ」の3つのテーマから成る研修です。

- [ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)
- [ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています](/2015/07/20/pepabo-web-operation-training-2015/)
- [ペパボ新卒エンジニア研修2015・モバイルアプリ研修が始まっています](/2015/08/18/pepabo-mobile-app-training-2015/)

3つの研修の最後には「**お産ウィーク**」という「新卒エンジニアと新卒デザイナが、1週間でWebサービスを協働開発する」研修が行われました。
そして10/5(月)からは、12月までの後半戦である「**サイクルOJT**」が始まっています。

サイクルOJTの開始からひと月ほど経ってしまいましたが、今回は、モバイルアプリ研修、お産ウィーク、そしてサイクルOJTの話をしようと思います。

モバイルアプリ研修の歩み
---

### どんなゴールだったか

今年の新卒エンジニアは6人いるので、3人1組のチームとし、次の2つを課題として用意しました。

1. Web開発研修で作った Rails アプリをバックエンドとしたモバイルアプリの開発
1. 1で開発したモバイルアプリを土台にして、1つ以上の「ユーザ体験」をつくる

過去に実施されたWeb開発研修とWebオペレーションに比べて、抽象性が増し、難易度の高い課題になっています。
タスクの分解や役割分担も仕事では大切と思い、このような内容にしました。

### アプリのOSとチームについて

6人の所持しているモバイル端末が iOS と Android で半々だったので、片方のチームには iOS アプリを、もう片方には Android アプリを開発してもらいました。
（なぜか）iOS アプリのチームは「ねはん」、Android は「じょうど」というチーム名になりました。
リポジトリは以下で公開されています。

- https://github.com/pepabo/railstutorial-ios
- https://github.com/pepabo/railstutorial-android

### 1st stage: Rails をバックエンドとしたモバイルアプリの開発

1st stage はこれまでの研修で築いてきたものを活用し、モバイルアプリの開発を目的としています。
具体的には、以下のような条件です。

- バックエンドとなる Rails は、 Web 開発研修で作成した Twitter 風アプリケーションが
- インフラは、Webオペレーション研修で構築したサーバ群

[![](/images/2015/11/09/mobileapp1_large.jpg)](/images/2015/11/09/mobileapp1_full.jpg)
[![](/images/2015/11/09/mobileapp2_large.jpg)](/images/2015/11/09/mobileapp2_full.jpg)
*ねはん、じょうどのチームがAPIの設計について議論している様子*

[![](/images/2015/11/09/mobileapp3_large.jpg)](/images/2015/11/09/mobileapp3_full.jpg)
*行き詰まったところをフォローする先輩エンジニア*

### 2nd stage: 1つ以上の『ユーザ体験』をつくる

2nd stage は更に抽象的なゴールとなっています。

1st stage で開発したモバイルアプリのうえに、「『ユーザ体験』とはなにか」をチームで考えてもらいます。
そして、リーンキャンバス、インセプションデッキといったプラクティスを活用しながら、「これだ」と定めたソフトウェアを開発していってもらう、という流れを想定しています。

### 「スクラム実践入門」読書会

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank"><img src="http://ecx.images-amazon.com/images/I/51ABflXRwZL.jpg" alt="スクラム実践入門 ── 成果を生み出すアジャイルな開発プロセス (WEB+DB PRESS plus)" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank">スクラム実践入門 ── 成果を生み出すアジャイルな開発プロセス (WEB+DB PRESS plus)</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 15.10.11</div></div><div class="amazlet-detail">貝瀬 岳志 原田 勝信 和島 史典 栗林 健太郎 柴田 博志 家永 英治 <br />技術評論社 <br />売り上げランキング: 92,564<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>

### 結果

結末からいうと、1チームはゴールしましたが、片方のチームは2nd stageには辿りつけませんでした。

Web開発研修が1人、Webオペレーション研修が2人1組でしたが、メンバーが3人以上になると「チームで問題にどう立ち向かうべきか」という要素が強化されると思います。

この研修では、「どのようなゴールを設定するか」も含めて彼ら自身にデザインしてもらいます。
ライブラリ選定であったり、API 設計であったり、あるいは UI/UX など、これまで以上に頭と手を動かさなければ課題の達成は困難でしょう。

しかし、Web開発研修とWebオペレーション研修での様子から、不可能な課題ではないと確信しています。

### モバイルアプリ研修のふりかえり (KPT) の様子

モバイルアプリ研修最終日には、各チームでふりかえり (KPT) を行ってもらいました。

[![](/images/2015/11/09/mobileapp4_large.jpg)](/images/2015/11/09/mobileapp4_full.jpg)
*各チームのふりかえり (KPT)*

お産ウィーク
---

お産ウィークは、「**1週間でWebサービスを作る**」という研修です。
名前の由来は、ペパボで毎年開催されている「お産合宿」という一泊二日の開発合宿です。

新卒エンジニアと新卒デザイナが4人1組のチームを2組結成し、1週間（営業日だと5日）で Web サービスをつく
また、最終日には作成したWebサービスの発表とデモを行ってもらいました。

[![](/images/2015/11/09/osanweek1_large.jpg)](/images/2015/11/09/osanweek1_full.jpg)
*どんなWebサービスを作るか議論している様子*

[![](/images/2015/11/09/osanweek2_large.jpg)](/images/2015/11/09/osanweek2_full.jpg)
*設計について話し合いをしている様子*

[![](/images/2015/11/09/osanweek3_large.jpg)](/images/2015/11/09/osanweek3_full.jpg)
*デザイナの画面をみんなで観てる*

**チームでWebサービスを考え、作り、「大切にしてほしい3つのこと」を学ぶ**

1. Webサービス開発の第一歩 (Webサービスを考え、作る)
1. 異職種間でのコラボレーション（協働・協業）
1. 結果としての代名詞、ステップアップ

[リーンキャンバス](https://github.com/demi168/Lean-Canvas-prototype-PDF)

サイクルOJT
---

そして10/5(月)からは、6つのサービスを1週間ごとにぐるぐる廻る「**サイクルOJT**」が始まりました。
新卒エンジニアが1人1サービスで、1週間ごとにバリューを出してもらう、という取り組みになっています。

以下の1つの部署と5つのサービスで行われました。

1. 技術部
1. [PEPABO WiMAX](https://wimax.pepabo.com/)
1. [カラーミーショップ](http://shop-pro.jp/)
1. [SUZURI](https://suzuri.jp/)
1. [グーペ](http://goope.jp/)
1. [ブクログ](http://booklog.jp/)

[![](/images/2015/11/09/cycleojt1_large.jpg)](/images/2015/11/09/cycleojt1_full.jpg)
*[ブクログ](//booklog.jp/)OJT（新卒エンジニアの[すずぴー](//twitter.com/alotofwe)、エンジニアの[つっちー](//twitter.com/hika69)さん、デザイナの[白木](//twitter.com/meganejinkie)さん）*

[![](/images/2015/11/09/cycleojt2_large.jpg)](/images/2015/11/09/cycleojt2_full.jpg)
*技術部OJT（新卒エンジニアの[かすみん](//twitter.com/k_hanazuki)と[柴田さん](twitter.com/hsbt)）*

[![](/images/2015/11/09/cycleojt3_large.jpg)](/images/2015/11/09/cycleojt3_full.jpg)
*毎週金曜日の1週間の成果発表・引継ぎの様子*

おわりに
---

