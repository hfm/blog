---
layout: post
date: 2015-01-29 09:16:53 +0900
title: yum-plugin-prioritiesのある環境で，priorityの低い別リポジトリにある同名パッケージを入れたい場合
tags:
- rhel
---
yum prioritiesプラグインの影響で，欲しいバージョンのパッケージがうまく入らなかったときの説明と対処法の話．

## TL;DR

- `yum-plugin-priorities`を入れていると，priorityの低い，別リポジトリの同一パッケージがどうも入らない
- priorityの低いパッケージが必要なときは`yum --noplugins`か`yum --disableplugin=priorities`で無効化する

## 前提

問題の起きた環境はAmazon Linuxだったんですが，CentOSでも再現できるので，今回はCentOSとepelで説明しようと思います．
（あとコレにはまったのは[@lamanotrama](https://twitter.com/lamanotrama)さんだったり...黒田さんブログ書いて）

- `yum-plugin-priorities`をインストールしている
- puppetlabs yumリポジトリと**同名の**`puppet`パッケージを持つリポジトリを有効化している(今回はepel)
- ※Amazon Linuxの場合は，確かamzn-updatesとかだったと思います

## 背景

### その1. epelとpuppetlabsに同名の`puppet`パッケージがある

epelリポジトリの説明は省略．
puppetlabsはPuppet Labsが提供しているyumリポジトリで，puppet関連パッケージが入っています．
そして，この2つのリポジトリには`puppet`という名前のパッケージがあります．

epelにはpuppet 2.7系が入っている：

- http://dl.fedoraproject.org/pub/epel/6/x86_64/puppet-2.7.25-2.el6.noarch.rpm

puppetlabs-productsにはpuppet 3.7系が入っている：

- http://yum.puppetlabs.com/el/6/products/x86_64/puppet-3.7.4-1.el6.noarch.rpm

### その2. epelの優先順位が高い

`yum-plugin-priorities`はその名の通りリポジトリの優先順位を設定するプラグインで，`priority=N`のNが小さいほど優先順位が高くなります．
最も低い優先順位（デフォルト値）はN=99らしいです[^1]．

今，以下のようにepel (N=10) > puppetlabs (N=99)という状況があるとします．

```ini
[epel]
name=Extra Packages for Enterprise Linux 6 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/6/$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
priority=10

[puppetlabs-products]
name=Puppet Labs Products El 6 - $basearch
baseurl=http://yum.puppetlabs.com/el/6/products/$basearch
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
enabled=1
gpgcheck=1
```

## 課題と解決

### puppetlabsリポジトリのpuppetを入れたい

上記のような状態で`yum install puppet`を実行すると，当然epelのpuppetがインストールされます．

そして厄介なのが，`yum install puppet-3.7.4`とバージョン番号を入力しても，それを無視して，epel側のリポジトリが優先されてしまうことです．

バージョン番号を無視するのは仕様なのかバグなのかはよく分かっておりませんが，Amazon LinuxとCentOSで再現出来たので，そういう現象として捉える必要がありそうです．

### yum-prioritiesを無視したい

以下のように，priorityの低いパッケージが必要なときは`--noplugins`か`--disableplugin=priorities`でプラグインを無効化することが出来ます．

```
--disableplugin=plugin
      Run with one or more plugins disabled, the argument is a comma separated list of wildcards to match against plugin names.

--noplugins
      Run with all plugins disabled.
      Configuration Option: plugins
```

なので，puppet 3系が欲しい場合は，以下のようなコマンドを使うとなんとかなりました．

```
yum --noplugins install puppet-3.7.4
yum --disableplugin=priorities install puppet-3.7.4
```

### おまけ

`disablerepo`と`enablerepo`を組み合わせて無効化する方法も考えたんですが，無効化したリポジトリのパッケージを依存関係にもっているとインストールエラーを起こしてしまうので，一時的にプラグインの無効化するか，全てのリポジトリにpriorityを設定するのが無難かなーという感じです．

[^1]: http://wiki.centos.org/PackageManagement/Yum/Priorities#head-2b4ed56250e5b102a8425ed10da778a00412ea96
