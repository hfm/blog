---
title: 'YAPC::Asia Tokyo 2015 感想 #yapcasia'
date: 2015-08-29T08:30:00+09:00
tags:
- event
---
今年も[YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/)に参加してきました (3年目、[個人スポンサ](http://yapcasia.org/2015/individual_sponsors/)として2年目)。

ブログを書くまでがYAPCということで、印象的だったトークの感想などを書き残します。
記録として残そうとすると、ですます調で書きにくいなと感じたため、固い感じになってます。
間違いがあったらツッコミお願いします。
（個人的なメモにもなっているので、カッコ書きが多く、読みにくいかもしれない）

前夜祭
---

前夜祭では次の発表を見た：

- [言語開発の現場](http://yapcasia.org/2015/talk/show/b355fa20-122e-11e5-8ba5-d9f87d574c3a)
- [技術ブログを書くことについて語るときに僕の語ること](http://yapcasia.org/2015/talk/show/7d62caf8-12f4-11e5-881c-d9f87d574c3a)

### [言語開発の現場](http://yapcasia.org/2015/talk/show/b355fa20-122e-11e5-8ba5-d9f87d574c3a)

<iframe width="560" height="315" src="https://www.youtube.com/embed/vCL2OjEmBrM" frameborder="0" allowfullscreen></iframe>

<iframe src="//www.slideshare.net/slideshow/embed_code/key/24Wbxp2GBq8RS7" width="714" height="447" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen></iframe>

Ruby メンテナであり、弊社チーフエンジニアでもある[柴田さん](https://twitter.com/hsbt)の発表。

Ruby という言語がどのように開発されているかという、ソフトウェア開発にまつわる話だった。
意思決定や実装、リリースに至る一連のサイクルについて、見えにくい部分がどうなっているのか知ることが出来た。
かつて柴田さんから聞いた話もあったけど、まとまって聞くのは新鮮だった。

Ruby 1.8 と 1.9 では実装が異なり、それぞれ MRI (CRuby/MRI という表現も見かけた[^1]) と YARV と言う。
この違いを説明するほど理解できてないので、詳しくは『[Rubyのしくみ -Ruby Under a Microscope-](http://www.amazon.co.jp/exec/obidos/ASIN/4274050653/hifumiass-22/ref=nosim/)』を。
今まで、Rubinius や JRuby と区別するために MRI と言っていたが、Ruby 1.9 以降を考慮すると、CRuby と表記したほうが良さそう。

スライド No.13-14 は特に興味深かった。
まず、CRuby （のコミッタ？）から見える "Ruby" がある。
一方、Rubinius や JRuby から見た "Ruby" もある。
（この微妙な違いは文字に書き起こしにくいので、ぜひ動画を見てほしい。）
この「見え方」の違いによって、時々揉め事を呼んでしまうらしい。
Ruby コミッタにとっては頭の痛い問題なのだろうけれど、Ruby が楽しく、自由だからこその（副）産物のように思えた（良い意味でも悪い意味でも）。

感想としては、やはり Ruby は OSS で、OSX や Linux, Windows といった多くのプラットフォームで動くことは「当然」ではなく、多くのメンテナのおかげで成り立っているということ。
もちろん、当たり前のように動くことを目指しているだろうけど、私の言いたいこととしては、チャンスがあればコントリビュートだということである。

### [技術ブログを書くことについて語るときに僕の語ること](http://yapcasia.org/2015/talk/show/7d62caf8-12f4-11e5-881c-d9f87d574c3a)

[ゆううき君](https://twitter.com/y_uuk1) の書いたブログ記事はこちら（資料は公開しないそうです）：

- [YAPC::Asia 2015で技術ブログを書くことについて発表しました - ゆううきブログ](http://yuuki.hatenablog.com/entry/the-art-of-blogging-technologies)

自分に影響を与えてくれた恩人は多いが、ゆううき君のブログに対するスタンスにはとりわけ強く影響を受けている。
以下の新卒エンジニア研修に関する記事は特にその影響を受けている、と思っている。
（「どこが？」と思われるかもしれないが）

- [ペパボ新卒エンジニア研修2015が始まっています](/2015/06/14/pepabo-engineer-training-2015/)
- [ペパボ新卒エンジニア研修2015・Webオペレーション研修が始まっています](/2015/07/20/pepabo-web-operation-training-2015/)
- [ペパボ新卒エンジニア研修2015・モバイルアプリ研修が始まっています](/2015/08/18/pepabo-mobile-app-training-2015/)

ブログ記事に書かれた以下の文章もグッと来る。

> ... OSとかアーキテクチャの話は数年後、がんばれば10年後にも読める内容になるのではないかと思います。
> 話題に限らず自己表現の場だと思って記事書くと、人間は数年でかわったりしたりないと思うので、勝手に息が長くなるような気がしています。

あくまで私の感想に過ぎないが、このブログ記事を読んだ時に、ペパボが謳う「技術力」を思い出した。

> [mizzyさんのエントリにある基準](http://mizzy.org/blog/2012/02/29/1/)に基づき評価を行いました。その際、そこで謳われている「技術力」を以下のように分解しました。
>
> - 作り上げる力
> - 時間の経過に耐える力
> - 影響を広げる力
>
> 『 *[ペバボのエンジニア職位制度のアップデートについて - delirious thoughts](http://blog.kentarok.org/entry/2014/07/10/230856)* 』より

ブログ記事についても、上記と同様のことが言えるのではないか、と思った。

1日目
---

1日目では次の発表を見た：

- [メリークリスマス！](http://yapcasia.org/2015/talk/show/a636430c-0fbf-11e5-8a02-43ec7d574c3a)
- [Managing Containers at Scale with CoreOS and Kubernetes](http://yapcasia.org/2015/talk/show/e19fe827-13c1-11e5-aca1-525412004261)
- [HTTP/2時代のウェブサイト設計](http://yapcasia.org/2015/talk/show/dead6890-09b7-11e5-998a-67dc7d574c3a)
- [【sponsored contents】若手エンジニア達の生存戦略](http://yapcasia.org/2015/talk/show/e14c5ae0-12f7-11e5-a909-d9f87d574c3a)
- [Lightning Talks Day 1](http://yapcasia.org/2015/talk/show/22957e9c-1872-11e5-aca1-525412004261)

### [HTTP/2時代のウェブサイト設計](http://yapcasia.org/2015/talk/show/dead6890-09b7-11e5-998a-67dc7d574c3a)

<iframe width="560" height="315" src="https://www.youtube.com/embed/PDUtzzC_Dsk" frameborder="0" allowfullscreen></iframe>

<iframe src="//www.slideshare.net/slideshow/embed_code/key/xPIDup4I1Z0fS6" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen></iframe>

[@kazuho さん](https://twitter.com/kazuho) の発表。
今年の YAPC::Asia Tokyo で一番見たいトークだった。

Rebuild のゲスト出演回を聴いておくと、予備知識も備わるのでオススメ。

- [Rebuild: 99: The Next Generation Of HTTP (kazuho)](http://rebuild.fm/99/)

断片的にしか知らなかった HTTP/2 の技術要素を把握できると共に、kazuho さんのトークの上手さに知的興奮が止まらなかった。
質疑応答の場面で、「（h2oの）チューニングの勘所は？」という質問に対して、「チューニングのポイントはあまり無い。できるだけデフォルトを最適な形で提供しようとしているから」という回答が最高にカッコよかった。

自分に関係があるのかがよく分かっておらず（こういうところが「技術力」不足なんだと痛感）、食指が動かなかった分野だったが、この発表に奮発させられた。
HTTP/2 やるぞ！という強い気持ちをもらえるトークだった。

あと、[h2i](https://github.com/bradfitz/http2/tree/master/h2i) のデモ画面の字が小さくて読めなかったんだけど、改めて動画を観直して、以下のようなコマンドを打っているとわかったのでメモ（といっても動画も若干文字が潰れているため、絶対の保証はない）。

```
$ h2i www.google.com
Connecting to www.google.com:443 ...
Connected to 111.168.255.20:443
Negotiated protocol "h2"
[FrameHeader SETTINGS len=18]
  [MAX_CONCURRENT_STREAMS = 100]
  [INITIAL_WINDOW_SIZE = 1048576]
  [MAX_FRAME_SIZE = 16384]
[FrameHeader WINDOW_UPDATE len=4]
  Window-Increment = 983041

h2i> HEADERS                        ★ h2i で送信できるフレームタイプの1つ
(as HTTP/1.1)> GET / HTTP/1.1
(as HTTP/1.1)> Host: www.google.com
(as HTTP/1.1)> Hello: world
(as HTTP/1.1)>
Opening Stream-ID 1:
 :authority = www.google.com
 :method = GET
 :path = /
 :scheme = https
 hello = world
[FrameHeader HEADERS flags=END_HEADERS stream=1 len=122]
  :status = "302"
  cache-control = "private"
  content-length = "262"
  content-type = "text/html; charset=UTF-8"
  date = "Fri, 28 Aug 2015 18:13:55 GMT"
  location = "https://www.google.co.jp/?gfe_rd=cr&ei=46TgVY-BDaSg8we6lYuQBQ"
  server = "GFE/2.0"
[FrameHeader DATA flags=END_STREAM stream=1 len=262]
  "<HTML><HEAD><meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">\n<TITLE>302 Moved</TITLE></HEAD><BODY>\n<H1>302 Moved</H1>\nThe document has moved\n<A HREF=\"https://www.google.co.jp/?gfe_rd=cr&amp;ei=46TgVY-BDaSg8we6lYuQBQ\">here</A>.\r\n</BODY></HTML>\r\n"
[FrameHeader PING len=8]
  Data = "\x00\x00\x00\x00\x00\x00\x00\x00"
```

### 無限珈琲

YAPC::Asia ではトークを見るのがスタンダードだが、実は通路や休憩場所でのコミュニケーションも華の1つである（と思っている）。

というわけで（どういうわけだろう）、無限珈琲の提供されるスペースでのんびりしていたところ、 [@shiba_yu36](https://twitter.com/shiba_yu36) さんとお話することが出来た。
勝手にキタソンとかいうイベントを開いたりしてなんかすみません、みたいなことを伝えた（開いてるのは [@kitak](https://twitter.com/kitak) だけど名前つけたのは私なので...）。
もうちょっとお話したかったけど、同じ業界（この表現もいささか謎であるけど）にいるので、なにかの機会で会うことはあるだろう。

### 懇親会

[@ryot_a_rai](https://twitter.com/ryot_a_rai/)君とか[ラーメンさん](https://twitter.com/catatsuy/)とか[@rrreeeyyy](https://twitter.com/rrreeeyyy/)君とかゆううき君とか、いつもの（？）面々で喋っていたら、柴田さんに「若手インフラだ！若手インフラだ！」って言われてしまった。
若手インフラが何かを説明すると、お互いがお互いを異常者と罵り合ったり高め合ったりする謎の異常者集団（お互いに言い合うのだからしょーがない）で、名乗った瞬間から時の流れに追い立てられる時限制の仕様となっている（詳しくは[過去に書いた記事](/2015/02/23/wakateinfra/)を参照）。
誰か替わってくれ。

その場で、ついに（？）あんちぽさんとゆううき君が邂逅した（といっても、数回目らしいけど。）

<a data-flickr-embed="true"  href="https://www.flickr.com/photos/hsbt/20965873065/in/photostream/" title="DSC03734.jpg"><img src="https://farm6.staticflickr.com/5648/20965873065_35b1967134_c.jpg" width="800" height="534" alt="DSC03734.jpg"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>  
*柴田さんが撮影したこの写真は、何故か、私 vs CTO みたいになってる*

インターネット（というかツイッタ）で散々バトルしていた2人だったが（そうなのか？）、最後の YAPC::Asia にて邂逅を果たした（大事なことなので2回目）。
しかし、あんちぽさんが「これがおっさんのやり方だ！」と言いながら、周囲の人々を1人ずつ懐柔して仲間に引き込み、ゆううき君を孤立させるという作戦に出たため、若者代表ゆううき君は大分苦戦してた気がする。

次は2人でトークショーを開催してほしい（無責任）。

2日目
---

1日目では次の発表を見た：

- [3分でサービスのOSを入れ替える技術 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/4f85e87a-f9ec-11e4-8262-8ab37d574c3a)
- [【特別企画】YAPCあるある（仮） - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/ad57ca84-13e9-11e5-aca1-525412004261)
- [Profiling & Optimizing in Go - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/6bde6c69-187a-11e5-aca1-525412004261)
- [Lightning Talks Day 2 - YAPC::Asia Tokyo 2015](http://yapcasia.org/2015/talk/show/69caedbd-1872-11e5-aca1-525412004261)

午前中のセッションが無いのは、1日目の26時過ぎまで [@deeeet](https://twitter.com/deeeet) 君とゆううき君と日本酒専門の立ち飲み屋でずっと呑んでたから。
要は起きれなかった。

### [3分でサービスのOSを入れ替える技術](http://yapcasia.org/2015/talk/show/4f85e87a-f9ec-11e4-8262-8ab37d574c3a)

<iframe src="//www.slideshare.net/slideshow/embed_code/key/K9XghBPCzABX32" width="714" height="447" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen></iframe>

ここ半年間の集大成ともいうべき発表だった。
動画やスライドの前に、日記に書かれている「伝えたかったこと」を読むと、要旨を理解できるのでオススメ。

- [YAPC Asia 2015 Day 2 - HsbtDiary(2015-08-22)](http://www.hsbt.org/diary/20150822.html#p01)

"No SSH" という制約によって自動化が進むという趣意にはハッとさせられた。
SSH は、サーバでの好き勝手なふるまいを許す強力な武器だ（もちろん制限をかけることは可能だが）。
しかし、（ほぼ）なんでも出来てしまう状況こそが、自動化を阻む思考の壁になってしまっているのではないか。

そんな魔法とも呼ぶべき（と思うようになった） SSH をあえて禁止することによって、全く別の観点を持ちださなければならなくなる。
制約によるイノベーションというと大仰に聞こえるかもしれないが、そのような感想を持った。

また、Check point 1 (p.33) で述べられている _"DO NOT change main architecture"_ は非常に大切だ。
自動化をする上では、目の前で動いているものこそがベースであって、アーキテクチャを置き換える別のアーキテクチャを持ちだしたところで、アンパンマンの頭のようにスコンと入れ替えることは出来ない。
小さな改良をコツコツと積み重ね、確実な自動化を目指していくという姿勢は見習っていきたいと思う。

### [Profiling & Optimizing in Go](http://yapcasia.org/2015/talk/show/6bde6c69-187a-11e5-aca1-525412004261)

<iframe width="560" height="315" src="https://www.youtube.com/embed/xxDZuPEgbBU" frameborder="0" allowfullscreen></iframe>

<iframe width="560" height="344" src="https://docs.google.com/presentation/d/1lL7Wlh9GBtTSieqHGJ5AUd1XVYR48UPhEloVem-79mA/embed" frameborder="0" allowfullscreen></iframe>

デモ用のプログラムはこちら: [bradfitz/talk-yapc-asia-2015](https://github.com/bradfitz/talk-yapc-asia-2015)

タイトルの通り、Goで書かれたコードをプロファイリングし、最適化していく方法の紹介なのだが、それをライブコーディングで実演してくれた。
発表は英語なので、翻訳が無いと聴けない人は [talk.md](https://github.com/bradfitz/talk-yapc-asia-2015/blob/master/talk.md) を読むのが良いだろう。

`go test` のオプションだったり、 `go tool` の使い方だったり、golang の標準ツールは非常に強力であるということを教えてもらった。
まさに _"Go has amazing tools!"_ の通りである。

おわりに
---

最後の YAPC::Asia だ！と意気込んでいたのに、前夜祭で完全に失敗した。（本当にすみませんでした）

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">おっくんが、うずらさんと間違えて牧さんに「プレゼンお疲れ様でした」って話しかけたのウケる。</p>&mdash; Gosuke Miyashita (@gosukenator) <a href="https://twitter.com/gosukenator/status/634342828215169024">2015, 8月 20</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">やりましたね！！！&#10;ついにやりました！！！</p>&mdash; 鶉 (@uzulla) <a href="https://twitter.com/uzulla/status/634370217066430465">2015, 8月 20</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">「おお、おっくんよ、うずらと間違えてしまうとはなさけない」<a href="https://twitter.com/hashtag/yapcasia?src=hash">#yapcasia</a></p>&mdash; Daisuke Maki (@lestrrat) <a href="https://twitter.com/lestrrat/status/634371934617145349">2015, 8月 20</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">うちのおくむらがすみません</p>&mdash; SHIBATA Hiroshi (@hsbt) <a href="https://twitter.com/hsbt/status/634381703331491840">2015, 8月 20</a></blockquote>

とほほ。

[^1]: http://magazine.rubyist.net/?0041-YarvManiacs
