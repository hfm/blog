---
layout: post
date: 2015-02-11 21:31:40 +0900
title: Puppet Serverをインストールしてみる（だけ）
tags:
- puppet
---
PuppetlabsからPuppet Serverに関するスライドが上がっていた．

{% slideshare 44223836 %}

サブタイトルがどうも気になるけど，まあそれはいいとして，Puppet masterはもうすぐ役目を終えるらしい．
次世代PuppetサーバであるPuppet Serverは，より高いパフォーマンスを発揮するべく，これまでと大きく異なるアーキテクチャを採用している．

Puppet Serverの変更点や性能については，スライドの4ページ目以降を読んでもらうことにして，今回はPuppet Masterを触ってみようと思う．

## パッケージのインストール

Puppet Serverのパッケージインストール方法は，[puppetlabs/puppet-server](https://github.com/puppetlabs/puppet-server)のドキュメントに記載されている．

- https://github.com/puppetlabs/puppet-server/blob/master/documentation/install_from_packages.markdown

RHEL系なら，Puppet Serverは以下のようにインストール出来る．  
※`puppet-server`はPuppet Masterのことで，`puppetserver`がPuppet Serverなので注意．

```sh
sudo rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
sudo rpm -i http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum install -y puppetserver
```

{% tweet https://twitter.com/hfm/status/564399485933981697 %}

### Puppet Serverのメモリ使用量について

ところで，Puppet Serverはデフォルトで2GBもメモリを食う．

> Puppet Server is configured to use 2GB of RAM by default. If you'd like to just play around with an installation on a Virtual Machine, this much memory is not necessary. To change the memory allocation, please see Memory Allocation.
> 
> *[System Requirements](https://github.com/puppetlabs/puppet-server/blob/master/documentation/install_from_packages.markdown#system-requirements)*


流石にVagrantなどでお試しする時に2GBはしんどいので，Memory Allocation[^1]の設定に倣って512MBに変更する．

```diff
--- /tmp/puppetserver.orig      2015-02-08 21:28:43.238007319 +0900
+++ /etc/sysconfig/puppetserver 2015-02-08 21:29:23.332004504 +0900
@@ -6,7 +6,7 @@
 JAVA_BIN="/usr/bin/java"

 # Modify this if you'd like to change the memory allocation, enable JMX, etc
-JAVA_ARGS="-Xms2g -Xmx2g -XX:MaxPermSize=256m"
+JAVA_ARGS="-Xms512m -Xmx512m -XX:MaxPermSize=256m"

 # These normally shouldn't need to be edited if using OS packages
 USER="puppet"
```

あとはPuppet Serverを起動する．
javaが起動するので，puppetmasterと比べて起動に時間かかるなあという印象．

```sh
sudo service puppetserver start
```

## 適当に試してみる

何もmanifestsを用意してないけど，とりあえず適当にagentを叩いてみる．

```shell-session
[vagrant@localhost ~]$ sudo puppet agent --test --server localhost
Info: Caching certificate_revocation_list for ca
Info: Retrieving pluginfacts
Notice: /File[/var/lib/puppet/facts.d]/owner: owner changed 'puppet' to 'root'
Notice: /File[/var/lib/puppet/facts.d]/group: group changed 'puppet' to 'root'
Info: Retrieving plugin
Notice: /File[/var/lib/puppet/lib]/owner: owner changed 'puppet' to 'root'
Notice: /File[/var/lib/puppet/lib]/group: group changed 'puppet' to 'root'
Info: Caching catalog for localhost
Info: Applying configuration version '1423412703'
Info: Creating state file /var/lib/puppet/state/state.yaml
Notice: Finished catalog run in 0.01 seconds
```

拍子抜けするほど普通に動いた．
これだけでいいのか．

## 終わりに

今回はとりあえずインストールしてみよう，というだけが目的だったので，具体的な使い方やチューニング等は次回以降に回す．

あと，パフォーマンスや運用上の注意点などはまだなんとも言えないので，ドキュメント[^2]をある程度読んだら本番環境で試してみようと思う．

[^1]: https://github.com/puppetlabs/puppet-server/blob/master/documentation/install_from_packages.markdown#memory-allocation
[^2]: https://docs.puppetlabs.com/puppetserver/latest/services_master_puppetserver.html
