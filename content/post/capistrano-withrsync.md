---
layout: post
title: capistrano-withrsyncを使ってVagrantで構築したVMにデプロイする
date: 2014-10-14T05:30:00+09:00
tags: 
- capistrano
---
Capistranoを使ったシーンで，デプロイ先にgit cloneさせるのを避けるために，rsyncを使ってローカルマシンから本番サーバへのデプロイを試みたい．
ペパボ福岡支社の[linyows](https://github.com/linyows)さんが[capistrano-withrsync](https://github.com/linyows/capistrano-withrsync)というGemを作っていたので，それを使ってみた．

ちなみに[moll/capistrano-rsync](https://github.com/moll/capistrano-rsync)というGemもあるが，どうも更新されている気配が無いので今回は見送り．
    
なお，Capistranoのバージョンは3系とする．

## Capistranoの準備

`Gemfile`に以下の2つのgemを用意する．

```rb
group :development do
  gem "capistrano"
  gem "capistrano-withrsync"
end
```

一式の導入が完了したら，`cap install`で初期ファイルを生成する．

```console
$ bundle exec cap install
mkdir -p config/deploy
create config/deploy.rb
create config/deploy/staging.rb
create config/deploy/production.rb
mkdir -p lib/capistrano/tasks
Capified
```

この状態からカスタマイズに入っていく．

## `Capfile`の編集

必要そうなタスクと，`capistrano/withrsync`を追加しておく．

```rb
# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
require 'capistrano/withrsync'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
```

## `config/deploy.rb`の編集

少なくとも`:repo_url`さえ設定すれば良いと思う．

ただし，`:deploy_to`で指定するデプロイ先のディレクトリ権限だけ気をつける．
capistrano-withrsyncに限った話ではないが，デプロイ先のディレクトリとそのパーミッションは先に設定しておかないと`vagrant`ユーザの権限不足でデプロイに失敗する（調査不足なだけで，他に良い方法があるような気がする）．

```rb
set :application, 'my_application'
set :repo_url, 'git@github.com:<GITHUB USERNAME>/<YOUR REPOSITORY>.git'
set :deploy_to, '/var/capistrano'
```

## `config/deploy/vagrant.rb`の用意

`staging.rb`と`production.rb`は無視して，新たに`vagrant.rb`を作る．中身を以下のように設定する．

```rb
set :ssh_options, {
  keys:         %w(~/.vagrant.d/insecure_private_key),
  auth_methods: %w(publickey)
}

# overwrite :rsync_options
set :rsync_options, fetch(:rsync_options).push('-e "ssh -i $HOME/.vagrant.d/insecure_private_key"')

server '10.0.0.4', roles: [:vagrant], user: 'vagrant'
```

capistrano-withrsyncを使ってVagrant VMにデプロイしようとすると，rsync転送時にvagrantユーザのパスワードを求められる．
`vagrant ssh-config <VM-DEFINE> | tee -a ~/.ssh/config`してもいいが，出来ればcapistranoの設定だけで簡潔させたい．
そこで，`:rsync_options`を使う．

`:rsync_options`は[withrsync.rake#L5-L11](https://github.com/linyows/capistrano-withrsync/blob/v0.1.0/lib/capistrano/tasks/withrsync.rake#L5-L11)で定義されるrsyncの転送オプションである．
ここに，`-e "ssh -i $HOME/.vagrant.d/insecure_private_key"`を追加して公開鍵認証を有効にしている．

ここまでの設定が完了したら，`cap vagrant deploy`でデプロイが可能になっている．

## 終わりに

Capistranoとcapistrano-withrsyncによる，rsyncを用いたデプロイ方法を紹介した．
ローカルマシンに降ろしてきたリポジトリをrsyncで転送するので，デプロイ先からgit cloneしにくい状況でも問題なくデプロイが可能になる．

Vagrantには[Synced Folders](http://docs.vagrantup.com/v2/synced-folders/index.html)があるから，意義はやや薄いが，プロダクション環境と同じ方法でデプロイ出来ると開発方法が統一されて良いと思う．

まだまだCapistranoに明るくないので，より良い方法があれば教えていただければ幸いです．

## 参考

- [入門 Capistrano 3 ~ 全ての手作業を生まれる前に消し去りたい | GREE Engineers' Blog](http://labs.gree.jp/blog/2013/12/10084/)
- [Capistrano3のデプロイフレームワークの使い方 - Qiita](http://qiita.com/yuku_t/items/01c0ec4389db143e27f5)
- [A remote server automation and deployment tool written in Ruby.](http://capistranorb.com/)
- [capistrano/capistrano](https://github.com/capistrano/capistrano)
