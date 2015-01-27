---
layout: post
date: 2015-01-27 22:21:08 +0900
title: 標準入力からdocker buildしようとしてハマった
tags:
- docker
---
docker buildでは`docker build -t TAG_NAME - < Dockerfile.centos6`みたく，STDIN経由でビルド出来るが，以下のようにハマってしまったのでメモしとく．

{% tweet https://twitter.com/hfm/status/560057505573646337 %}

{% tweet https://twitter.com/hfm/status/560057600629145601 %}

{% tweet https://twitter.com/hfm/status/560057873598644224 %}

{% tweet https://twitter.com/hfm/status/560058182903410689 %}

`Dockerfile -> Dockerfile.centos5`みたいにsymlinkであれば，`docker build .`で運用可能なことが分かった．

そこで，複数のDockerfileを扱うときは，以下のようにシェルスクリプトなどでラップすることにした．

```sh
dist="centos6"
ln -sf "Dockerfile.${dist}" Dockerfile
```

ちなみにこの現象に遭遇した背景には，インフラCIで複数の環境(CentOS5やら6やらSLやら)が必要で，distributionごとにDockerfileを用意しようとしてた，というものがある．

## Dockerfileへの依存について思うこと

Dockerfileは分割不可能だったり，上記のようなハマりどころがあったり，割と微妙なツール（妙な制約を課せられたシェルスクリプトって感じ）なので，packerにでも乗り換えられないかなあとか考えてる．

必要なツールが増えるのと，packerの学習コストが気がかりなんだけど，Dockerfileのルールを覚えるコストと較べてどうなんだろう．

### インフラCIを実現する上でのPacker

例えばインフラCIならこう出来るのではないか．

1. packerのbuildersフェーズで基礎的なイメージを用意する
  - 最低限のパッケージのSSHログイン可能な状態を構築する
  - OSインストール直後ぐらいの状態のDocker IMAGEが完成する
1. provisionersでpuppetやchefを適応させる
  - ここで一回IMAGEをexportする，というかさせられると思う
1. exportされたIMAGEにServerspecを流し込む

上記みたいな手順を考えると，1と2はpackerで可能だし，3はシェルスクリプト数行で済む．
まだ妄想段階なので色々見えていない (そもそもdockerに精通してないので実現可能かも不明) のだけど，実現できたら結構面白いかも？と思ってる．
