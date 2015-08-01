---
date: 2014-12-04T00:00:00+09:00
title: ngx_mruby(memcached付)をCentOS/SLでビルドする時のハマりどころと直し方について
tags: 
- mruby
- nginx
- rhel
- memcached
---
この記事は[mod_mruby ngx_mruby Advent Calendar 2014 - Qiita](http://qiita.com/advent-calendar/2014/mod-ngx-mruby)4日目の記事です．

昨日は[hkusu](http://qiita.com/hkusu)さんの「[AWS - mod_mruby を Amazon EC2、Apache2.4 へ導入する《Advent Calendar 2014》](http://qiita.com/hkusu/items/ca8622c83b0bfc2cac72)」でした．

いわゆるWeb業界でインフラエンジニアを1年半ほどやっているのですが，元々，資源の制御 (control)・制限 (limitation)・分配 (distribution)といった分野に志向しており，（とはいっても優秀では無いし仕事が忙しくて時間はまるで避けていないのだから，ただの言葉に過ぎません，）mruby並びにmod\_mruby, ngx\_mrubyらが取り巻く環境を期待せずにいられません．

さて，つまらない前置きはさておき，本題を話します．要件は以下のとおりです．

### 要件

- CentOSやScientific Linuxで **[matsumoto-r/ngx_mruby](https://github.com/matsumoto-r/ngx_mruby)** をビルドしたい
- redisではなく **memcached** を利用したい

これら要件を満たすにあたって生じた課題とその解決策について共有したいと思います．
とはいえ，生じた課題というのも，本質的にはたった1つしかありません．

## 環境が古いという課題

さて，CentOSやScientific Linuxの生態系が非常に古いパッケージ群によって成り立っていることは周知のことと思われます．
そのため，新しいアーキテクチャを導入しようとする際に，これらパッケージの古さのせいで利用するまでに苦労することが少なくありません．

RHEL5, 6系でngx_mrubyをビルドしようとした際に，以下の2つの「古さ」に衝突してしまいました．

### libmemcached-develが古い

正確なエラーメッセージを忘れてしまったのですが，baseリポジトリに入っているlibmemcached-devel 0.31を使ってビルドしようとすると， memcached_behavior_tが宣言されていないと言われて失敗してしまいます．

これはlibmemcached-develのバージョンが古いのが原因で，remiリポジトリから新しいlibmemcached-develパッケージをインストールすることで解決します．

```sh
rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
rpm -ivh     http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
rpm -ivh     http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

yum -y install --enablerepo=remi libmemcached-last-devel
```

RHEL5系と6系では，libmemcachedのdevelパッケージ名が異なることに注意してください．
何故か6系では`last`という文字がついていますが，5系は`libmemcached-devel`です．

```sh
rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-5
rpm -ivh     http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
rpm -ivh     http://rpms.famillecollet.com/enterprise/remi-release-5.rpm

yum -y install --enablerepo=remi libmemcached-devel
```

### system rubyが古い

ngx_mrubyはRuby 1.9以上でしかビルドできません．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/hfm">@hfm</a> 昔は1.8以上でビルドできるようにしていたのですが、前に1.9以上に変更になりました… CentOSでやると色々ハマるので、ある意味理解深まりますね…ubuntuだと何も迷わずビルドできるので楽ですが。</p>&mdash; MATSUMOTO, Ryosuke (@matsumotory) <a href="https://twitter.com/matsumotory/status/531055848844324864">2014, 11月 8</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

この問題は，ruby-build等を使って，1.9以上のRubyを利用することで解決します．

```sh
cd /usr/local/src
git clone https://github.com/sstephenson/ruby-build.git

# ruby 1.9以上を用意する
cd /usr/local/src/ruby-build
./install.sh
ruby-build 2.1.5 /usr/local/ruby21
export PATH=/usr/local/ruby21/bin:$PATH
```

## redis/vedisからmemcachedに切り替える

ngx_mrubyでmemcachedを利用するためには，[build_config.rb](https://github.com/matsumoto-r/ngx_mruby/blob/master/build_config.rb)を編集する必要があります．
（デフォルトではmruby-redis, mruby-vedisが有効化されており，mruby-memcachedはコメントアウトされています．）

エディタを開いて編集するのはやや面倒なので，perl3行で実現します．

```sh
cd /usr/local/src
git clone --recursive https://github.com/matsumoto-r/ngx_mruby.git
git clone https://github.com/nginx/nginx.git
cd /usr/local/src/ngx_mruby

# redis/vedisを無効化して，mruby-memcachedを有効化する
perl -i -pe 's/(conf.gem.+mruby-redis)/#$1/' build_config.rb
perl -i -pe 's/(conf.gem.+mruby-vedis)/#$1/' build_config.rb
perl -i -pe 's/#(conf.gem.+mruby-memcached)/$1/' build_config.rb

NGINX_SRC_ENV='/usr/local/src/nginx' sh build.sh
make
make install
```

## 終わりに

ここまでの手続きを踏めば，RHEL5, 6系でもngx_mrubyをビルドすることが出来るようになります．
（これ以外のrubyやngx_mrubyをビルドするために必要なパッケージについては省略していますが．）

あと，これはおまけになりますが，CentOS5, CentOS6, Scientific Linux6の環境においてngx_mrubyをビルドするための **Dockerfile** を公開しています．

- [tacahilo/docker-ngx_mruby-memcached](https://github.com/tacahilo/docker-ngx_mruby-memcached)

nginxのconfigure optionsが個人的な用途に基づいているので，汎用性にはやや欠けますが，似たような環境でngx_mrubyをビルドしたい方がいらっしゃいましたら，ご参考にどうぞ．

明日5日目は[Marcy](http://qiita.com/Marcy)さんの「[ISUCON4予選問題をngx_mrubyだけで解いてみた（ノウハウ編）](http://qiita.com/Marcy/items/1a7ab35970c31d169bf8)」になります。
