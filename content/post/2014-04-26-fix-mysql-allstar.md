---
layout: post
title: MySQL AllStar v0.2
tags:
- mysql
- vagrant
---
MySQL 4.0から5.6までの各バージョンを1つのVMに納めたMySQL AllStarというVagrantboxを以前作ったのですが、少し修正を加えました。

 * [tacahilo/mysql-allstar](https://github.com/tacahilo/mysql-allstar)
 * [MySQL AllStarというVagrantboxを作った | blog: takahiro okumura](/2014/03/02/mysql-allstar/)o

## 変更点

### CentOS 4 boxの廃止

大分メンテが辛いので捨てました。
chef入らないし、puppetも0.25.6-1.el4というとんでもなく古いバージョンだし、provisioningスクリプトも複雑になるしで、良いことがないので止めました。

### 各バージョンのmy.cnfの設置

`/etc/my.cnf`や各MySQLのバージョンに対応したmy.cnfが無かったので設置しました。

`/etc/my.cnf`は以下のように、ユーザをvagrantにしただけです。
本当はmysqlユーザがいいんだと思うんですが、mysql-buildから作成している関係で、mysqlユーザがいないんですよね。

あくまで検証用に使うVMという位置づけなので、接続するユーザはなんでもいいかなと。

```ini
[client]
user = vagrant

[mysqld]
user = vagrant

[mysqlhotcopy]
interactive-timeout

[mysqldump]
quick
```

MySQL AllStarに入っている各MySQLは`/home/vagrant/mysql/<VERSION>`以下に入っています。
バージョンによって対応してないオプションやsocketの場所を分離するために、固有のオプションは`<VERSION>/etc/my.cnf`に設置しています。

### vagrantcloudに対応

対応っていうほど大したものじゃないですが、`vagrant init hfm4/CentOS6.5-x86_64-mysql-allstar`みたいに起動できるようにvagrantcloudにboxを追加しました。

 * https://vagrantcloud.com/hfm4/CentOS5.10-i386-mysql-allstar
 * https://vagrantcloud.com/hfm4/CentOS5.10-x86_64-mysql-allstar
 * https://vagrantcloud.com/hfm4/CentOS6.5-i386-mysql-allstar
 * https://vagrantcloud.com/hfm4/CentOS6.5-x86_64-mysql-allstar

### その他

あとはMySQL 5.5と5.6でmysql\_install\_dbがコケてしまう問題や、細かなバグを直してました。
それと、検証用VMのつもりなのであまり関係ありませんが、chefやpuppetの最新バージョン、opensslの問題などの修正も含まれてます（`yum update`しただけ。）

MySQLのバージョンアップをする上で、検証用に各バージョンが1個のVMに入っているとありがたいなあと思って作ったVM Boxですが、今後もなんかあったら直していこうと思います。
