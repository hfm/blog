---
date: 2015-11-16T09:00:00+09:00
title: ペパボ新卒エンジニア研修2015・サイクルOJTが（とっくに）始まっています
cover: /images/2015/11/16/cycle-ojt.png
tags:
- pepabo
---
2015年6月から始まったペパボ新卒エンジニア研修のうち、ついに「基礎研修」が完結しました。
基礎研修は「Web開発」「Webオペレーション」「**モバイルアプリ**」の3つのテーマから成る研修です。

- [ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)
- [ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています](/2015/07/20/pepabo-web-operation-training-2015/)
- [ペパボ新卒エンジニア研修2015・モバイルアプリ研修が始まっています](/2015/08/18/pepabo-mobile-app-training-2015/)

3つの研修の最後には、新卒エンジニアと新卒デザイナが、1週間でWebサービスを協働開発する「**お産ウィーク**」が行われました。
そして10月からは年末にかけては、6つのサービスを1週間ごとにぐるぐる廻る「**サイクルOJT**」が始まっています。

モバイルアプリ研修の歩み
---

iframe src="//www.slideshare.net/slideshow/embed_code/key/elzOa0O9nIUagY?startSlide=9" width="714" height="440" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hifumis/20150817-mobileapp-training" title="2015年GMOペパボ新卒エンジニア研修 モバイルアプリ研修イントロダクション" target="_blank">2015年GMOペパボ新卒エンジニア研修 モバイルアプリ研修イントロダクション</a> </strong> from <strong><a href="//www.slideshare.net/hifumis" target="_blank">Takahiro Okumura</a></strong> </div>

この研修では、6人いる新卒エンジニアから3人1組のチームを作り、2段階に分けて課題を用意しました。

また、6人の所持しているモバイル端末が iOS と Android で半々だったので、片方のチームには iOS アプリを、もう片方には Android アプリを開発してもらいました。
（なぜか）iOS アプリのチームは「ねはん」、Android は「じょうど」というチーム名になりました。
リポジトリは以下で公開されています。

- https://github.com/pepabo/railstutorial-ios
- https://github.com/pepabo/railstutorial-android

### 1st stage: Rails をバックエンドとしたモバイルアプリの開発

1st stage では以下のように、Web開発研修とWebオペレーションで作ってきたものが土台となっています。

- バックエンドとなる Rails は、 Web 開発研修で作成した Twitter 風アプリケーション
- インフラは、Webオペレーション研修で構築したサーバ群

Web開発研修で作った Twitter 風のアプリケーションの機能を、モバイルアプリ（ネイティブ）でも扱えるようにするというのがゴールです。
当然、API設計やUIデザインといった要素も必要になります。
加えてカンバンなどを用いたチーム開発プロセスにも取り組んでもらいました。

[![](/images/2015/11/16/mobileapp1_large.jpg)](/images/2015/11/16/mobileapp1_full.jpg)
*API設計について議論している様子*

[![](/images/2015/11/16/mobileapp2_large.jpg)](/images/2015/11/16/mobileapp2_full.jpg)
*行き詰まったところをフォローする先輩エンジニア*

### 2nd stage: 1つ以上の「ユーザ体験」をつくる

1st stage で開発したモバイルアプリのうえに、「新しい『ユーザ体験』」をつくってもらうことが 2nd stage のゴールです。

[リーンキャンバス](//github.com/demi168/Lean-Canvas-prototype-PDF)、[インセプションデッキ](//github.com/agile-samurai-ja/support/blob/master/blank-inception-deck/blank-inception-deck1-ja.pdf)といったスクラム的なプラクティスを活用しながら、他の人にも「つくったものによって、こういう体験が提供できます」と説明しうるソフトウェアを提供してもらうことが目的です。

2nd stageは、1st以上にチームで開発してもらうことが重要なファクタとなっています。

### 読書会

また、モバイルアプリ研修と並行して、毎朝1時間は『スクラム実践入門』の読書会を行いました。

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank"><img src="http://ecx.images-amazon.com/images/I/51ABflXRwZL._SL160_.jpg" alt="スクラム実践入門 ── 成果を生み出すアジャイルな開発プロセス (WEB+DB PRESS plus)" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774172367/hifumiass-22/ref=nosim/" name="amazletlink" target="_blank">スクラム実践入門 ── 成果を生み出すアジャイルな開発プロセス (WEB+DB PRESS plus)</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 15.11.08</div></div><div class="amazlet-detail">貝瀬 岳志 原田 勝信 和島 史典 栗林 健太郎 柴田 博志 家永 英治 <br />技術評論社 <br />売り上げランキング: 40,236<br /></div><div class="amazlet-sub-info" style="float: left;"></div></div></div>

基礎研修中の読書会は毎朝10時〜11時に実施しており、書籍は新卒エンジニアのみんなの話し合いで決めていました。
自分たちにとってどんな知識・教養が必要なのかを、その時の状況に応じて判断してもらっています（一応、まったくの放任ではなく、ちょくちょくアドバイスなり口を挟んでました）。

ちなみに新卒エンジニア研修の読書会では、以下のような本を読みました:

1. ハッカーと画家
1. UNIXという考え方
1. 理論から学ぶデータベース実践入門
1. 伽藍とバザール/ノウアスフィアの開墾/魔法のおなべ（次の本が届く間にネット記事を読みました）
1. スクラム実践入門

モバイルアプリ研修やこの後に控えるお産ウィークでは、「チーム」という技能が重要になってくることから、今回の選択に至ったものと思います。

### モバイルアプリ研修の総括

結果からいうと、Android アプリを作ったじょうどチームは 2nd stage までゴールしましたが、iOS アプリを作ったねはんチームは1nd stageまでのゴールとなりました。

モバイルアプリ研修のふりかえり会で彼らに話したことなのですが、このような結果になったのは、技術力の差ではなく、チームコミュニケーションの差であると私には見えました。

どういうことかというと、じょうどチームには1人の司令塔、あるいはリーダーかプロダクトオーナとも言うべき、アプリの設計やUIについてきちんと意見を出して決める人がいました。

1ヶ月という期間、そしてじょうどチームのメンバーにとっては、これがうまく機能したのか、私から見ると適度な量のコミュニケーション、レビュー、議論が行えていると思いました。

一方のねはんチームは、いわゆる「委員会」が発足しているように見えました。

Web開発研修が1人、Webオペレーション研修が2人1組でしたが、チームメンバーが3人以上になると「問題対私たち」という構図の重要性が増します。

この研修では、「どのようなゴールを設定するか」も含めて彼ら自身にデザインしてもらいます。
ライブラリ選定であったり、API 設計であったり、あるいは UI/UX など、これまで以上に頭と手を動かさなければ課題の達成は困難でしょう。

モバイルアプリ研修最終日には、各チームでふりかえり (KPT) を行ってもらいました。

- モバイルアプリ研修
  - Webオペレーションでは2人1組だったが、3人になった途端にコミュニケーションが難しくなること
  - 3人以上から委員会が生まれやすくなる
  - モバイルアプリとしょうしつつ、実際はチーム開発研修という側面が強い
  - 今年の研修の限界だったこと、来年はもっとパワーアップさせること


お産ウィーク
---

お産ウィークは、「**1週間でWebサービスを作る**」という研修です。
新卒エンジニアと新卒デザイナで4人1組のチームを2組結成し、1週間（営業日だと5日）でゼロからWebサービスを開発してもらいました。

ちなみに、ペパボで毎年開催されている一泊二日の開発合宿「[お産合宿](//osan.pepabo.com/)」が名前の由来です。

### チームでWebサービスを考え、作り、「大切にしてほしい3つのこと」を学ぶ

また、最終日には作成したWebサービスの発表とデモを行ってもらいました。

お産ウィークの目的は、「チームでWebサービスを考え、作り、『[大切にしてほしい3つのこと](http://pepabo.com/recruit/important/)』を学ぶ」ことです。

1. みんなと仲良くすること
1. ファンを増やすこと
1. アウトプットすること

この3つを大切にしつつ、うまくチーム開発をすることはとても難しいと考えています。
みんなと仲良くすることと馴れ合いは紙一重であり、ファンを増やすことと媚びることは紙一重であり、アウトプットすることと

1. Webサービス開発の第一歩 (Webサービスを考え、作る)
1. 異職種間でのコラボレーション（協働・協業）
1. 結果としての代名詞、ステップアップ

[![](/images/2015/11/16/osanweek1_large.jpg)](/images/2015/11/16/osanweek1_full.jpg)
*どんなWebサービスを作るか議論している様子*

初日は各チームともに、作りたいサービスやタスクの洗い出しを中心に議論していました。
どのようなサービスを作りたいか、それが1週間で達成可能かどうか、認識は正しく共有できているか、役割分担はどうするかなど、丁寧に話し合っていました。

[![](/images/2015/11/16/osanweek2_large.jpg)](/images/2015/11/16/osanweek2_full.jpg)
*設計について話し合いをしている様子*

2〜4日目は、各チームともに実装を進めていました。
途中、「やっぱりこの機能を全て盛り込むには間に合わない！」「デザインしてて気づいたけど、○○の要素が足りないと思う」などなど、機能を削ったり実装を変えたり、作りたいものと限られた時間について、議論を繰り返しながら修正していました。

[![](/images/2015/11/16/osanweek3_large.jpg)](/images/2015/11/16/osanweek3_full.jpg)
*デザインモックを確認する様子*

- お産ウィーク
  - サービス開発の第1歩
  - モバイルアプリ研修より更に多い4人1組、しかも1人はデザイナで、これまでと違う話し合い方が必要になる
  - 両方ともなんとか完成したものの、チーム開発プロセスは全く異なっていた
  - 「決める人」が1人はいたチーム
  - 「決める人」がおらず、委員会化したチーム

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

[![](/images/2015/11/16/cycleojt1_large.jpg)](/images/2015/11/16/cycleojt1_full.jpg)
*[ブクログ](//booklog.jp/)OJT（新卒エンジニアの[すずぴー](//twitter.com/alotofwe)、エンジニアの[つっちー](//twitter.com/hika69)さん、デザイナの[白木](//twitter.com/meganejinkie)さん）*

OJTのやり方は各サービスに任せています。
各人がサービスにいるのは1週間なのですが、1週間で終わる程度のタスク以外にも、数週間かかるタスクを新卒エンジニアが毎週交代しながら進めていったりと、サービスごとにOJTの内容が違っています。

[![](/images/2015/11/16/cycleojt2_large.jpg)](/images/2015/11/16/cycleojt2_full.jpg)
*技術部OJT（新卒エンジニアの[かすみん](//twitter.com/k_hanazuki)と[柴田さん](twitter.com/hsbt)）*

毎週金曜日の18時からは成果発表＆引継ぎを行っています。
6人が順番に発表する形式で、今週のバリューやOJT先で学んだことを発表したり、翌週への引き継ぎ事項を共有したりしています。

[![](/images/2015/11/16/cycleojt3_large.jpg)](/images/2015/11/16/cycleojt3_full.jpg)
*毎週金曜日の1週間の成果発表・引継ぎの様子*

毎週6つのサービスが便利になっていくので、本当にみんな頼りになります。

おわりに
---

新卒エンジニアの配属は来年1月からで、サイクルOJTも残り2ヶ月となっています。
既に来年度の新卒スタッフの足音も聞こえてくるなか、今年入社の新卒5期生のみんなもどんどんバリューを出していってほしいと思います。
