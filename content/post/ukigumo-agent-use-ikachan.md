---
date: 2015-02-19T20:32:53+09:00
title: Ukigumo::AgentでIkachan通知を使いたい場合
tags:
- ukigumo
- perl
---
Ukigumo::Clientはikachanを引数指定出来るけど，Agentでのやり方が分からなかったので調べてた時のメモ．

ドキュメント少なくてちょっと手間取ったけど，`.ukigumo.yml`の`notifications`にIkachanの設定を書けば動いてくれた．

## `.ukigumo.yml`にIkachan用の設定を書く

```yaml
notifications:
  ikachan:
    - url: 'http://URL.OF.IRC:PORT'
      channel: '#channel'
```

`url`と`channel`を書けば以下のような感じで通知を飛ばせる様になった（FAILしてるけど...）

![FAILしてるが通知はSUCCESS](/images/2015/02/19/ukigumo-ikachan.png)

コード[^1]を読むと，SUCCESS時の通知を制御する（っぽい）`ignore_success`やprivmsg・noticeの通知方法を選択する`method`等もあるみたいなので，必要ならyamlに追記すれば良さそう．

---

2015/02/19 21:09 追記:

http://ukigumo.github.io/Ukigumo-Client/ にも書いてあった

---


## 終わりに

[@moznion](https://twitter.com/moznion)さんのブログ[^2]にはGitHubの通知方法があったので，Ikachanは無いかなーとググったらLingrにそれっぽいことが書いてあった[^3]ので，取り敢えずそれっぽくYAMLに書いたら動いたので良かった．

Ukigumoちゃん可愛いよ!

[^1]: https://github.com/ukigumo/Ukigumo-Client/blob/master/lib/Ukigumo/Client/Notify/Ikachan.pm
[^2]: [Ukigumo入門 ― 2014年スタイル - その手の平は尻もつかめるさ](http://moznion.hatenadiary.com/entry/2014/05/02/181147)
[^3]: [Perlの話題を日本語で – Lingr](http://lingr.com/room/perl_jp/archives/2014/01/16)
