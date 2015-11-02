---
date: 2015-11-02T09:00:00+09:00
title: ペパボ新卒エンジニア研修2015・サイクルOJTが始まっています
cover: /images/2015/11/02/cycle-ojt.png
draft: true
tags:
- pepabo
---
2015年6月から始まったペパボ新卒エンジニア研修も約4ヶ月が過ぎ、ついに「基礎研修」が終わりました:

- [ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)
- [ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています](/2015/07/20/pepabo-web-operation-training-2015/)
- [ペパボ新卒エンジニア研修2015・モバイルアプリ研修が始まっています](/2015/08/18/pepabo-mobile-app-training-2015/)

基礎研修は「Web開発」「Webオペレーション」「**モバイルアプリ**」の3つのテーマから成る研修です。
3つの研修の最後には「**お産ウィーク**」という「新卒エンジニアと新卒デザイナが、1週間でWebサービスを協働開発する」研修が行われました。

そして10/5(月)からは、12月までの後半戦である「**サイクルOJT**」が始まっています。

今回は、モバイルアプリ研修、お産ウィーク、そしてサイクルOJTの話をしようと思います。

モバイルアプリ研修の歩み
---

### どんなゴールだったか

モバイルアプリ研修では、2つのステップを用意しました:

1. Rails をバックエンドとしたモバイルアプリの開発
  - バックエンドとなる Rails は、 Web 開発研修で作成した Twitter 風アプリケーション
  - インフラは、Webオペレーション研修で構築したサーバ群
1. 1で開発したモバイルアプリを土台として、1つ以上の「ユーザ体験」をつくる

また、この研修では3人1組のチームを導入しました。
Web開発研修が1人、Webオペレーション研修が2人1組でしたが、メンバーが3人以上になると「チームで問題にどう立ち向かうべきか」という要素が強化されると思います。

この研修では、「どのようなゴールを設定するか」も含めて彼ら自身にデザインしてもらいます。
ライブラリ選定であったり、API 設計であったり、あるいは UI/UX など、これまで以上に頭と手を動かさなければ課題の達成は困難でしょう。

しかし、Web開発研修とWebオペレーション研修での様子から、不可能な課題ではないと確信しています。

### 1st stage: Rails をバックエンドとしたモバイルアプリの開発


1st stage では、Web開発研修でつくったRailsアプリをバックエンドとして、Webオペレーション研修で構築したサーバをインフラとして、つまり、これまでの研修で築いてきたものの上で動作するモバイルアプリの開発を目的としています。
![](/images/2015/08/18/1st_stage.png)

実際に開発を行うリポジトリは、以下の2つになります。
始まったばかりですのでまだコードは育っていないかもしれませんが、この一ヶ月でどのような成長を遂げていくのか、見ていただけると幸いです。

- https://github.com/pepabo/railstutorial-ios
- https://github.com/pepabo/railstutorial-android

### 2nd stage: 1つ以上の『ユーザ体験』をつくる

2nd stage は更に抽象的なゴールとなっています。

1st stage で開発したモバイルアプリのうえに、「『ユーザ体験』とはなにか」をチームで考えてもらいます。
そして、リーンキャンバス、インセプションデッキといったプラクティスを活用しながら、「これだ」と定めたソフトウェアを開発していってもらう、という流れを想定しています。

### 「スクラム実践入門」読書会

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank"><img src="http://ecx.images-amazon.com/images/I/51ABflXRwZL.jpg" alt="スクラム実践入門 ── 成果を生み出すアジャイルな開発プロセス (WEB+DB PRESS plus)" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank">スクラム実践入門 ── 成果を生み出すアジャイルな開発プロセス (WEB+DB PRESS plus)</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 15.10.11</div></div><div class="amazlet-detail">貝瀬 岳志 原田 勝信 和島 史典 栗林 健太郎 柴田 博志 家永 英治 <br />技術評論社 <br />売り上げランキング: 92,564<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>

### 結果

結末からいうと、1チームはゴールしましたが、片方のチームは2つ目のステップには辿りつけませんでした。

### モバイルアプリ研修のふりかえり (KPT) の様子

モバイルアプリ研修最終日には、各チームでふりかえり (KPT) を行ってもらいました。

[![](/images/2015/08/18/kpt01_large.jpg)](/images/2015/08/18/kpt01_full.jpg)
*ふりかえり (KPT) の様子*

[![](/images/2015/08/18/kpt02_large.jpg)](/images/2015/08/18/kpt02_full.jpg)
*Try が出せなくて議論している様子*

[![](/images/2015/08/18/kpt03_large.jpg)](/images/2015/08/18/kpt03_full.jpg)
*Webオペレーション研修の KPT*

### ホワイトボードで毎日の進捗確認

Webオペレーション研修を経て、完成（？）したホワイトボードがこちら。

[![](/images/2015/08/18/kanban_large.jpg)](/images/2015/08/18/kanban_full.jpg)
*段々とキャラクタが増えています。あと、黄緑色の付箋は、おかわり課題として用意していたものです*

お産ウィーク
---

お産ウィークは、「1週間でWebサービスを作る」という研修です。
名前の由来は、ペパボで毎年開催されている「お産合宿」という一泊二日の開発合宿です。


サイクルOJT
---

![](/images/2015/10/13/cycle-ojt.png)

さて、先週10/5(月)からサイクルOJTが始まりました。

サイクルOJTは、6つのサービス・事業部で行うOJTで

おわりに
---

Web開発、Webオペレーションと続いた基礎研修も、いよいよ後半戦になりました。
これまで以上に大変な課題ですが、これまで以上の成果を期待しています。

研修の様子は引き続き報告していきたいと思いますので、ご期待ください！
