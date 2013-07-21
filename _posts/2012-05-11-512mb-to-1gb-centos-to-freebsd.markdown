---
layout: post
title: さくらVPS512からさくらVPS1GBへ、CentOSからFree BSDへ移行しました
categories:
- Notification
tags:
- Diary
- FreeBSD
- SakuraVPS
status: publish
type: post
published: true
meta:
  _jd_tweet_this: ''
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: ''
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: ''
  _jd_wp_twitter: ''
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
---
タイトルの通り、使っていたサーバをさくらVPS512からさくらVPS1GBへ、CentOSからFree BSDへ移行しました。FreeBSD 9.0-RELEASE (amd64)です。メモリは1GBへ、HDD容量は100GBへパワーアップしたおかげで、前よりパワフルな環境が手に入りました。

OSを移行するにあたり、ports collectionの使い方に悪戦苦闘したり、wordpressの移行するにあたってnginxのパフォーマンスチューニングもうちょっと頑張れるかなやってみようあれ意外と難しいぞバックエンドとフロントエンドで何やってるか分からなくなってきたぞあれあれキャッシュを取ってきてないからHTMLは表示されるけどCSSとJSは壊滅だぞデータベースにポスグレどうかなうわあめんどいMySQLに出戻りだmemcachedとか入れてみたぜなにこれリバースプロキシ使えばほとんどいらねーじゃん…みたいな出来事があり、諸々の事情で作業が中断されまくった結果2ヶ月くらい時間がかかってしまいました。

まだ万全の出来とはいえない（CDNのCloud Flareをもうちょっと上手に設定したい）ので、ちょこちょこいじって、溜まったネタを投下していく所存です。
