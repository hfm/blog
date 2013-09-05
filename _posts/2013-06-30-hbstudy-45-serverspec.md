---
layout: post
title: '#hbstudy 45 に参加してきました。'
categories:
- Dev
- Review
tags:
- Diary
- Pepabo
- serverspec
- study meeting
status: publish
type: post
published: true
---
遅ばせながら備忘録になります。既にserverspecを知っている方にとっては当たり前すぎることしか書けてないです。すみません。

## hbstudy

hbstudyは、[株式会社ハートビーツ](http://heartbeats.jp)が主催するインフラエンジニアリングの勉強会です。

<!--more-->

> インフラエンジニア勉強会hbstudy | 株式会社ハートビーツ
>
> http://heartbeats.jp/hbstudy/

2013年6月21日(金)に開催された第45回のテーマは「serverspecが拓いたサーバテストの世界」 でした。
スピーカーは、ペパボのテクニカルマネージャーであり、私が今受けているペパボエンジニア研修でもお世話になっているmizzyさん（宮下剛輔さん）です。

[slideshare id=23291087&amp;doc=serverspec-hbstudy45-130621125223-phpapp01&amp;w=514&amp;h=422]

* http://mizzy.org/
* https://github.com/mizzy/

## serverspec

serverspecとは、mizzyさんが中心となって開発されているサーバのテストを行うRuby製のツールです。

```bash
gem install serverspec
```

* 「Webサーバはちゃんと動いているだろうか？」
* 「そもそもちゃんとインストール成功してるだろうか？」
* 「listenポート80番はちゃんと開いてるだろうか？」

サーバ構築におけるチェック項目を、RSpecに倣った読みやすい（わかりやすい）記法でシンプルに書けます。
ローカル環境でのテストとSSH経由でのリモート環境でのテストが可能です。

```ruby
serverspec_sample_spec.rb
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port('80') do
  it { should be_listening }
end
```

Webサーバに限らず、userの情報やファイル・ディレクトリの有無なども細かくチェックすることが可能です。より詳しい動作に関しては、上記の発表資料や公式Webサイト、GitHubリポジトリをご覧ください。

* http://serverspec.org/
* https://github.com/mizzy/serverspec/

ちなみにserverspecはruby 1.8.7 (MacやFreeBSD等の標準バージョン等) でも動くようです。

https://twitter.com/gosukenator/status/348273825525415938

## simple design

mizzyさんの説明のなかでも特に印象に残ったのは「既存のツールでは機能が多すぎる」というところでした。

serverspecはとにかくシンプルな設計になっていて、ソースコードを覗くとすごくスッキリした内部構成になっていることが分かります。

僕なんかはここ１ヶ月のうちにようやくテストコードを書きだした未熟者なのですが、そんな人間でもサッと理解できるほど、serverspecのテストコードもまたシンプルです。

資料p.34-46でそのような哲学的な部分を述べられていて、僕はこの説明をされている時が深く印象に残りました。

serverspecにcontributeしていったら、そうしたmizzyさんの哲学の一端に触れられるのかもしれません…と思い、目下FreeBSDのserverspecを書き書きしています。

https://github.com/mizzy/serverspec/pull/161

まだテストが全然書けていないし、FreeBSDをDetectしただけでFreeBSD特有のコマンドに対応したわけでもないので、地道に続けていきます。
