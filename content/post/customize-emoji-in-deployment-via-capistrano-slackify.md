---
date: 2016-06-10T15:18:25+09:00
title: Capistrano の Slack 通知で、デプロイ開始・成功・失敗時の emoji を変える
tags:
- ruby
- capistrano
- slack
---
Capistrano のデプロイを Slack に通知するためのプラグインに [capistrano-slackify](https://github.com/onthebeach/capistrano-slackify) を使っている。

- [onthebeach/capistrano-slackify: Publish deployment notifications to Slack via the incoming webhooks integration](https://github.com/onthebeach/capistrano-slackify)

デフォルトの emoji は 👻 で、いまいち気分が盛り上がらない。なぜオバケなのか。設定は `set :slack_emoji, ':man:'` のように変えることは出来るが、デプロイ開始・成功・失敗がすべて同じ emoji だと、視覚的に分かりづらい。それぞれ異なる emoji を表示して、デプロイをやっていきたい。

capistrano-slackify は単純なタスクなので、 emoji の変更も簡単だった。以下のようなタスクを書く。

```rb
before 'slack:notify_finished', :deploy_success do
  set :slack_emoji,    ':success_emoji:'
  set :slack_username, 'Capistrano (success)'
end

before 'slack:notify_failed', :deploy_failure do
  set :slack_emoji,    ':failure_emoji:'
  set :slack_username, 'Capistrano (failure)'
end
```

Slack のユーザ名も変更するところがポイントで、ここが同じだと発言が連続したときに emoji が省略されてしまう。せっかくなので `Success` とか `Failure` とか、状態もユーザ名につっこむことにした。

結果として、以下のようになった。デプロイ開始時はアイスクリーム。成功するとブロッコリーになる。

![](/images/2016/06/10/cap_starting_and_success.png)

失敗すると鬼になる。

![](/images/2016/06/10/cap_failure.png)

これによって、デプロイ時のわくわくが増した。失敗したときは、鬼だからしょうがないなって気持ちになって、残念さやイライラが減って、次はこいつをブロッコリーに変えてやるんだという気持ちでデプロイに励めるようになった。

なお、これらの emoji は [@kozzzo](https://twitter.com/kozzzo) さんが作ってくださったアイコンです。アイコンのモチーフになっているのは[あの人](https://twitter.com/lamanotrama)です。感謝。
