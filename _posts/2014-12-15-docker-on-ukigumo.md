---
layout: post
date: 2014-12-15 13:07:35 +0900
title: CentOSにUkigumoをいれてDockerを動かそうとしてハマった話
tags: 
- docker
- ukigumo
- perl
---
この記事は[Docker Advent Calendar 2014 - Qiita](http://qiita.com/advent-calendar/2014/docker)15日目の記事です．

昨日は[foostan](http://qiita.com/foostan)さんの「[DockerコンテナをConsulで管理する方法](http://qiita.com/foostan/items/a679ffcf3e20ff2f6032)」でした．

## UkigumoでDockerを使いたい

Docker上でUkigumoを使うのではなく，Ukigumoのなかでdocker buildしてみたいと思ったんですが，それっぽいブログが見当たらなかったので自分でやってみることにしました．
普段CentOSを利用しているので，こいつの上で動かそう...と思ったらなかなかハマってしまったので，それの備忘録となります．

### Dockerの用意

用意だけはすぐできる．

```console
$ rpm --import http://ftp.iij.ad.jp/pub/linux/fedora/epel/RPM-GPG-KEY-EPEL-6
$ rpm -ivh http://ftp.iij.ad.jp/pub/linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
$ yum -y install docker-io
$ service docker start
$ chkconfig docker on
```

### Perl 5.10.1にUkigumoが入らない

なんやかんやでここが一番ハマりました．

CentOS 6のsystem perlのバージョンは5.10.1です．
どうもTwiggyが5.10.1ではインストールが難しいみたい[^1]でした．
で，system perlじゃどうも厳しい（今考えると，なんでこんな古いもので頑張ろうとしたのか）ので，plenv経由で5.11系を試してみたら，今度は`Test::WWW::Mechanize`のテストのところでコケてしまって先へ進まず...

結局，5.18.4で`Ukigumo::Agent``Ukigumo::Client``Ukigumo::Server`がインストールされました．
（ちなみに5.21系でビルドしようともしたんですが，こちらも上手くいかず...）

```
plenv install 5.18.4
plenv global 5.18.4
plenv install-cpanm

# 何故かこれだけ途中でコケるので先に入れておく
cpanm Amon2::Plugin::Web::CSRFDefender
cpanm Ukigumo::Agent Ukigumo::Server Ukigumo::Client
```

##### 2014/12/15 23:29追記

奇数番のperlバージョンで試していたところ，ひさいちくんからありがたいアドバイスが！！

{% tweet https://twitter.com/hisaichi5518/status/544499389964640258 %}

そういえば[@lamanotrama](https://twitter.com/lamanotrama)さんは，「5.16が落ち着いてるイメージがある」って言っていたような...初めからそっち使えばよかったんや．

### 社内VMでUkigumo::ServerとUkigumo::Agentを動かし，GH:Eからapi hookする

ペパボではmaglica[^2]という社内VM環境があり，そこでUkigumo用のサーバを用意することにしました．
また，GitHub Enterpriseを活用していることから，WebHookもgithub.comではなくGH:Eからすることに．
といっても，やることはGitHubとほぼ変わらず，Webhooks画面から登録するだけです．

![](/images/2014/12/15/webhook.gif)

### ukigumo-serverを起動する

社内VMなんで，そのまま80番ポートを使ってしまうことに．

```sh
ukigumo-server --port=80 --host=0.0.0.0 --max-workers=4 --config=/etc/ukigumo/config.pl
```

config.plの中身は以下と同じです．

> [Ukigumo入門 ― 2014年スタイル - その手の平は尻もつかめるさ](http://moznion.hatenadiary.com/entry/2014/05/02/181147)

### ukigumo-agentを起動する

ukigumo-agentの方が少し手間取ってしまいました．
認証が通らないとgit clone出来ないため，サーバの公開鍵をGH:Eに登録し，URLはhttpではなくgit urlを使うことに．

最初はhttpの方で試していたんですが，GH:EからWebHookがUkigumoサーバに届くものの，起動したClientがうまくGH:Eからclone出来ずにコケるという微妙なハマり方をしてしまっていました．ログを見ろって話ですね...

```sh
ukigumo-agent --port=2828 --server_url=http://127.0.0.1:80 --work_dir=/tmp/test-ukigumo-agent --force_git_url
```

### リポジトリに`.ukigumo.yml`を用意する

あとは`Dockerfile`をいれたリポジトリに，以下のような`.ukigumo.yml`を追加するだけでビルドが走ります．

```yaml
script: "docker build -t centos5/ngx_mruby-memcached ."
```

ちなみに用意したDockerfileは，memcached付きのngx_mrubyです[^3]．

### リポジトリをpushする

あとはリポジトリにpushすれば，GitHub/GH:EのWebHookがukigumo-agentに通知し，自動的にukigumoでテストが走ってくれます．

![](/images/2014/12/15/success.gif)

successが出てくれてよかった...ログにはdocker buildの様子が吐き出されています．

![](/images/2014/12/15/start.gif)

中略

![](/images/2014/12/15/finish.gif)

Dockerがインストールされていれば，ukigumo経由のコマンドで簡単に呼び出せるところまで出来ました．

## 終わりに

最初はJenkinsって大変そうだし，Ukigumo試してみようかなあという気持ちから入ったんですが，こっちはこっちでたくさんハマってしまいました...技術力が足りない．
最終的にはDockerというよりPerl，Perlというより依存関係にハマっただけの話になってしまいました．

もう少し先へ進めてDockerでビルドしたものをあーだこーだしたかったのですが，時間が足らず悲しい結果に...ただ，今後も改良は続け，都度報告していきたいと思いますm(_ _)m

明日16日目は[suu_g](http://qiita.com/suu_g)さんです．

[^1]: https://github.com/miyagawa/Twiggy/issues/27
[^2]: http://mizzy.org/slides/maglica/
[^3]: https://github.com/tacahilo/docker-ngx_mruby-memcached/blob/master/centos5/Dockerfile
