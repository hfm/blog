---
layout: post
title: gollumを使って個人用wikiをサーバに立てた
date: 2014-02-02
tags:
- gollum
- ruby
---
gollumはGitで動作する、ローカル向け（個人向け）の軽量なWikiです。

> [___gollum -- A wiki built on top of Git___](https://github.com/gollum/gollum#gollum----a-wiki-built-on-top-of-git)
> 
> Gollum wikis are simply Git repositories that adhere to a specific format. Gollum pages may be written in a variety of formats and can be edited in a number of ways depending on your needs. You can edit your wiki locally:
> 
> * With your favorite text editor or IDE (changes will be visible after committing).
> * With the built-in web interface.
> * With the Gollum Ruby API.

前々から自分用のWikiが欲しいと思っていて、でも他のWikiは機能が多いのと、何より画面がごちゃごちゃしていて、もうすこしシンプルな操作を期待できるWikiはないかと探していたときに見つけました。
gollumはできる事が限られている分、シンプルで良いです。

## gollumの良いと感じたところ

 * 起動したら即使用可能
 * 操作画面と機能がシンプル
 * markdownが使える（ひと通りの記法が使える）
 * シンタックスハイライトが効く
 * ファイルアップロード機能も一応ある（あんま重要視してない）
 * 管理がGit任せなので、操作に慣れていると楽
 * __ほとんどそれだけしか機能が無い__こと（ユーザ登録機能すら無いです）

## ひとまず試す

とりあえず試すには、ディレクトリにGitリポジトリを作ってgollumを起動します。

```console
$ gem install gollum
$ mkdir test && cd test && git init
$ gollum
```

### 最初の画面

`http://0.0.0.0:4567`にアクセスすると、Home画面の作成ページが出ます。

![](/images/2014/02/02/create@2x.png)

### 色々投稿する

tocの出力も出来ます。
出来ることが限られているため、目的とマッチすれば快適です。

![](/images/2014/02/02/home@2x.png)

![](/images/2014/02/02/gollum@2x.png)

### ユーザ設定

gollumにはユーザ登録機能がありません。
代わりに、サーバの`.gitconfig`の設定を読み取って動いています。
例えば執筆者の名前は、`git config user.name`になります。

### マルチバイト

半年ほど前（2013年の秋ぐらい？）までは日本語（マルチバイト）の処理にバグがあるらしかったのですが、v2.5.1以降ではこの問題が解決されて、日本語もちゃんと対応してくれているようです。

 * [Fix `Encoding::CompatibilityError` of edit view. by ngyuki · Pull Request #735 · gollum/gollum](https://github.com/gollum/gollum/pull/735)

## VPSにgollumを設置する

### ディレクトリ構成

サーバには以下のように設置しておきました。

```
/var/www/wiki
├── Gemfile
├── Home.md
├── _Sidebar.md
├── auth.yml
├── config
│   └── unicorn.rb
├── config.ru
└── script
```

なおこのセットはGitHubにリポジトリを置いています。

 * [tacahilo/wiki](https://github.com/tacahilo/wiki)

### Table of Contents

`_Sidebar.md`に以下の一行を入れておくと、サイドバーに目次が表示されます。

```
[[_TOC_]]
```

### config.ru と BASIC認証

`config.ru`には公式から引っ張ってきた設定を書いていたのですが、VPS上において管理する上で一つ問題がありました。

gollumはそのままサーバに置いて外部に公開してしまうと、だれでも書き込みが出来てしまいます。
gollumの設定がサーバに依存していて、ユーザ登録機能がついていないことから、だれが書き込もうと`git config user.name`になってしまいます。

元々自分一人での用途に限定するつもりだったので、簡単なBASIC認証をかけました。
`auth.yml`を用意して、settingslogicで引っ張ってきてます。

BASIC認証の導入は、『[githubのwikiエンジン"gollum"の導入と細かい設定 - yukke::note](http://yukke.hateblo.jp/entry/2013/05/02/224859)』を参考にしました。

```yaml
username: USERNAME
password: PASSWORD
```

```rb
require 'rubygems'
require 'settingslogic'
require 'gollum/app'

# load auth file
class Settings < Settingslogic
  source "auth.yml"
end

# authentication
module Precious
  class App < Sinatra::Base
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
      [username, password] == [Settings.username, Settings.password]
    end
  end
end

# gollum
gollum_path = File.expand_path(File.dirname(__FILE__)) # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown)
Precious::App.set(:wiki_options, {
  :universal_toc => false,
  :mathjax       => true,
})
run Precious::App
```

### nginx + unicorn

wikiをサーバにホストさせる上で、nginxとunicornを選びました。
[ペパボ新卒研修で使った](/2014/01/04/web-operation/)から、という慣れが大きな理由です。

#### nginxの設定

nginx側では`/etc/nginx/conf.d/wiki.conf`を用意して、以下のように設定。
基本的な設定は`/etc/nginx/nginx.conf`に書いて、個別設定を`include conf.d/*.conf`で読み込んでます。

```nginx
upstream unicorn {
    server unix:/var/run/unicorn_wiki.sock;
}

server {
    listen      80;
    server_name hogehoge.server.com;
    access_log  /var/log/nginx/wiki_access.log ltsv;
    error_log   /var/log/nginx/wiki_error.log;

    location / {
        proxy_pass http://unicorn;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

#### unicornの設定

`config/unicorn.rb`では以下のように設定を書きました。楽ですね。

```rb
APP_PATH = "/var/www/wiki"

worker_processes 2
working_directory APP_PATH

listen "unix:/var/run/unicorn_wiki.sock", :backlog => 1024

pid "/var/run/unicorn.pid"

stderr_path "/var/log/unicorn/stderr.log"
stdout_path "/var/log/unicorn/stdout.log"

preload_app true
check_client_connection false
```

### GitHubとの同期

VPS上においたWikiはGitで動いているので、せっかくだからGitHubのリポジトリを用意してバックアップさせようと思いました。

本当はgit hookを使って更新されたらpushするようにしたかったんですが、何故かgollum経由で更新するとhookが効かなかった（調査不足ですが）ので、以下のような ~~力押し~~ 簡単なスクリプトをwheneverで管理してます。

```rb
require 'git'

path = File.join(File.dirname(__FILE__), "..")
repo = Git.open(path)
repo.push(repo.remote("origin"))
```

wheneverを使ってみたくてデビューしたんですが、command部分が汚すぎるのでここも追々直します…。

```rb
set :output, "/var/log/whenever.log"

every :hour do
  command "cd /var/www/wiki; env PATH=/usr/local/ruby-2.1.0/bin:$PATH bundle exec ruby /var/www/wiki/script/push_remote.rb"
end
```

1時間ごとにGitHubにpushしようとしますが、あんまりpushしすぎもどうかと思うので、push間隔は後々調整していきます。
同期の仕組みが雑すぎるので、もうちょっと考えないとダメですね…。

## 今後の課題

### GitHubに更新→Wikiに反映が出来ない

プルリクはさすがに飛んでこない気もしますが、今現在はwikiの内容をGitHubに反映するだけで、GitHubから更新があった際にそれを修正する手段を用意していません。
もしもGitHubのリポジトリを更新してしまうと、pushに失敗してしまいます。

対策としては、WebHookを使って更新を通知して、それを受け取ったらWiki側でpullするようにするとかでしょうか。
そうなると今度はサーバにあるwhenever (cron) との兼ね合いが面倒になりそうな気も…。

ガーッと作っちゃって色んな所が雑になっているので、徐々に改善していこうと思います。
なにはともあれ、自分用のWikiをVPSにホストさせることが出来たので満足しています。

## 参考

 * [gollum/gollum](https://github.com/gollum/gollum)
 * [Gollum - a Lightweight Wiki - Mustafa Simav](http://msimav.net/2013/08/01/gollum-a-lightweight-wiki/)
 * [githubのwikiエンジン"gollum"の導入と細かい設定 - yukke::note](http://yukke.hateblo.jp/entry/2013/05/02/224859)
