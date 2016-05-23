---
date: 2016-05-03T07:44:56+09:00
title: Beaker を使って Puppet の受け入れテストを書く
draft: true
tags:
- puppet
- test
---
最近、Puppet モジュールをよく書くようになってきました [^1]。会社で使っているモジュールをOSS化することで、機会が増えてくると、必然的にテストを書く機会・時間も増えてきた。構成管理ツールのテストの代表的プロダクトといえば Serverspec はまず挙がると思う。

* Provisioning
* Validation
* Configuration
* Testing
* Tests
* Post-Suite
* Reverting
* Cleanup

Beaker は Puppet 社 [^2] が開発している受け入れテストツールである。

- [puppetlabs/beaker: Puppet Acceptance Testing Harness](https://github.com/puppetlabs/beaker)

Chef でいう Test Kitchen + InSpec といったところで、VMのセットアップからプロビジョニングやテスト実行、事後処理などを一気通貫で行ってくれる。

[^1]: https://forge.puppet.com/hfm
[^2]: 最近Puppetlabsから社名変更した
