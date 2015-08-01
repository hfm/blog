---
layout: post
date: 2015-01-31 17:46:42 +0900
title: WeechatからSlackにアクセスするようにした
tags:
- slack
- weechat
---
Slackを最近使い出したのだけど，普段はWeechatで過ごしているので，IRC Gatewayからアクセスしたい．

そう思って調べてみたらすぐ見つかった．
Slack自体がIRC Gatewayを用意してくれていて，流石後発のサービスだけあってアレにもコレにも対応してるなー．

## Gatewayの設定

以下のURLにアクセスする．
アスタリスクの部分はチーム名を入れればよい．

- https://***.slack.com/account/gateways

gatewaysのページの**Getting Started: IRC**の設定を参考に，Weechatにサーバを追加する．

![](/images/2015/01/31/gateway.png)

自分は以下のような感じで設定した．

```
/server add slack ***.irc.slack.com/6667 -autoconnect -ssl -ssl_verify=off -password=*** -nicks=<username>
/connect slack
```

今回はweechatに直接つっこんだけど，ZNCに移してもいいかも．
