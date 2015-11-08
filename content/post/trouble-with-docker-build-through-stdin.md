---
date: 2015-01-27T22:21:08+09:00
title: 標準入力からdocker buildしようとしてハマった
tags:
- docker
---
docker buildでは`docker build -t TAG_NAME - < Dockerfile.centos6`みたく、STDIN経由でビルド出来るが、以下のようにハマってしまったのでメモしとく。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">docker build - &lt; Dockerfile&#10;ってやると、何故かADDが効かない現象に遭遇した。&#10;&#10;調べてみたらここでも言及されていた。&#10;<a href="http://t.co/pTDMSKJWPT">http://t.co/pTDMSKJWPT</a></p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/560057505573646337">2015, 1月 27</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://t.co/SVKZhQp9tI">https://t.co/SVKZhQp9tI</a> の続き。&#10;&#10;どうやら公式の説明によると、STDIN経由でのbuildは”no build context”という奴で、URLベースのADD操作しか出来ないらしい。&#10;<a href="http://t.co/q2NDkuE1YM">http://t.co/q2NDkuE1YM</a></p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/560057600629145601">2015, 1月 27</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://t.co/I6V7fhQhcr">https://t.co/I6V7fhQhcr</a> の続き。&#10;&#10;ちなみにこれは、複数のDockerfileを扱おうとして、`docker build - &lt; Dockerfile.centos6`ってやろうとして遭遇した奴。</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/560057873598644224">2015, 1月 27</a></blockquote>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://t.co/ka2JBEJunp">https://t.co/ka2JBEJunp</a> の続き。&#10;Dockerfile -&gt; Dockerfile.centos6 みたいなsymlink使えば`docker build .`出来るので、その辺はシェルスクリプトなりでゴニョる感じでなんとかすることにする。</p>&mdash; okumura takahiro (@hfm) <a href="https://twitter.com/hfm/status/560058182903410689">2015, 1月 27</a></blockquote>

`Dockerfile -> Dockerfile.centos5`みたいにsymlinkであれば、`docker build .`で運用可能なことが分かった。

そこで、複数のDockerfileを扱うときは、以下のようにシェルスクリプトなどでラップすることにした。

```sh
dist="centos6"
ln -sf "Dockerfile.${dist}" Dockerfile
```

ちなみにこの現象に遭遇した背景には、インフラCIで複数の環境(CentOS5やら6やらSLやら)が必要で、distributionごとにDockerfileを用意しようとしてた、というものがある。

---

追記 (2015-01-27 22:37)

Docker 1.5になると、docker buildに`-f`オプションが追加されるかもしれないらしい。
これはDockerfileの指定オプションらしく、上記の悩みを一気に解決してくれそう。

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/hfm">@hfm</a> 1.5で解決しそうですけどね <a href="https://t.co/CgWtsW7Yem">https://t.co/CgWtsW7Yem</a></p>&mdash; Taichi Nakashima ☕️ (@deeeet) <a href="https://twitter.com/deeeet/status/560067994059960321">2015, 1月 27</a></blockquote>

<blockquote class="twitter-tweet" data-conversation="none" lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/hfm">@hfm</a> すいません、こっちです <a href="https://t.co/WP8fV6qjS6">https://t.co/WP8fV6qjS6</a></p>&mdash; Taichi Nakashima ☕️ (@deeeet) <a href="https://twitter.com/deeeet/status/560068243784622081">2015, 1月 27</a></blockquote>

[@deeeet](https://twitter.com/deeeet)さん教えてくれてありがとう!!

---

## Dockerfileへの依存について思うこと

Dockerfileは分割不可能だったり、上記のようなハマりどころがあったり、割と微妙なツール（妙な制約を課せられたシェルスクリプトって感じ）なので、packerにでも乗り換えられないかなあとか考えてる。

必要なツールが増えるのと、packerの学習コストが気がかりなんだけど、Dockerfileのルールを覚えるコストと較べてどうなんだろう。

### インフラCIを実現する上でのPacker

例えばインフラCIならこう出来るのではないか。

1. packerのbuildersフェーズで基礎的なイメージを用意する
  - 最低限のパッケージのSSHログイン可能な状態を構築する
  - OSインストール直後ぐらいの状態のDocker IMAGEが完成する
1. provisionersでpuppetやchefを適応させる
  - ここで一回IMAGEをexportする、というかさせられると思う
1. exportされたIMAGEにServerspecを流し込む

上記みたいな手順を考えると、1と2はpackerで可能だし、3はシェルスクリプト数行で済む。
まだ妄想段階なので色々見えていない (そもそもdockerに精通してないので実現可能かも不明) のだけど、実現できたら結構面白いかも？と思ってる。
