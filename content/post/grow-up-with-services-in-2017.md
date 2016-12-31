---
date: 2016-12-31T20:53:28+09:00
title: 昇格と貢献〜2016年の省察
tags:
- diary
---
2016年もあと数時間。[昨年](/2015/12/31/reflection-2015/)は新卒エンジニア研修に尽力していたが、今年はまた違った1年となった。

### 昇格

[ペパボのエンジニア職位制度](http://blog.kentarok.org/entry/2014/07/10/230856)での承認を経て、シニアへの職位昇格が決まった。

いっそう身の引き締まる思いがする。専門職の格たるものを考え続けている。せめて、技術面でも組織面でもリーダーシップを発揮し、社の技術力を牽引し、日々の生産性向上について良い影響を及ぼせるよう研鑽していかなければならない。走りながら考えていこうと思う。

ペパボに新卒で入社し、ここに至るまで3年と半年強かかった。自己評価で鈍足。業務経験の無いところから出発し、先輩たちに色々な知識と経験を授かり、なにより会社のサービスそのものが自分を育ててくれたと思う。本当にありがとうございます。

まだまだ生馴れながらも、ようやく恩返しできるような立場に近づけたような気がする。

### ngx_mruby のメンテナになった

『[動的証明書読み込み ngx\_mruby編](https://speakerdeck.com/hfm/gmo-hoscon-2016)』で発表した[ngx_mruby](https://github.com/matsumoto-r/ngx_mruby)による動的証明書読み込みを、とあるサービスでリリースした。その過程でngx_mrubyにPull Requestを積み重ね、気がつけばメンテナになっていた。

ngx_mrubyのソースコードを読みはじめたのは夏が終わる頃で、C言語の知識は大学でちょっと学んだ程度だった。今ではけっこう慣れてきて、nginxのソースコードもmrubyのソースコードもある程度読めるようになった。やってみればなんとかなる。

動的証明書読み込みの実装にあたって得た知識をどこかで発表したいと思ってる。上記の資料は10分LT用にだいぶ詰め込み、端折りまくっているので、30〜40分くらいのボリュームでしっかりと喋りたい。

また、扱う言語も変わってきており、以前はPuppet時々Rubyだったのだけど、Cの割合がだいぶ増えてきた。システムプログラミングへの関心が高まっており、来年はRustいきます等と述べている。2017年はngx_mruby (nginx / mruby)とRustの年にしたい。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">弊社2017年はRustいきます</p>&mdash; OKUMURA Takahiro (@hfm) <a href="https://twitter.com/hfm/status/814898836686544896">2016年12月30日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### 財布買い替えた

上2つに比べると、急にどうしたという話題かも。

大学2年のころに買ったPORTERの財布が全然壊れなくて換え時を見失っていたのだけど、いよいよ縫い目がほつれてしまったので新調することにした。弊社の「[minne](http://minne.com/)」から数時間ぶらぶら探しつつ、気に入ったものを選んだ。

<a data-pin-do="embedPin" data-pin-lang="ja" href="https://jp.pinterest.com/pin/697776535985602564/"></a> <a data-pin-do="embedPin" data-pin-lang="ja" href="https://jp.pinterest.com/pin/697776535985602566/"></a>

思い切って小銭と紙幣（とカード類）を分けてみたら、これが意外と良かった。つい不要なカードや会員証などを入れてしまっていたのだけど、それも無くなりスッキリした。センスに自信はないけど、快適な使い心地で喜んでる。

<script async defer src="//assets.pinterest.com/js/pinit.js"></script>

2017年からのペパボの技術と私
---

ペパボは今、ngx_mrubyや[STNS](http://github.com/STNS/STNS), [haconiwa](https://github.com/haconiwa/haconiwa)のような基盤技術を開発、導入し、自分たちでコントロールできる技術的な領域を拡大させている。OpenStackによるプライベートクラウド「[Nyah](https://speakerdeck.com/tnmt/pepabos-privatecloud-nyah-after-that)」もその一環だと思う。

シニアは、これからの技術を担う中軸たる存在として、このような活動を啓蒙し、さらなる会社の成長に寄与する存在でなくてはならない。そしてその先に、[@matsumotory](https://twitter.com/matsumotory) さんや [@pyama86](https://twitter.com/pyama86) さん、[@udzura](https://twitter.com/udzura) さんといった、開発やインフラという垣根を越えた位置でパフォーマンスを発揮するエンジニアがいる。

そうした人たちを渇仰してやまない。

構築・運用・保守を高い水準で発揮できる安定したウェブオペレーション能力と、必要な機能は自ら作り上げられる高い開発能力。これらを兼ね備えたエンジニアがペパボには必要で、自分がその最たる人物になるべく、これからもずっとひたむきでありたい。
