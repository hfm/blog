---
date: 2015-09-18T03:09:05+09:00
title: 大規模分散ファイルシステム MogileFS 入門 2015
cover: /images/mogilefs.png
draft: true
tags:
- perl
- mogilefs
---
MogileFS[^1] はオープンソースの分散ファイルシステムである。

（前口上）写真共有サービス 30days Album[^1]（以降、デイズ）では、画像ストレージとしてこの MogileFS を採用しており[^2][^3][^4]、最近では、これを社内用 Private S3 として用途を拡大させた Bayt (ベイト) というプロダクトをリリースした[^5][^6]。

デイズは、総容量にして 800TB を超えるデータを保持している。
不運が重なりデータを4個ロストした経験を持つが、
システム全体として見ても優れた耐久性と高い稼働率を維持している。

公式ドキュメント[^7]がそれなりに充実していることや、そもそも分散ファイルシステムの利用者が少ないこともあるだろうが、MogileFS の国内の資料は多く無い。

2008年からデイズを支え続けてきた技術を、誰に知らされることもなくそのままにしておくことはもったいないと感じたので、『MogileFS 入門 2015』 と銘打って、分かった気になれるような紹介を試みる。
なお、「入門」と書かれた書物や文章の多くが、あまり入門者を見ていないのではといった疑惑もあるが、それについては目を向けないことにする。（はたして MogileFS の戸を叩くものがこの時代に現れるのかどうか、そもそもニーズがわからないのだから、逆にいくらでも入門だの実践だの上級編だのと言ってのけられるというものだ。）

目次
---

- アーキテクチャ編
- コミュニティ編
- インストール編
- チューニング編
- カスタマイズ編
  - mogstored
  - cmogstored

アーキテクチャ編
---

![MogileFS Architucture](/images/mogilefs-architecture.png)

http://code.google.com/p/mogilefs/ のトップページに書かれるような特徴を備えている。

- アプリケーションとして動作する
- 単一障害点 (SPoF) が無い
- 自動的なファイル複製機能
- "RAID より良い"
- Flat Namespace
- Shared-Nothing
- No RAID required
- Local filesystem agnostic

### アプリケーションとして動作する

特別なカーネルモジュールは不要

### SPoF が無い

all three components of a MogileFS setup (storage nodes, trackers, and the tracker's database(s)) can be run on multiple machines, so there's no single point of failure. (you can run trackers on the same machines as storage nodes, too, so you don't need 4 machines...) A minimum of 2 machines is recommended.

### 自動的なファイル複製機能

files, based on their "class", are automatically replicated between enough different storage nodes as to satisfy the minimum replica count as requested by their class. For instance, for a photo hosting site you can make original JPEGs have a minimum replica count of 3, but thumbnails and scaled versions only have a replica count of 1 or 2. If you lose the only copy of a thumbnail, the application can just rebuild it. In this way, MogileFS (without RAID) can save money on disks that would otherwise be storing multiple copies of data unnecessarily.

### "RAID より良い"

in a non-SAN RAID setup, the disks are redundant, but the host isn't. If you lose the entire machine, the files are inaccessible. MogileFS replicates the files between devices which are on different hosts, so files are always available.

### Flat Namespace

Files are identified by named keys in a flat, global namespace. You can create as many namespaces as you'd like, so multiple applications with potentially conflicting keys can run on the same MogileFS installation.

### Shared-Nothing

MogileFS doesn't depend on a pricey SAN with shared disks. Every machine maintains its own local disks.

### No RAID required

Local disks on MogileFS storage nodes can be in a RAID, or not. It's cheaper not to, as RAID doesn't buy you any safety that MogileFS doesn't already provide.

### Local filesystem agnostic

Local disks on MogileFS storage nodes can be formatted with your filesystem of choice (ext3, XFS, etc..). MogileFS does its own internal directory hashing so it doesn't hit filesystem limits such as "max files per directory" or "max directories per directory". Use what you're comfortable with.

コミュニティ編
---

コードとドキュメント、コミュニティの所在について。

MogileFS は Perl 製プロダクトなので CPAN 経由での入手が可能である。

開発中のコードは GitHub にある。
しかし、ドキュメントは Google Code の Wiki にある。
そしてプルリクエストを送るのは GitHub かメーリングリスト（後者が推奨らしい）となっており、一見まとまっていない。

Google Code は2016年1月25日にサービスを完全終了する。
完全終了というのは、データへのアクセスが出来なくなることを意味する。


インストール編
---

aa

チューニング編
---

aa

カスタマイズ編
---

aa

おわりに
---

本記事では、分散ファイルシステムである MogileFS の仕組みを紹介し、

おまけ
---

MogileFS という名称の由来は、*"OMG FILES"* のアナグラムである。

[^1]: http://code.google.com/p/mogilefs/wiki/Start?tm=6 によると、MogileFS は OMG FILES のアナグラムだそうだ。
[^1]: https://30d.jp/
[^2]: http://www.slideshare.net/mizzy/2008-30days-album-presentation
[^3]: http://www.slideshare.net/hiboma/yapc-asia-2009-perl
[^4]: http://www.slideshare.net/kyanny/inside-30days-albumlaterstory-5452817
[^5]: http://www.slideshare.net/lamanotrama/mogilefsprivate-s3
[^6]: http://www.slideshare.net/hiboma/mogilefs-private-s3-api
[^7]: https://github.com/hfm/mogilefs/blob/wiki/Start.md
[]: https://github.com/mogilefs/
[]: https://groups.google.com/forum/#!forum/mogile
[]: http://googledevjp.blogspot.jp/2015/04/google-code.html
