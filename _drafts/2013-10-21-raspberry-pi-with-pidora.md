---
layout: post
title: Raspberry Pi, Pidora, mruby
tags: 
- mruby
- raspberry pi
- pidora
---
[前回のエントリ](http://localhost:4000/2013/10/05/lxcjp)で書いた[@matsumotory](https://twitter.com/matsumotory)さんの研究内容に触発されたエントリです。

手元にRaspberry Piがあったので、これでにmrubyとmod_mruby, mruby-cgroupを試してみようと思います。
OSはRedHad系が良かったのでPidoraを選択。

ところでPidoraの読み方がよく分からなかったのですが、Piはラズベリーパイから来ているはずなので、「パイドラ」と読めばいいんですよね…？

## Raspberry PiにPidoraをインストール

Raspberry PiにPidoraを入れるまでの手順はQiitaにエントリを投稿したのでそちらをご覧ください。

* [MacでRaspberry PiにOSを入れるまでのやることリスト](http://qiita.com/hfm/items/96d20d9cc29fb46fd8a3)

## Pidoraにmruby

本家ドキュメントを参考にしてインストール。

> https://github.com/mruby/mruby/blob/master/INSTALL

```bash
yum install git bison
git clone https://github.com/mruby/mruby.git
cd mruby
make 
```

mruby/buildディレクトリ以下にhostディレクトリが作成され、中にbin, lib, include等のファイルが生成されます。

## そしてcgroups
