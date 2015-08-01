---
date: 2015-01-31T21:16:32+09:00
title: 'Monitoring Casual #7 に参加・発表した #monitoringcasual'
tags:
- monitoring
- event
---
[Monitoring Casual #7](http://www.zusaar.com/event/9807003 )に参加し，「**30days Albumの裏側〜監視・インフラCI事情〜**」というタイトルで発表しました．

主に監視周りの話で，ふっつーにNagios・Muninを使ってるんですけど，Muninについてはちょっと変わってるのでそれの紹介．
あと，インフラCIは，モニカジに間に合わせようと奮闘してたんですが間に合わなかったので，出来たところまでを紹介する感じになってます．

<iframe src="//www.slideshare.net/slideshow/embed_code/key/fzYxdlP8ucZ2Pe" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hifumis/20150128-monitoringcasual7hfm" title="30days Albumの裏側〜監視・インフラCI事情〜 #monitoringcasual" target="_blank">30days Albumの裏側〜監視・インフラCI事情〜 #monitoringcasual</a> </strong> from <strong><a href="//www.slideshare.net/hifumis" target="_blank">Takahiro Okumura</a></strong> </div>

## 発表中にいただいた意見・コメント

### munin

muninが黒背景になってる理由を説明している時の様子．
（導入した本人である）黒田さんに変わって，背景を黒くした中二ムニンの紹介をしてました．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">Kibanaみたいな色にしたい <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; Taichi Nakashima ☕️ (@deeeet) <a href="https://twitter.com/deeeet/status/561122079009804288">2015, 1月 30</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">魔改造muninだ… <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; fujiwara (@fujiwara) <a href="https://twitter.com/fujiwara/status/561122094872662016">2015, 1月 30</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">中二病みたいなmuninグラフだ <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; まいんだー (@myfinder) <a href="https://twitter.com/myfinder/status/561122323827159040">2015, 1月 30</a></blockquote>

あと独り言．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">先輩エンジニアをいじると笑いが取れる，みたいなエクスペリエンスが蓄積されてきて良くない傾向にいることを自覚している</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/561129902766690304">2015, 1月 30</a></blockquote>

### sensu

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">Sensu なんか色々しょっぱいの分かる <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; れい (Yoshikawa Ryota) (@rrreeeyyy) <a href="https://twitter.com/rrreeeyyy/status/561123239728918529">2015, 1月 30</a></blockquote>

Sensuの「うーん」といったところを喋ってたんですが，他の方も似たような感想を持っていたことが発覚．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">やはり皆sensuつらいって思ってるんだな… <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/561146303778791427">2015, 1月 30</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">sensuは結構モダンで良いところはいいんだけど，rabbitmqとかrubyとか，sensu周辺のコンポーネント及びそれらの連携に難があると思っている <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/561146480606445568">2015, 1月 30</a></blockquote>

Nagiosは単体でちゃんと動いてくれるので，Sensuのようなサーバ・クライアント型と比べて導入はそう難しくないと思う．
設定ファイル書くのがめんどくさいけど，SensuはSensuでめんどくさいところはあるので，正直イーブンかなーというのがイマココの気持ち．

### インフラCI

最近話題になっただけあって，皆さんそれぞれ意見があった印象．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">最近言われてるインフラCIは、roleの単体テストに近いと思ってるので大仰にしすぎるのは良くないんじゃ <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; まいんだー (@myfinder) <a href="https://twitter.com/myfinder/status/561123390342180864">2015, 1月 30</a></blockquote>

「インフラCIはroleの単体テストに近い」という感覚は非常によく分かります．

ところで，オンプレ環境だと1サーバに複数のコンポーネント (role) が混ざることもあり，その組み合わせが予期せぬ現象を引き起こす可能性もあったりする．
なので，インフラCIでは「少なくとも単体roleあたりがちゃんと動いてるか」ぐらいを自動テストしてくれればいいと思ってます．

「インフラCIでどこまでテストすべきか」という観点からすると，やりようによっては非常に大仰なインフラCIになりかねないなーとは危惧しています．

今のところ，「単体RoleのコンテナにServerspecを実行する」ぐらいなら良いかと思っているのですが，まだ分かっていないことが多いので，回答は留保させてください．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">Provisioning のテストするのに Vagrant で VM 上げるのしんどいの分かるけど、本番の適用対象が Docker じゃなくて普通のマシンだと微妙な差分が発生するのでその差分を埋めるの結構難しい気がするんだよな… <a href="https://twitter.com/hashtag/monitoringcasual?src=hash">#monitoringcasual</a></p>&mdash; れい (Yoshikawa Ryota) (@rrreeeyyy) <a href="https://twitter.com/rrreeeyyy/status/561124187910062082">2015, 1月 30</a></blockquote>

しかしながら，「単体RoleのコンテナにServerspecを実行する」にあたって問題になるのは，テストのカバレッジです．
「Dockerでテスト出来ない項目への扱い」については社内でも議論になりました．

Docker環境でもサービスが動くようにパラメタを変えすぎてしまうと，最早何をテストしてるのか分からなくなるので，そういうのは避けたほうがいいかもしれません．
それこそ，先ほど出た「大仰」が過ぎると思います．

発表資料にも書いたとおり，「Dockerは**妥協点**としては上々」であって，その妥協点たる本番の運用対象とDockerとの微妙な差分は，最早インフラCIでは捨てる他ありません．
この「微妙な差分」の塩梅は難しく，いずれまた知見として皆さんへ共有出来ればと考えています．

## 終わりに

インフラCI周りについては，今後もちょくちょくとアウトプットをしていきたいと思います．

モニカジでの皆さんの発表を聞いていると，やはりMackerelやDataDog, ConsulといったツールがMonitoring関連の中心にいることに気付かされます．

ちょうど社内でもうづらさん([@udzura](https://twitter.com/udzura))がConsulをガッツリ触っていたりしていて，僕もそのへんのツールに明るくなりたいなあと思ったのでした．
