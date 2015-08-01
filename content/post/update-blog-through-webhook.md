---
layout: post
title: GitHubのWebHookを利用したブログ更新
date: 2014-02-11
tags:
- ruby
- shellscript
- github
---
このブログはJekyll製なのですが、デプロイ方法が拙くて、`jekyll new`で生成されるRakefileのdeploy taskを使って、ローカルマシンからサーバへrsyncしていました。

このデプロイ作業がめんどくさく、かといってプラグインを使いたかったのでGitHub Pagesは利用できず…と困っていたのですが、GitHubにWebHook (Post-Receive Hooks) という便利ツールがあることを知りました。

> [___Webサイトをgithubで管理してpush時に自動的に同期する方法 - Blog by Sadayuki Furuhashi___](http://frsyuki.hatenablog.com/entries/2011/04/02)
> 
> ...そこで、github の Post-Receive Hook を使うと、リポジトリに変更を push すると同時に、Webサーバにも同期させることができます。...

自分もこの知恵をお借りしようと思い、GitHubのWebHook通知を受け取り、サーバ側でビルド・syncするプログラムを用意しました。

 * [tacahilo/blog-worker](https://github.com/tacahilo/blog-worker)

## 動作

動作自体は単純なもので、

 1. ローカルマシンからGitHubへpushする
 1. GitHubからWebHookがサーバへ通知される
 1. サーバはWebHookを受け取ると、リポジトリから更新をpullする
 1. ブログのビルドスクリプトを実行する (`jekyll build`)
 1. ビルド完了後、Webサーバのroot directoryへ同期される (`rsync`)
 
となっています。

```
                                4. Pull
                       +--------------------------+
                       |                          |
                       |                      ..........................
                       |                      : server                 :
                       v                      :                        :
+-------+  1. Push   +--------+  2. WebHook   : +--------------------+ :
| local | ---------> | github | ------------> : |   blog_worker.rb   | :
+-------+            +--------+               : +--------------------+ :
                                              :   |                    :
                                              :   | 3. Exec            :
                                              :   v                    :
                                              : +--------------------+ :
                                              : |      build.sh      | :
                                              : +--------------------+ :
                                              :   |                    :
                                              :   | 5. Build and Sync  :
                                              :   v                    :
                                              : +--------------------+ :
                                              : |   blog directory   | :
                                              : +--------------------+ :
                                              :                        :
                                              :........................:
```

## script

### blog\_worker.rb

WebHook通知のレシーバとして、以下のスクリプトを用意しました。
pushの中身は[Post-Receive Hooks#The payload](https://help.github.com/articles/post-receive-hooks#the-payload)を参考にしています。
~~未だにこのスクリプト名がしっくりきていません。~~

> [Webサイトをgithubで管理してpush時に自動的に同期する方法](http://frsyuki.hatenablog.com/entries/2011/04/02)

```rb
require 'sinatra'
require 'json'

dir = File.dirname(__FILE__)
SYNC_SCRIPT = "#{dir}/build.sh"

post "/" do
  push = JSON.parse(params[:payload])
  system(SYNC_SCRIPT) if push["repository"]["id"] == 11420983
end
```

### build.sh

実際このスクリプトがほとんどすべての作業をやってくれています。

 1. blogリポジトリを更新する
 1. `rake build`でビルドする (中で呼ばれてるのは`jekyll build`)
 1. ビルド完了後に生成される`_site/`をnginx rootへrsyncする

というステップになっています。

当初はnginx rootへ`_site/`のsymlinkを張ろうかと思ったんですが、`autoindex on`が必要で、nginxのデフォルトをあまり変更したくなかったのでrsyncに至ります。

```sh
#!/bin/bash
set -eu

GIT_LOCATION=/usr/local/src/blog
REPO=git@github.com:tacahilo/blog.git
WWW_LOCATION=/var/www/blog
BUNDLE_GEMFILE=$GIT_LOCATION/Gemfile

# update_repo
[ -d $GIT_LOCATION ] || mkdir -p $GIT_LOCATION
[ -d $GIT_LOCATION/.git ] || git clone $REPO $GIT_LOCATION
cd $GIT_LOCATION && git pull origin master

# build and sync
[ -d ./.bundle ] || bundle install --path vendor
bundle exec rake build
rsync -a --delete $GIT_LOCATION/_site/ $WWW_LOCATION
```

`BUNDLE_GEMFILE`は`bundle exec`時に作られる？環境変数で、bundle execしたGemfileの絶対パスが入ります。
blog\_workerは`$GIT_LOCATION`とは違うbundle contextで、blog\_workerのGemfileのパスが入っています。

このままでは`$GIT_LOCATION`でbundle実行が出来ないため、途中で書き換えています。

あるbundle context内から別のbundle contextを実行するという、無理矢理感漂うやり方ですが、こういうのって皆さんどうされているのでしょう…。

## GitHubにpushしたら自動更新

ともかくこれで、ブログ記事を書いてGitHubにpushすれば、あとはサーバが勝手に更新してくれるようになりました。
便利だ！

## 参考

 * [俺の最強ブログ システムが火を噴くぜ - てっく煮ブログ](http://tech.nitoyon.com/ja/blog/2012/09/20/moved-completed/)
 * [Webサイトをgithubで管理してpush時に自動的に同期する方法 - Blog by Sadayuki Furuhashi](http://frsyuki.hatenablog.com/entries/2011/04/02)
 * [Post-Receive Hooks · GitHub Help](https://help.github.com/articles/post-receive-hooks)
