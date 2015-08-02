---
date: 2015-03-10T00:16:26+09:00
title: ruboty-github_statusを作った
tags:
- ruby
---
[r7kamura/ruboty](https://github.com/r7kamura/ruboty/)のプラグインを作った．
`@ruboty github status`と`@ruboty github status last`のコマンドで，https://status.github.com/ からGitHubのStatusを返す．

- https://github.com/tacahilo/ruboty-github_status
- https://rubygems.org/gems/ruboty-github_status

元々hubotに同じスクリプトがあったので，これのruboty版が欲しいと思って作った．

- https://github.com/github/hubot-scripts/blob/master/src/scripts/github-status.coffee

以下のような動作をする．

```console
$ bundle exec ruboty
Type `exit` or `quit` to end the session.
> ruboty github status
2015-03-10 00:06:37 +0900
2015-03-10 00:06:37 +0900
Status: good (0 seconds ago)
> ruboty github status last
Status: good
Message: Everything operating normally.
Date: 2015-03-03 05:24:44 +0900
```

hubot版同様に`statusMessages`を作ろうと思ったが， https://status.github.com/api/messages.json が現時点で空っぽになっていて，何も取り出せそうになかったので作らなかった．
