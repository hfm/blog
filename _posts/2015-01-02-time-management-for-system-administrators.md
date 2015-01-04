---
layout: post
date: 2015-01-02 11:58:11 +0900
title: 「エンジニアのための時間管理術」を読んだ
tags:
- book
---
オライリーの「エンジニアのための時間管理術」を読み終えた．
誤解を恐れずに言ってしまえばライフハック系の本である．

[![エンジニアのための時間管理術](http://ecx.images-amazon.com/images/I/51jWtxU0sAL.jpg)](http://www.amazon.co.jp/exec/obidos/ASIN/4873113075/hifumis-22/ref=nosim/)  
[エンジニアのための時間管理術](http://www.amazon.co.jp/exec/obidos/ASIN/4873113075/hifumis-22/ref=nosim/)  

## 目次

- 1章 タイムマネジメントの原則
- 2章 集中と割り込み
- 3章 ルーチン
- 4章 サイクルシステム
- 5章 サイクルシステム: 作業リストとスケジュール
- 6章 サイクルシステム: カレンダーの管理
- 7章 サイクルシステム: 人生の目標
- 8章 優先順位
- 9章 ストレスの管理
- 10章 電子メールの管理
- 11章 時間の浪費
- 12章 文書化
- 13章 自動化

## 本書の対象読者について

### "System Administrators"と「エンジニア」

原題は "Time Management for System Administrators" で，"System Administrators" が「エンジニア」に置き換えられている．
これらの具体像は，「本書の対象読者」を見れば分かるだろう．
本書には以下のように書かれている．

> 本書は、IT技術者、システム管理者、ネットワーク管理者、オペレータ、ヘルプデスク担当者、その他IT産業において同様の肩書きを持つ人々を対象としています。
> 
> *「はじめに」 xvii頁 より*

### プログラマとエンジニア

そして実は，本書は「プログラマ」を対象としていない．

> 本書はプログラマを対象としていません．
> ...
> プログラマは別の問題を抱えているので、プログラマを対象とした本を読むべきだと筆者は考えます。
> 
> *「はじめに」 xvii頁 より*

プログラマとエンジニアの違いについては（上手な説明が浮かばないので）他に譲るとして，「1章 タイムマネジメントの原則」冒頭において，システム管理者についてこんな説明がある．

> システム管理者 (SA) であるあなたには、絶えずじゃまが入るはずです。電話が鳴るし、顧客がやってきて質問をするし、メーラーが新しいメッセージを受信してピーピー言うし、インスタントメッセンジャー (IM) があなたの注意を引こうとします。
> 
> *1章 タイムマネジメントの原則 1頁 より*

### 私はこれに当てはまるか？

自分を例をあげると，私はペパボでインフラエンジニアをしている（職種はエンジニアだが）．

業務では，メーカーやベンダー（の営業）からの電話が鳴り響き，GitHub/GH:E に耐えずコミットが流れ，プルリクエストでレビュー依頼とレビューが飛び交い，メーリングリストは落ち着かず，顧客からの問い合わせは毎日届くし，何よりIRCにそれらの通知がシャワーのごとく降ってくる．
終いには，サーバ障害でアラートは極大化する．

このような環境は，間違いなく「絶えずじゃまが入る」環境といえるだろう．

この例はちょっと意地悪く言ってみただけなので，（普通かどうかは分からないが，）まあよくある光景なんじゃないかと想像する．
これらが全て重なるような高カロリーなミルフィーユはさすがにまだ経験していない．
何より弊社インフラエンジニアは私一人なわけないので，実際はもっと分散されている．

ただ，業務内容がこういった要素を持っていることは否めないので，私は対象読者だと言えるだろう．

## 「エンジニアのための時間管理術」は誰が読むべきか

さて，これまで本書からの引用と例をあげて対象読者を語ってきたが，あなたは対象読者だろうか？

なぜここまで対象読者を掘り下げたかというと，「これに当てはまるのは私だ」という人にとって，喉を通る本になっているからだ．
描かれた「あるある話」に頷ける分だけ，本書はサクサクと読みやすくなる．

逆にいえば，本書はただのライフハック本でしかなく，対象読者から外れた人にとっては，知らない業界の人達のあるある談義とより良い生き方の講釈を垂れているに過ぎない．

## 本書で語られていること

「エンジニアのための」と銘打たれているが，先述の通りライフハック系の本に違わぬ内容となっている．

1. タイムマネジメントとは何か
1. なぜ問題を先送りにしてしまうのか
1. なぜタイムマネジメントが有効なのか，何に有効なのか
1. 何をすればいいのか
  - 集中と割り込みへの対応
  - ルーチンワーク化の方法
  - 作業リストの管理方法（サイクルシステム）
  - 優先順位の設定方法
  - ストレス管理
  - メール管理やドキュメンテーション，自動化など

「メール管理」以降は正直ダレてしまった．
特に自動化の章でmakeコマンドの説明が出てきたところはほとんど読み飛ばした．
コマンドの使い方は別の本で学べばいいし，要点は「自動化ツールを使いこなして自動化しなさい」ということだろう．

体感的に分かっていたけれど，言語化してこなかったことについての説明が良かった．
どのタイミングで自動化すべきか，ストレスとは何か，優先順位はどうやって決めるべきか，ツールを使う上での注意点などなど．
鵜呑みにするしないは別として，時間管理するうえでの一つの基準点を設けられるという点で本書は大変参考になった．

## 終わりに

「エンジニアのための時間管理術」は，エンジニアという特定の職種に向けて書かれたタイムマネジメントの本である．
営業であったりマネージャであったり，エンジニア以外の職種にとっては同じような別の本があるだろう．
汎用的な時間管理の本を，エンジニア向けに最適化した内容となっている．

本書は，特に1〜2年目のエンジニアに読んでほしいと思った．
実務外の研修で役に立つ機会はないかもしれないが，仕事をしていくなかで，はたと感じた疑問に答えてくれる本だと思う．