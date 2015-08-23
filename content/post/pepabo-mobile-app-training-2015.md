---
date: 2015-08-18T14:00:00+09:00
title: ペパボ新卒エンジニア研修2015・モバイルアプリ研修が始まっています
cover: /images/2015/07/20/team.jpg
tags:
- pepabo
---
いま、ペパボでは新卒エンジニア研修2015を実施しています。
期間は6月から年末までの約7ヶ月間で、前半4ヶ月を「基礎研修」、後半3ヶ月を「サイクルOJT」と称しています。

6/8〜7/3は、[Rails Tutorial](https://www.railstutorial.org/book) を教材とした**Web開発研修**が行われました。
7/6〜8/7は、OpenStack[^1] 上で Rails を動かすための、インフラの設計・構築・運用を軸とした**Webオペレーション研修**が行われました。

- [ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)
- [ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています](/2015/07/20/pepabo-web-operation-training-2015/)

そして昨日8/17から、基礎研修の第三幕『モバイルアプリ研修』が始まりました。
そこで今回は、Webオペレーション研修の完遂に至るまでの話と、モバイルアプリ研修の話をしようと思います。

Webオペレーション研修の歩み
---

### どんなゴールだったか

Webオペレーション研修では、**「アプリが『動く』インフラを、ステップ・バイ・ステップで成長させる」**ために、5つのステップで進めてもらいました。

1. 【Vagrant編】Web開発研修の Rails アプリの動く環境を Vagrant (CentOS 7) 上で手動作成
1. 【Vagrant編】Serverspec, Infrataster によるサーバテスト
1. 【Vagrant編】Itamaeによるサーバ構成管理化
1. 【Nyah編】Nyah (ペパボのOpenStack) に移行
1. 【Nyah編】役割ごとにインスタンスの分割、可用性の向上

最後のステップでは、アプリケーションサーバとデータベースサーバの分離、データベースのレプリケーション、リバースプロキシの導入、ストレージサーバの分離、アプリケーションサーバの冗長化などを目指してもらいました。

また、この研修では2人1組のチームを導入し、相談しながら進めてもらうようにしました。

### 全チームがゴールに辿りつけたのか？

結末からいうと、2チームはゴールしましたが、残りの1チームは道半ばで時間切れとなってしまいました。
時間切れとなったチームは、アプリケーションサーバの冗長化以外は構築出来たのですが、ストレージサーバが一度憤死（少し調査手伝ったけど何故死んだのか未だにわからない）するなどのトラブルに見舞われたりと、一筋縄ではいかない事情があったようです。

#### どのあたりに苦労していた？

全体的に大変そうだったというのが正直な感想ですが、研修前半では、パーミッションやアクセス権に関して苦労している人は数名いるようでした。
また filewalld に苦戦した人もいて、研修の最後の方になると、 `filewall-cmd --permanent --add-service ...` みたいな長ったらしいコマンドをそらで打てるようになってました（成長？）。

他には、ストレージサーバを構築するにあたって、何故か全チームが NFS を選んでいました。
結果、この後のふりかえりにも「NFS の闇」と登場してしまったあたり、なにかしらのつらい事情を知ってしまったんだと思います。

あと、reverse proxy 導入時に、 assets などの静的コンテンツをどうやって返せばいいのか、という議論がありました。
最終的には、静的コンテンツを配信する **static-web サーバ** を構築することになったようですが、その構成にはチームごとに微妙な差がありました。

一方では、以下のようにリバースプロキシの後ろにぶら下がっている場合：

![](/images/2015/08/18/diagram01.png)

他には、[AssetUrlHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetUrlHelper.html) の導入まではいかないものの、Rails 側を多少ゴニョゴニョして、グローバル IP のついた static-web サーバに振り分けている場合：

![](/images/2015/08/18/diagram02.png)

約一ヶ月という短い期間ながらも、それぞれ頭を悩ませ、良い構成にするべく様々な挑戦を試みていました。

#### 課題を越えてチャレンジしていたこと

最後のステップは、およそ2週間ほどの期間で取り組んでいました。
その取り組みのなかで、課題を越えて、以下のような技術にチャレンジしているチームもありました。

- Rakeタスクによるオペレーションタスクの自動化（抽象化）
- [Capistrano](https://github.com/capistrano/capistrano) の導入
- [winebarrel/gratan](https://github.com/winebarrel/gratan) によるユーザ情報のコード管理化
- [Terraform](https://www.terraform.io/)によるリソースのコード管理化
- （ストレージサーバとして）[Riak](http://basho.co.jp/riak/) の検証
- Serfを使った `/etc/hosts`や nginx upstreamの自動更新

OpenStack を Terraform で管理するなど、チャレンジ精神があふれていて大変素晴らしいです。

### Webオペレーション研修のふりかえり (KPT) の様子

Webオペレーション研修最終日には、みんなでふりかえり (KPT) を行いました。

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

モバイルアプリ研修イントロダクション
---

さて、昨日8月17日から新たにモバイルアプリ研修が始まりました。
初日はイントロダクションとして、研修のゴールや進め方についてお話させていただきました。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/elzOa0O9nIUagY" width="714" height="440" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hifumis/20150817-mobileapp-training" title="2015年GMOペパボ新卒エンジニア研修 モバイルアプリ研修イントロダクション" target="_blank">2015年GMOペパボ新卒エンジニア研修 モバイルアプリ研修イントロダクション</a> </strong> from <strong><a href="//www.slideshare.net/hifumis" target="_blank">Takahiro Okumura</a></strong> </div>

モバイルアプリ研修のゴール
---

この研修には大きく2つのゴールを設定しています。
1st stage は「Rails をバックエンドとしたモバイルアプリの開発」で、2nd stage は 「1つ以上の『ユーザ体験』をつくる」ことです。

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

チーム
---

Webオペレーション研修では2人1組でしたが、今回は iOS アプリを作るチームと Android アプリを作るチームになりました。

![](/images/2015/08/18/team.png)

チーム名も自分たちで考えてもらったんですが、それぞれ「ねはん」と「じょうど」になりました。
なぜそうなったのか、理由は深くは聞いていません。

研修の進め方
---

概ねスライド資料の通りですが、いくつか補足しておきます。

### ペーパープロトタイプ、遷移図

これらの重要性については、以下のスライド資料で説明されている内容が素晴らしいと思うので、こちらをお読み頂ければと思います。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/zSm32EjbPBQjRB" width="714" height="582" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/yutawariishi/ss-47974238" title="人と向き合うプロトタイピング" target="_blank">人と向き合うプロトタイピング</a> </strong> from <strong><a href="//www.slideshare.net/yutawariishi" target="_blank">wariemon</a></strong> </div>

プロトタイピングツールとしては、Prott と Prott note にしました。

- [Prott - Rapid prototyping tool. Now gets an app.](https://prottapp.com/)
- [Prott Blog - Prottノートを使ってプロトタイピング！](https://blog.prottapp.com/post/ja/prott-note)

また、ペーパープロトタイピングの進め方や筆記具は、弊社デザイナや以下のブログを参考にしました。

- [ペーパープロトタイピング入門 – 第2回 ペーパープロトタイピングに使う道具 | fladdict](http://fladdict.net/blog/2013/12/paper-prototyping-2.html)

### ユーザテスト

今回の研修では、それぞれのチームが約一ヶ月間、いっしょに開発をします。
一方で、チームが完全に分かれてしまっているため、お互いの進捗が見えづらくなったり、コミュニケーションが減ってしまうのはもったいないと考えました。

そこで、互いのチームが互いのプロダクトのユーザになりきるユーザテストを導入し、「適切なフィードバックを送る」という要素を取り入れることにしました。

### リーンキャンバス、インセプションデッキ、レビュー

ペパボでは、ソフトウェア開発の際にリーンキャンバスとインセプションデッキを活用しています。
そこで、新卒研修においてもソフトウェア開発プロセスはしっかりとフォローした方がいいと判断し、このモバイルアプリ研修での導入を決定しました。

リーンキャンバスは [demi168/Lean-Canvas-prototype-PDF](https://github.com/demi168/Lean-Canvas-prototype-PDF) を、インセプションデッキは [agile-samurai-ja/support](https://github.com/agile-samurai-ja/support) のテンプレートを使う予定です。

また、実際に作ってみるだけではなく、弊社チーフエンジニアである [@hsbtさん](https://twitter.com/hsbt) にレビューしていただくことで、経験値の蓄積と品質の向上を目指しています。

### 実際のチーム開発の様子

モバイルアプリ研修初日の様子です。
『ねはん』と『じょうど』それぞれのチームがミーティングを行い、タスクの洗い出しやサービス分析などを行っています。

[![](/images/2015/08/18/team_nehan_large.jpg)](/images/2015/08/18/team_nehan_full.jpg)
*ねはんチームのMTGの様子*

[![](/images/2015/08/18/team_jodo_large.jpg)](/images/2015/08/18/team_jodo_full.jpg)
*じょうどチームのMTGの様子*

カンバンも生まれ変わりました。

[![](/images/2015/08/18/mobileapp_kanban_large.jpg)](/images/2015/08/18/mobileapp_kanban_full.jpg)
*始まったばかりのカンバン。上半分がじょうどチーム、下半分がねはんチームの領域です*

多分「TODO」「DOING」「DONE」的なことだと思うんですが、フレーズにも遊び心を持ち込もうとしており、傍から見ると宗教観満載になっています。
完了したタスクはもれなく「浄土」と「涅槃」に送られていくようです。
すごい世界だ。

おわりに
---

Web開発、Webオペレーションと続いた基礎研修も、いよいよ後半戦になりました。
これまで以上に大変な課題ですが、これまで以上の成果を期待しています。

研修の様子は引き続き報告していきたいと思いますので、ご期待ください！

求人
---

ペパボでは2016年4月に入社していただく新卒エンジニアの募集を行っています。
ご興味あるかたは是非 ;-)

[GMOペパボ株式会社の説明会、セミナー｜リクナビ2016｜学生のための就職情報サイト](https://job.rikunabi.com/2016/company/seminar/r240020045/C007/)

[^1]: http://www.slideshare.net/ume3_/pb-tc01-bob001
