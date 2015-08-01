---
layout: post
date: 2014-10-29T13:20:00+09:00
title: RubyでIPアドレスからホスト名を得て，IRCに通知させる
tags: 
- ruby
---
ただResolv#getname[^1]を使っただけなんですが，どういう目的で使いたかったのかを説明します．

## 背景

ペパボではコミュニケーションツールとして主にIRCが用いられています．
一方，外部とのやりとりにはまだまだメールは廃れておりません．
また，ホスティングのようなサービスを運営していると，不正利用との戦いは避けられず，時折外部のセキュリティ会社やabuse対策チーム等から警告メールが届くことがあります[^2]．

## 課題

エンジニアは作業に集中すると，メールチェックを忘れてしまうため，重要なメールはIRCで通知させています[^3]．
先ほどの警告メールのような場合，その件名にIPアドレスが表記されていることがあります．

※特定のメールが届くと，以下のようにikachan経由で通知が届く．

```irc
12:34:56  ikachan | Mail from notify@from.abuse => Title: ABUSE NUM#123456ABCDEF From (10.20.30.40)
```

ところが，サーバの管理台数が増えるに連れ，IPアドレスに対応するホスト名など覚えることは出来ず，またメールが届く度に逆引きすることは非効率です．


## 解決

最近ではHubotも人気ですが，今回はcinchを利用します[^4][^5]，
IRCへの通知内容からIPアドレスを検出し，ホスト名を出力されるために以下のようなコードを用意し，botとして常駐させておきます．

```rb
on :message, /(\d+\.\d+\.\d+\.\d+)/ do |m, ipaddr|
  require 'resolv'

  if ipaddr =~ Resolv::IPv4::Regex
    hostname = Resolv.getname(ipaddr)
  end

  m.target.notice "#{ipaddr} is pointed to #{hostname}"
end
```

先のような通知がIRCに届くと，マッチした`ipaddr`がIPv4がどうかを調べた上でホスト名を返すようになります．

```irc
00:43:54  -- | Notice(cinch): 10.20.30.40 is pointed to alpha.beta.gamma
```

まだまだ改良の余地はあると思いますが，まあこれぐらいでいいかな...というところから始めています．

ちなみに`(\d+\.\d+\.\d+\.\d+)`だけだとメール通知以外にも引っかかってしまうため，通知内容とマッチさせる条件を工夫するとよいでしょう．

## 余談

はじめ，`on :message`の正規表現に`Resolv::IPv4::Regex`[^6]を使おうとしたんですが，以下のように`\A ... \z`だったので「IPアドレスが含まれる文字列」とmatch出来ませんでした．

```rb
$ ruby -r Resolv -e 'p Resolv::IPv4::Regex'
/\A((?x-mi:0
               |1(?:[0-9][0-9]?)?
               |2(?:[0-4][0-9]?|5[0-5]?|[6-9])?
               |[3-9][0-9]?))\.((?x-mi:0
               |1(?:[0-9][0-9]?)?
               |2(?:[0-4][0-9]?|5[0-5]?|[6-9])?
               |[3-9][0-9]?))\.((?x-mi:0
               |1(?:[0-9][0-9]?)?
               |2(?:[0-4][0-9]?|5[0-5]?|[6-9])?
               |[3-9][0-9]?))\.((?x-mi:0
               |1(?:[0-9][0-9]?)?
               |2(?:[0-4][0-9]?|5[0-5]?|[6-9])?
               |[3-9][0-9]?))\z/
```

## 終わりに

IRCに流れてきた内容にIPアドレスが含まれていた場合，そのホスト名を調べるのが面倒だったので，cinchを使って逆引きした結果をIRC通知するようにしました．

Rubyのドキュメントを読む度に便利そうなメソッドが見つかるので楽しいです．
Happy IRC, Happy Ruby Life!

[^1]: http://www.ruby-doc.org/stdlib-2.1.0/libdoc/resolv/rdoc/Resolv.html#method-c-getname
[^2]: [ホスティング事業者におけるスパムメールの状況とAbuse Abuse対応の実際](https://www.nic.ad.jp/ja/materials/iw/2006/proceedings/T2-2.pdf)
[^3]: [重要なメールが届いたらIRCにメールの件名を通知するようにした - Glide Note - グライドノート](http://blog.glidenote.com/blog/2014/01/29/post-to-irc-important-mail-subject/)
[^4]: [IRC BOTを作って仕事をさせるようにした - Glide Note - グライドノート](http://blog.glidenote.com/blog/2013/05/20/working-with-irc-bot/)
[^5]: https://github.com/cinchrb/cinch
[^6]: [Class: Resolv::IPv4 (Ruby 2.1.0)](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/resolv/rdoc/Resolv/IPv4.html)
