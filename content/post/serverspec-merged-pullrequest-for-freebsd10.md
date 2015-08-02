---
title: serverspecにpkgng (FreeBSD 10.0) 対応プルリクがmergeされた
date: 2014-02-16
tags:
- freebsd
- serverspec
---
[serverspecとspecinfra](http://serverspec.org/)に、FreeBSD 10.0から標準となったパッケージ管理システム`pkgng`への対応プルリクを送り、mergeしてもらった。

 * [Support FreeBSD 10 by tacahilo · Pull Request #349 · serverspec/serverspec](https://github.com/serverspec/serverspec/pull/349)
 * [Support FreeBSD 10 by tacahilo · Pull Request #54 · serverspec/specinfra](https://github.com/serverspec/specinfra/pull/54)

serverspec v0.15.3とspecinfra v0.5.8からの対応なので、FreeBSDユーザでserverspec利用者の方はアップデートをオススメする。

過去との互換性は壊していないので、このアップデートで過去のFreeBSDのリリースでserverspecが失敗することは無いはず
 (FreeBSD 10.0未満は`pkg_info`コマンド等でテストが走る。) 

## 雑談

`pkgng`は8.3, 8.4, 9.1, 9.2のバージョンにも対応しているが、デフォルトは10からになっているようだ。
そしてFreeBSD 10.0からは旧来のパッケージ管理用コマンド群は無くなってしまう。

> [___Official FreeBSD Binary Packages now available for pkgng___](http://lists.freebsd.org/pipermail/freebsd-pkg/2013-October/000107.html)
> 
> We have binary packages available for i386 and amd64 on
> 8.3,8.4,9.1,9.2,10.0 and 11 (head).
> 
> Pkg will be the default starting in FreeBSD 10.

今後もドキュメントとかソースコードを眺めながら、「あれ？ここFreeBSDじゃ動かない？」というところを見つけたらどんどんプルリクしていこうと思う。

それにしても、自分が提案したプルリクがmergeされると気持ちいいなあ。
