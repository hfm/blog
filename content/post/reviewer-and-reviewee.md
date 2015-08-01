---
layout: post
date: 2015-04-06T01:16:46+09:00
title: ReviewerとReviewee
tags:
- opinion
---
最近レビューする回数が多く、それから派生したまとまりの無いツイートが散見してたのでポエムでつないでみる。

## レビューと健康

レビューする側とされる側、コミュニケーション次第では段々剣呑な雰囲気を帯びてくる場合がある。
この雰囲気ってやつは、個々人のパーソナリティよりも、体調面の変動をキッカケに危うくなるイメージがある。

体調悪い時はあんまレビューしない方がいい。
っていうか休んだほうがいい。

## Reviewer V.S. Reviewee ?

衝突を避けられない時があると分かっていても、なるべく避けようと努力してみる。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">レビューするときは「Reviewer V.S. Reviewee」の構図を作らないように、常に自分に言い聞かせてる。</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/583848573306966016">2015, 4月 3</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## 相手にメンチ切らなくていいので目的を見たほうが良い

レビューの場では、2人が向き合うのではなく、同じ方向を見ながら、半ば独り言のように「こうすべきか？」「いや、ああすべきだな」って感じで話したい。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">レビューする側とされる側で対立構造を生むと、本来の目的から遠ざかってしまう。</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/583849198895800320">2015, 4月 3</a></blockquote>

バーカウンターに並んで座るように、同じ方向を見つめながら議論をすると、落ち着いて話し合うことができる。
レビューをする前に、一度そういう風景を思い描いてみる。
HRTの原則を思い出す。

> [小野和俊のブログ:HRTの原則 ～ソフトウェア開発はバーでしっとり語り合うように ～](http://blog.livedoor.jp/lalha/archives/50496623.html)

これはReviewerとReviewee双方に求めたいことで、意見は投げつけるものではなく、カウンターの上に並べてみる。
個人の意見というものはカタく、当たると心にケガをする。

（ちなみにこれは精神的な意味合いで、実際に話しかけにきてくれた人の顔は、ちゃんと見て応対した方がいい）

## レビューの場に漂う瘴気に侵されてはならない

レビューの場では、段々相手を言い負かしたくなってくる。
自分の知識をひけらかしたくなってくる。
「（あなたは知らないかもしれませんが）」って嫌味な接頭辞を心のなかでつけたくなる。

目的を見失っちゃいけない。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">レビューはお互いの実力を発揮する場所では無く、目的の達成をより高い精度で実現するための1つの手段に過ぎないのだー</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/583849717194301440">2015, 4月 3</a></blockquote>

「目的」を考える上で、以下が良い参考になる。

> [コードレビューに費やす時間を短くする - クックパッド開発者ブログ](http://techlife.cookpad.com/entry/2015/03/30/174713)

## 価値が誰に届くのかを考える

Pull Requestで「LGTM」が並ぶと気持ちがいい。
何かに勝った感じがする。
（逆にちょっと不安にもなる）

修正の必要が無い、完璧なPull Requestを作るのは難しい。
エンジニアは傲慢を美徳とするため、脆弱性を指摘されないために、つい完璧を目指してしまう。
だが限界はある。

Pull Requestがもたらす価値は、個人への勝利ではなく、顧客に届くモノのはず。
（顧客がチームの場合もある）
自分の勝敗は気にしない。

## チームプレー

レビューというものは、個人の限界を突破できる仕組みであってほしい。
ReviewerとRevieweeは目的を達成する上での重要なパートナーであり、コミュニケーションという協力プレー型ゲームの上で、一緒に勝つためにあーだこーだ言い合う仲でありたい。

コミュニケーション云々については、最近以下の本を読んでた。
実践的なチームコミュニケーションの話として読める内容で、「コミュニケーションは協力プレーのゲームである」ってのもこれの引用。

[![なぜ、この人と話をすると楽になるのか](http://ecx.images-amazon.com/images/I/51uHyunfssL._SL160_.jpg)](http://www.amazon.co.jp/exec/obidos/ASIN/B00SQYBB0A/hifumiass-22/ref=nosim/)
[なぜ、この人と話をすると楽になるのか](http://www.amazon.co.jp/exec/obidos/ASIN/B00SQYBB0A/hifumiass-22/ref=nosim/)

## 味方を信じる

さっきも言ったとおり、レビューは協力プレーなんだから、間違っても敵じゃない。

だからこそ、Pull Requestを出す時は的を絞った方がいい。
相手が言い負かしてくるんじゃないか？って恐怖に取り憑かれて、なにやら目的と関係ないことまでアレやコレやと並べ立ててしまうと、双方混乱しかねない。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">「Reviewer V.S. Reviewee」の対立構造を作りやすくしてしまう要因として、本来必要でない説明（当人からすれば、論拠の補強≒自分の意見を論破されないための言い訳）を並べ立ててしまうというのがある気がする。</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/584731322255409153">2015, 4月 5</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">しかしそれは煙幕弾に過ぎないような。&#10;目立った効果を得られないばかりか、むしろReviewerからすれば、論点がどんどんボケていく危機を察することになる。&#10;結果、煙幕を物ともしない破壊力のあるコメントを放つしかなくなるので、血塗れのプルリクエストが生まれる恐れがある。</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/584732862932320257">2015, 4月 5</a></blockquote>

もしも目的が自分の中で曖昧になりそうだったら、早めに相談する。

### 味方が味方であるために

相談するためには前提がある。

技術的に優れた人、メンターや教育指導者、あるいはリーダーやマネージャ、ザックリ言えば「頼れる人」が常に余裕を持ち合わせられる（相談しやすさを維持する）だけの環境・制度が整っていなければいけない。

ちなみに、うちの会社だとシニアエンジニアとかマネージャ等が「ミドル」と位置づけされており、「頼れる人」としての期待をされているはず。
この「頼れる人」たちから余裕を奪ってしまうのは本当に良くない。

余裕をもってもらうためには仕組みが必要だが、それはさすがに主語が大きい。
スコープを自分に絞れば、自分の技術を上げるしかない。
味方であるために、味方でいてもらうために、自分自身の努力は外せない。

### 技術と人間

もうちょっと脱線すると、ペパボにはアドバンスドシニアエンジニアというスーパーサイヤ人3だか4だかみたいな人たちがいるんだけど、この人たちは当たり前のように柔和な空気を持っている。
圧倒的な技術力を持つ人たちは、人間的にも大きくなるんだろうなあと思うほどに両方を持ち合わせている。

[![すごいひとたち](/images/2015/04/06/sugoihitotachi.png)](https://pepabo.com/recruit/career/engineer/)

技術力と相談しやすさの相関関係は分からない。
会社の風土と技術評価制度が合わさった結果の、偶然か奇跡のようなものかもしれない。

自分もそうありたいと思うが、自然とはなれない。
日々精進。

## 終わりに

レビューの話から段々広がっていってしまったけど、どこかに書き出して頭から忘れさせる必要があるので書いた。

具体性に欠けてもいいやと、思いきってブログにしたためたが、こういうこと書いてると、いったい自分は何と戦ってるんだって気分になってくる。

結局は自分の迷いが原因に過ぎず、自分と向き合うしか解決は無いのでがんばろう。