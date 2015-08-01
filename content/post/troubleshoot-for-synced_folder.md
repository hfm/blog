---
layout: post
title: vagrant upでsynced_folderが失敗した時の対処
date: 2014-03-03
tags:
- vagrant
---
[MySQL AllStar](https://github.com/tacahilo/mysql-allstar)を作成した後に、似たようなノリでCentOS 6.5 with Docker + Chef + Puppetなboxを作りました。

 * [tacahilo/centos-with-docker](https://github.com/tacahilo/centos-with-docker)
 * https://github.com/tacahilo/centos-with-docker/releases/download/v1.0/centos6.5-x86_64-docker.box
   * docker-io
   * chef
   * puppet入り

ちなみに上記のboxは、Chef使いな方でもPuppet使いな方でも、お気軽にDockerを始めたい！というコンセプトです。
自分でboxを作ると、どういう手順で作ったかを知っているので割と安心出来ます。

## ときどきsynced\_folderに呪われる

ところでvirtualbox用に作ったboxをvagrant upしようとすると、たまに以下のエラーが出ます。

```console
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
...
[default] Mounting shared folders...
[default] -- /vagrant
Failed to mount folders in Linux guest. This is usually beacuse
the "vboxsf" file system is not available. Please verify that
the guest additions are properly installed in the guest and
can work properly. The command attempted was:

mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` /vagrant /vagrant
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` /vagrant /vagrant
```

このエラー、Packerでのbox作成時にVBoxGuestAdditionsを使ってkernel modulesをビルドしたにも関わらず発生してしまいます。
出る時と出ない時があるのも困りもの。

他の方の調査を拝見させていただくと、どうやらVirtualBoxのGuestAdditionsに問題があるのかも、とのこと。

 * [Vagrantでsynced_folderがマウントされない件 | 俺のメモ](http://blog.elkc.net/?p=848)
 * [ヾ(oﾟωﾟo)ﾉﾞVagrantの共有ディレクトリ設定でものすっごい躓いた！ - Qiita](http://qiita.com/harapeko_wktk/items/72985bfccaae60c69384)

## 大体これでうまくいった

大分ハマってしまったんですが、以下の手順を踏むと大体上手くいくことが分かってきました。

```console
$ vagrant ssh -c 'sudo /etc/init.d/vboxadd setup'
$ vagrant reload
```

どうもVirtualBox Guest Additions kernel modulesのshared folder support moduleがうまく行っていないのかなあと。

ちなみにsynced\_folderが失敗するときは、`sudo /etc/init.d/vboxadd status`すると起動しておらず、`satrt`しても何故か失敗してしまうという変な状態になります。

ちなみに、kernel modulesをリビルドしなくても、以下のサービスが`3:on`の状態で再起動を掛けると成功することもあります。

```console
$ chkconfig | grep vboxadd
vboxadd         0:off   1:off   2:on    3:on    4:on    5:on    6:off
vboxadd-service 0:off   1:off   2:on    3:on    4:on    5:on    6:off
vboxadd-x11     0:off   1:off   2:off   3:on    4:off   5:on    6:off
```

とはいえ、もうちょっとマシなやり方は無いものかと…。
Vagrantでvboxを扱うときには遭遇しやすい問題なので、自分でも色々調べていこうと思います。
