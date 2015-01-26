---
layout: post
date: 2015-01-26 08:38:22 +0900
title: yum-plugin-prioritiesで地味にハマった話
tags:
- rhel
---
yum prioritiesプラグインの影響で，欲しいバージョンのパッケージがうまく入らなかったときの説明と対処法の話．

## TL;DR

- `yum-plugin-priorities`を入れていると，priorityの低い，別リポジトリの同一パッケージがどうも入らない
- priorityの低いパッケージが必要なときは`yum --noplugins`か`yum --disableplugin=priorities`で無効化する

## 背景

問題の起きた環境はAmazon Linuxだったんですが，同じ現象はCentOSでも再現できるので，今回はCentOSとepelで説明しようと思います．  
（あとコレにはまったのは，本当は[@lamanotrama](https://twitter.com/lamanotrama)さんだったんですが，代わりに説明しようと思います．黒田さんブログ書いて．）

- RHEL系OSで`yum-plugin-priorities` (RHEL5だと`yum-priorities`) をインストールしている
- puppetlabsのリポジトリをインストールしている (`puppetlabs-products``puppetlabs-deps`等)
- `puppetlabs`リポジトリと同名の`puppet`パッケージを持つリポジトリ(今回はepel)をインストールしている
    - Amazon Linuxの場合は，確かamzn-updatesとかだったと思います

## 問題

### その1. epelとpuppetlabsに同名パッケージが存在している

epelリポジトリの説明は省略．
puppetlabsはPuppet Labsが提供しているyumリポジトリで，puppet関連パッケージが入っています．

この2つのリポジトリには`puppet`という名前のパッケージがあります．

epelにはpuppet 2.7系が入っている：

```
[root@localhost ~]# yum info puppet
...
Available Packages
Name        : puppet
Arch        : noarch
Version     : 2.7.25
Release     : 2.el6
Size        : 1.1 M
Repo        : epel
...
```

puppetlabs-productsにはpuppet 3.7系が入っている：

```
[root@localhost ~]# yum info puppet
...
Available Packages
Name        : puppet
Arch        : noarch
Version     : 3.7.3
Release     : 1.el6
Size        : 1.6 M
Repo        : puppetlabs-products
...
```

### その2. yumのprioritiesプラグインがepelだけに入っていた

`yum-plugin-priorities`はその名の通りリポジトリの優先順位を設定するプラグインで，`priority=N`のNが小さいほど優先順位が高くなります．最も低い優先順位（デフォルト値）はN=99らしいです[^1]．


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

`disablerepo`と`enablerepo`を組み合わせて無効化する方法も考えたけど，無効化したリポジトリのパッケージを依存関係にもっているとインストールエラーを起こしてしまうので，一時的にプラグインの無効化するか，全てのリポジトリにpriorityを設定するのが吉だと思う．

```
--disableplugin=plugin
      Run with one or more plugins disabled, the argument is a comma separated list of wildcards to match against plugin names.

--noplugins
      Run with all plugins disabled.
      Configuration Option: plugins
```

[^1]: http://wiki.centos.org/PackageManagement/Yum/Priorities#head-2b4ed56250e5b102a8425ed10da778a00412ea96
