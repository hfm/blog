---
date: 2016-03-27T06:52:58+09:00
title: Puppet 3.x から 4.x にアップグレードする
draft: true
tags:
- puppet
---

https://docs.puppetlabs.com/puppet/4.4/reference/upgrade_major_pre.html

Puppet 4.x もいつの間にか 4.4 までリリースされ、 Puppet Server は 2.3 までメジャーバージョンアップしています。
Puppet ユーザならご存知かと思われますが、Puppet 4 からは Directory environmentsn という新しい環境

前準備
---

[Puppet 3.x to 4.x: Get Upgrade-Ready](https://docs.puppetlabs.com/puppet/4.4/reference/upgrade_major_pre.html#puppet-3.x-to-4.x:-get-upgrade-ready)に、Puppet 3.x から 4.x に上げるため、先にやっておくことリストが載っている。

### Puppet 3.8.x の最新版にあげておく

Puppet 3.x 系の、最新バージョンを使っておいたほうが、Puppet 4 とのギャップも少ない。

### Puppet Server 1.1.x の最新版にあげておく

