---
date: 2015-01-28T17:19:36+09:00
title: yum-changelogの使い方をいっつも忘れるのでメモしておく
tags:
- rhel
---
glibcのGHOST[^1]対応時のこと．

yumからglibcのCHANGELOGが読みたいんだけど，**yum-changelog**パッケージ[^2]の使い方をいっつも忘れる．
毎回`man 1 yum-changelog`や`yum help changelog`で確かめているので，いい加減メモをとろう．

使い方はこう．

```
yum changelog <date>|<number>|all <package>
```

この`<date>|<number>|all`ってのが自分にとっては曲者で，ここを忘れて`yum changelog glibc`とかやっても表示されない．

- `<date>`は日付指定で，`2014-12`なら2014年12月**以降**のCHANGELOGを検索する．
- `<number>`は個数指定で，指定した数だけCHANGELOGを新しい順に出してくれる．
- `all`はすべてのCHANGELOGを出力する．

GHOSTでいえば，glibcの最新のCHANGELOGが対応パッチだろうということで，`yum changelog 1 glibc`してみる．

```
[hfm@work ~]$ yum changelog 1 glibc
読み込んだプラグイン:changelog, fastestmirror, security
Loading mirror speeds from cached hostfile
 * base: www.ftp.ne.jp
 * extras: www.ftp.ne.jp
 * updates: www.ftp.ne.jp

Listing 1 changelog

==================== Installed Packages ====================
glibc-2.12-1.149.el6_6.4.x86_64          installed
* Wed Dec 10 21:00:00 2014 Carlos O'Donell <carlos@redhat.com> - 2.12-1.149.4
- Fix recursive dlopen() (#1173469).


==================== Available Packages ====================
glibc-2.12-1.149.el6_6.5.i686            updates
* Mon Jan 19 21:00:00 2015 Siddhesh Poyarekar <siddhesh@redhat.com> - 2.12-1.149.5
- Fix parsing of numeric hosts in gethostbyname_r (CVE-2015-0235, #1183533).

changelog stats. 3 pkgs, 2 source pkgs, 2 changelogs
```

この通り，**Available Packages**のところにアップデート可能なパッケージと，そのCHANGELOGが表示されている．
"CVE-2015-0235"はGHOSTのCVE番号なのでドンピシャ．

ちなみに`yum update --changelog glibc`とかでも確認できるんだけど，これは意図せず`y`押したらアップデートされてしまうので，結構危ないコマンドだと思っている．
こういう目的外の効果を発揮しかねないコマンドは，リスクと判断して，極力使用を控えるのが自分ルールだったりする．

[^1]: https://access.redhat.com/articles/1332213
[^2]: http://linux.die.net/man/1/yum-changelog
