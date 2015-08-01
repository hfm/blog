---
title: sudoさん
date: 2014-03-01
tags: 
- sudo
---
会社のGitHub EnterpriseのIssueに書いたやつを、一部ちょっと表現を足して掲載。

深い理由があってCentOS 4をpackerでpackingしてるんですが、そのままbox作ってvagrant upしようとすると、sudoのバージョンが古く、`sudo -E`オプションが無くてログイン出来なくなります。

CentOS 6.5のman sudoより

> -E (preserve environment) オプションは sudoers(5) ファイルの env\_reset オプションを無効にする。これが使用できるのは、マッチするコマンドに SETENV タグが付いているときか、 sudoers(5) で setenv オプションがセットされているときだけである。

[@lamanotrama](https://twitter.com/lamanotrama)さんから教えていただいたのですが、これはVagrant 1.4系から起こる問題のようです。

どうしたものかと思ったら、なんとsudoの公式に大量のバイナリとソースが。

 * [__Download Sudo__](http://www.sudo.ws/sudo/download.html)

CentOS 4のi386, x86\_64アーキテクチャのRPMまである親切さ。

sudoさんありがとうございますという話でした。

### 余談

以下のメーリングリストによると、sudoに-Eオプションがついたのは1.6.9 rc1からのようですね。

> [[sudo-users] sudo 1.6.9 rc1 is now available](http://www.sudo.ws/pipermail/sudo-users/2007-July/003251.html)
> 
> o Added a -E flag to preserve the environment if the SETENV tag or the setenv option has been set.

ちなみにCentOS 4系では…

```console
# cat /etc/redhat-release
CentOS release 4.9 (Final)
# sudo -V | grep version
Sudo version 1.6.7p5
```

とほほ。
