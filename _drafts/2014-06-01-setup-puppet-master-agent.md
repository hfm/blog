---
layout: post
title: そんなに難しくないPuppet Master/Agent構成
tags:
- puppet
---
Provisioning ToolsであるPuppetには、`puppet apply`と`puppet agent`というコマンドがあります。

どちらのコマンドにも共通しているのは、

## まずはVM 1台でやってみよう

```sh
yum install -y puppet puppet-server
/etc/init.d/puppetmaster start
```

## 次はVM 2台、でもやることは変わらないんだぜ

o
