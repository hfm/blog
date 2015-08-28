---
title: YAPC::Asia Tokyo 2015
date: 2015-08-25T07:46:13+09:00
draft: true
tags:
- event
---
今年も[YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/)に参加してきました (3年目、[個人スポンサ](http://yapcasia.org/2015/individual_sponsors/)として2年目)。

ブログを書くまでがYAPCということで、印象的だったトークの感想などを書き残します。
記録として残そうとすると、ですます調で書きにくいなと感じたため、固い感じになってます。

前夜祭
---

前夜祭では、次の発表を見た。

- [言語開発の現場](http://yapcasia.org/2015/talk/show/b355fa20-122e-11e5-8ba5-d9f87d574c3a)
- [技術ブログを書くことについて語るときに僕の語ること](http://yapcasia.org/2015/talk/show/7d62caf8-12f4-11e5-881c-d9f87d574c3a)

### [言語開発の現場](http://yapcasia.org/2015/talk/show/b355fa20-122e-11e5-8ba5-d9f87d574c3a)

弊社チーフエンジニアでもある[柴田さん](https://twitter.com/hsbt)の発表。

http://www.slideshare.net/hsbt/the-story-of-language-development

Ruby における開発の意思決定や実装、リリースに至る一連のサイクルについて、言語開発の普段は見えない部分がどうなっているかを、メンテナという立場から発表されていた。
かつて柴田さんから聞いたことはあった部分も多いけど、ストーリィとして聞く機会があるわけではなく、やはり新鮮だった。

Ruby 1.8 と 1.9 では実装が大きく異なり、それぞれ MRI (CRuby/MRI という表現も見かける[^1]) と YARV と言う。
説明できるほど理解できていないので、詳しくは『[Rubyのしくみ -Ruby Under a Microscope-](http://www.amazon.co.jp/exec/obidos/ASIN/4274050653/hifumiass-22/ref=nosim/)』を。
普段、Rubinius や JRuby と区別するために MRI MRI と言っていたが、Ruby 1.9 以降を踏まえると、CRuby と表現したほうが良さそう。

スライド No.14 は特に面白く、CRuby （のメンテナ？）から見た『Ruby 実装圏』（ふと思いついた表現を使ってみた）と、Rubinius や JRuby のような CRuby 以外の Ruby 実装にまつわる人々（こちらはメンテナだけで無い気もしたのでこういう言い方にする）から見た実装圏がどうなっているのかの比較になっている。
要するに、見え方からして乖離しているようだった。

感想としては、やはり Ruby は OSS で、OSX や Linux, Windows といった多くのプラットフォームで動くことは「当然」ではなく、多くのメンテナのおかげで成り立っているということ。
もちろん、当たり前のように動くことを目指しているだろうけど、言いたいこととしては、チャンスがあればコントリビュートだということである。

### [技術ブログを書くことについて語るときに僕の語ること](http://yapcasia.org/2015/talk/show/7d62caf8-12f4-11e5-881c-d9f87d574c3a)

[ゆううき君](https://twitter.com/y_uuk1) の書いたブログ記事はこちら：

- [YAPC::Asia 2015で技術ブログを書くことについて発表しました - ゆううきブログ](http://yuuki.hatenablog.com/entry/the-art-of-blogging-technologies)

自分の活動に影響を与えてくれた恩人は多いが、ゆううき君と [@deeeet君](https://twitter.com/deeeet) のスタンスにはとりわけ強く影響を受けている。
本人たちがそう語ったわけではないので、ここから書くのはあくまで私の解釈に過ぎないが、つくり上げるということ、影響を広めるということについて、

「どこが？」と思うかもしれないが、以下の新卒エンジニア研修に関する記事は彼らの強い影響下にある、と思っている。

- [ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)
- [ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています](/2015/07/20/pepabo-web-operation-training-2015/)
- [ペパボ新卒エンジニア研修2015・モバイルアプリ研修が始まっています](/2015/08/18/pepabo-mobile-app-training-2015/)

#### 書くという行為について考えたこと

1日目の夜中、日本酒専門の立ち飲み居酒屋で @deeeet 君と @y_uuk1 君の3人で呑んでたときの話（時系列性よりも話の流れを優先）。


1日目
---

- [メリークリスマス！](http://yapcasia.org/2015/talk/show/a636430c-0fbf-11e5-8a02-43ec7d574c3a)
- [Managing Containers at Scale with CoreOS and Kubernetes](http://yapcasia.org/2015/talk/show/e19fe827-13c1-11e5-aca1-525412004261)
- [HTTP/2時代のウェブサイト設計](http://yapcasia.org/2015/talk/show/dead6890-09b7-11e5-998a-67dc7d574c3a)
- [【sponsored contents】若手エンジニア達の生存戦略](http://yapcasia.org/2015/talk/show/e14c5ae0-12f7-11e5-a909-d9f87d574c3a)
- [Lightning Talks Day 1](http://yapcasia.org/2015/talk/show/22957e9c-1872-11e5-aca1-525412004261)

### [HTTP/2時代のウェブサイト設計 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/dead6890-09b7-11e5-998a-67dc7d574c3a)
### [【sponsored contents】若手エンジニア達の生存戦略 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/e14c5ae0-12f7-11e5-a909-d9f87d574c3a)
### 懇親会



2日目
---

- [3分でサービスのOSを入れ替える技術 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/4f85e87a-f9ec-11e4-8262-8ab37d574c3a)
- [【特別企画】YAPCあるある（仮） - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/ad57ca84-13e9-11e5-aca1-525412004261)
- [Profiling & Optimizing in Go - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/6bde6c69-187a-11e5-aca1-525412004261)
- [Lightning Talks Day 2 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/69caedbd-1872-11e5-aca1-525412004261)

### [3分でサービスのOSを入れ替える技術 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/4f85e87a-f9ec-11e4-8262-8ab37d574c3a)

http://www.slideshare.net/hsbt/advanced-technic-for-os-upgrading-in-3-minutes

### [Profiling & Optimizing in Go - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/6bde6c69-187a-11e5-aca1-525412004261)

あとがき
---

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">おっくんが、うずらさんと間違えて牧さんに「プレゼンお疲れ様でした」って話しかけたのウケる。</p>&mdash; Gosuke Miyashita (@gosukenator) <a href="https://twitter.com/gosukenator/status/634342828215169024">2015, 8月 20</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">やりましたね！！！&#10;ついにやりました！！！</p>&mdash; 鶉 (@uzulla) <a href="https://twitter.com/uzulla/status/634370217066430465">2015, 8月 20</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">「おお、おっくんよ、うずらと間違えてしまうとはなさけない」<a href="https://twitter.com/hashtag/yapcasia?src=hash">#yapcasia</a></p>&mdash; Daisuke Maki (@lestrrat) <a href="https://twitter.com/lestrrat/status/634371934617145349">2015, 8月 20</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">うちのおくむらがすみません</p>&mdash; SHIBATA Hiroshi (@hsbt) <a href="https://twitter.com/hsbt/status/634381703331491840">2015, 8月 20</a></blockquote>

最後の YAPC::Asia だ！と思って意気込んでいたのに、前夜祭で大失敗した。（本当にすみませんでした）

[^1]: http://magazine.rubyist.net/?0041-YarvManiacs
