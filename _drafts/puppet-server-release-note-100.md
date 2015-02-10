---
layout: post
date: 2015-02-09 03:32:55 +0900
title: Puppet Server 1.0.0 のリリースノートを読んだ
tags:
- puppet
---
[Puppet Server 1.0.0のリリースノート](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-100)を読んだ．

## Puppet Serverのバージョニング

Puppet Serverは[Semantic Versioning](http://semver.org)を採用しており，
> This release is the official “one point oh” version of Puppet Server. In accordance with the Semantic Versioning specification, we’re declaring the existing public API of this version to be the baseline for backwards-incompatible changes, which will trigger another major version number. (No backwards-incompatible changes were introduced between 0.4.0 and this version.)


## おまけ

Puppet Serverが1.0.0になるまでに，以下のリリースがあったらしい（ざっくり説明付きで．）

- [0.2.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-020) ... OSSとしての最初のリリース
- [0.2.1](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-021) ... CVE-2014-7170 への対応
- [0.2.2](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-022)
  - reportプロセスの処理中のファイルディスクリプタのリークを修正（なんだそれは...）
  - the Apache 2.0 Licenseのライセンスを追記 [puppetlabs/puppet-server#196](https://github.com/puppetlabs/puppet-server/pull/196)
- [0.3.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-030)
  - 低メモリなシステムで起動した時のエラーメッセージを改善
  - HTTP Basic認証をサポートし，reportプロセッサのバグを修正 [puppetlabs/puppet-server#217](https://github.com/puppetlabs/puppet-server/pull/217)
- [0.4.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-040) ... SSLやsystemd周りの改善
