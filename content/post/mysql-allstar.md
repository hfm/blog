---
title: MySQL AllStarというVagrantboxを作った
date: 2014-03-02
tags:
- vagrant
- mysql
---
2014/2/27、ペパボにて[@glidenote](https://twitter.com/glidenote)先生主催のVagrant勉強会が行われました。

## packerでMySQLの各バージョンが入った箱を作った

### 資料

発表時からちょっと修正いれてるんですが、以下が資料です。

<script async class="speakerdeck-embed" data-id="bdf0333083ff0131024806957e15a8e9" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

### MySQL AllStar

Vagrant x VirtualBoxで動く __MySQL AllStar__ と名づけたvboxを公開しました。

 * [hfm/mysql-allstar](https://github.com/hfm/mysql-allstar)

CentOS 4, 5, 6の 32/64bit環境において、MySQL 4.0系から5.6系までの各バージョンが入ったボックスです。  
boxを一度に起動できるVagrantfileも入っているので参考にどうぞ。

 * https://github.com/hfm/mysql-allstar/releases/download/v0.1/centos4.8-i386-mysql-allstar.box
 * https://github.com/hfm/mysql-allstar/releases/download/v0.1/centos4.8-x86_64-mysql-allstar.box
 * https://github.com/hfm/mysql-allstar/releases/download/v0.1/centos5.10-i386-mysql-allstar.box
 * https://github.com/hfm/mysql-allstar/releases/download/v0.1/centos5.10-x86_64-mysql-allstar.box
 * https://github.com/hfm/mysql-allstar/releases/download/v0.1/centos6.5-i386-mysql-allstar.box
 * https://github.com/hfm/mysql-allstar/releases/download/v0.1/centos6.5-x86_64-mysql-allstar.box

### `vagrant up` => `<version>/bin/mysqld_safe`

ボックスを`vagrant up box`してsshログインすると、以下のようなレイアウトで各MySQLが入ってます。

```
/home/vagrant/mysql
├── 4.0.30
├── 4.1.25
├── 5.0.96
├── 5.1.73
├── 5.5.36
└── 5.6.16
```

それぞれ`mysql_install_db`は実行済みなので、`cd ~/mysql/<version>; bin/mysqld_safe&`するとMySQLが立ち上がります。

### モチベーション

仕事でMySQLのアップグレード作業をしているのですが、yumやrpmがめんどくさくて、初めから全部入ってるvboxがあればバンバン検証して壊すことも出来る！と思って作りました。

Dockerも考えたんですが、歴史的な理由で古いOSを使っている環境もありうるので、CentOS 4〜6 (32/64bit) 一通りあれば、そこそこ本番環境に近い状況を作りやすいかなあと。

ボックスを2つ起動して、マスタースレーブ構成を比較的簡単に出来るようにしたかったというのもあります。

### packer x mysql-build

ボックスのビルドには[Packer](http://www.packer.io/)を利用しました。

Packer自体は簡単なんですが、いかんせんOSのバージョンごとの差とか(kickstart等)が面倒で、結局のところOSのprovisionが大変という感想。
上のリポジトリにPacker用のファイルが入っております。ツッコミ大歓迎です。

各バージョンのビルドには、[@kamipoさん](https://twitter.com/kamipo)作のmysql-buildを使いました。
perl-buildやruby-buildのように、各バージョンのMySQLをビルド出来るツールです。
これが無ければこのvboxの完成はなかった…。

> #### [kamipo/mysql-build](https://github.com/kamipo/mysql-build)
> 
> mysql-build - provides a command to compile and install different versions of MySQL.

mysql-buildの使い方は、mysql-buildのREADMEの他、以下の同期のブログを参考にしました。

 * [mysql-buildつかってMySQL4.0.30をいれてみた - きたけーTechブログ](http://kitak.hatenablog.jp/entry/2013/10/07/092448)

## 今後やりたいこと

まだまだ荒いので、時間を見つけては手入れしていこうと思います。

 * MariaDBやPercona入りのバージョンも作る
 * 5.7系入りのも作る
