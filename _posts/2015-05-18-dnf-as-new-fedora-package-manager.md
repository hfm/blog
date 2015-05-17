---
layout: post
date: 2015-05-18 07:33:30 +0900
title: Yumに替わる新たなパッケージマネージャ・DNFの覚書
tags:
- linux
---
Fedora 22より、デフォルトのパッケージマネージャが変更されるらしい。
RedHat系のパッケージマネージャといえばYumだったが、これからは [DNF (Dandified yum)](https://fedoraproject.org/wiki/Features/DNF) という次世代パッケージマネージャに替わる。

Fedoraを使ったことが無かったので全く知らなかったのだが、以下の象徴的なタイトルのブログを契機に知ることが出来た。

[Yum is dead, long live DNF | DNF](http://dnf.baseurl.org/2015/05/11/yum-is-dead-long-live-dnf/)

この記事が出た理由は、ブログ投稿と同日の2015/05/11に、DNF 1.0がリリースされたことだろう。
既存の要件を満たし、いよいよ乗り換え準備が出来たというメッセージだ。

[DNF 1.0 and DNF-PLUGINS-CORE 0.1.7 Released | DNF](http://dnf.baseurl.org/2015/05/11/dnf-1-0-and-dnf-plugins-core-0-1-7-released/)

何故、YumでなくDNFなのか
---

DNFは2012年にYumのフォークプロジェクトとして開始した [^1]。
何故このプロジェクトが開始したのか、[Yum is dead, long live DNF](http://dnf.baseurl.org/2015/05/11/yum-is-dead-long-live-dnf/)によると、3つの理由があるという。

1. Undocumented API (APIドキュメントに乏しい)
1. Broken dependency solving algorithm (依存解決アルゴリズムが壊れている)
1. Inability to refactor internal functions (内部関数がリファクタリング不能)

これらのような根本的な課題を解決するために、新たなパッケージマネージャの開発に乗らざるを得なかったのだろう。

また、個人的には以下の一文が結構な重みを持っているようにも感じた。

> Yum would not survive the “Python 3 as default” Fedora initiative meanwhile DNF is able to run on Python 2 and Python 3.

DNFは今のところ、Python 2系、3系のそれぞれでの動作が保証されているらしい (おそらく将来的にはPython 3系のみをサポートするのだろう。)

DNFを試してみる
---

DockerのFedora公式パッケージはrelease 21だったので、[fedora-upgrade](https://fedoraproject.org/wiki/Upgrading_Fedora_using_yum#fedora-upgrade)を使ってrelease 22にアップグレードした。

### yumコマンドはdeprecatedに

Fedora 22でyumコマンドを使おうとすると、以下のような警告が最初に表示された (ちなみにFedora 22をclean installすると、yumコマンドそのものが無いらしい。)

```console
# yum
Yum command has been deprecated, redirecting to '/usr/bin/dnf '.
See 'man dnf' and 'man yum2dnf' for more information.
To transfer transaction metadata from yum to DNF, run:
'dnf install python-dnf-plugins-extras-migrate && dnf-2 migrate'
```

### yumで出来ることのほとんどはdnfでも出来る

まあ当たり前といえば当たり前で、dnfにしたからといってユーザ側が特に構えるところは無さそう。

[Changes in DNF plugins compared to Yum plugins](http://dnf.readthedocs.org/en/latest/cli_vs_yum.html#changes-in-dnf-plugins-compared-to-yum-plugins)や[Changes in DNF plugins compared to Yum utilities](http://dnf.readthedocs.org/en/latest/cli_vs_yum.html#changes-in-dnf-plugins-compared-to-yum-utilities)を見る限り、プラグインやユーティリティ群の移行も進んでいるようなので、Yumで使ってたプラグインが使えなくなった！という心配も少なそう。

```console
# dnf
You need to give some command
usage: dnf [options] COMMAND

List of Main Commands

autoremove
check-update              Check for available package upgrades
clean                     Remove cached data
distro-sync               Synchronize installed packages to the latest available versions
downgrade                 downgrade a package
group                     Display, or use, the groups information
help                      Display a helpful usage message
history                   Display, or use, the transaction history
info                      Display details about a package or group of packages
install                   Install a package or packages on your system
list                      List a package or groups of packages
makecache                 Generate the metadata cache
provides                  Find what package provides the given value
reinstall                 reinstall a package
remove                    Remove a package or packages from your system
repolist                  Display the configured software repositories
repository-packages       Run commands on top of all packages in given repository
search                    Search package details for the given string
updateinfo                Display advisories about packages
upgrade                   Upgrade a package or packages on your system
upgrade-to                Upgrade a package on your system to the specified version

List of Plugin Commands

migrate                   migrate yum's history, group and yumdb data to dnf
```

強いて言えば、Ansible, Chef, Puppetのような構成管理ツールの側でこの変更による対応がいずれ迫られるかもしれないということ。
そしてこれら構成管理ツールの利用者は、対応が完了するまでOSの移行がちょっとしづらくなる、ということだろうか。

終わりに
---

変更点やそれによる恩恵はたくさんありそうだが、APIドキュメントの充実がプラグインの開発環境を良くすることや、予期せぬの依存解決の破損が解消されるなど、コマンド名を除けばユーザにとってのメリットは多そうだという印象。

いずれはCentOS等にも乗っかってくるだろうけど、まだまだ先のことだろうか。

[^1]: http://fedoraproject.org/wiki/Changes/ReplaceYumWithDNF#Detailed_Description
