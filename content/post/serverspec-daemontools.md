---
date: 2014-12-25T11:43:00+09:00
title: Serverspecでdaemontoolsのテストが可能になった
tags: 
- serverspec
---
本日、以下の3つのPRがmergeされ、Serverspec/Specinfraで[daemontools](http://cr.yp.to/daemontools.html)経由のサービスチェックが可能になりました。

- [Support daemontools by tacahilo · Pull Request #284 · serverspec/specinfra](https://github.com/serverspec/specinfra/pull/284)
- [Support daemontools by tacahilo · Pull Request #497 · serverspec/serverspec](https://github.com/serverspec/serverspec/pull/497)
- [Add descriptions for service resource (upstart, daemontools) by tacahilo · Pull Request #36 · serverspec/serverspec.github.io](https://github.com/serverspec/serverspec.github.io/pull/36)

このマッチャを利用するための前提は以下のとおりです。

- `svstat`がサーバに用意されている
- `/service/`以下にdaemontools経由のファイルがある

これらの条件の元、以下のようにテストを実行することが出来ます。

```rb
describe service('ntpd') do
  it { should be_running.under('daemontools') }
end
```

ペパボのサービスでdjb-wareの[cr.yp.to/daemontools.html](http://cr.yp.to/daemontools.html)を使っていて、daemontools経由のサービスのrunnning or notな状況が知りたかったのでPRしたのでした。

テストツールもっと充実させてこ!
