---
layout: post
title: Capistranoを使ってlibrarian-puppetをデプロイ先に適応する
tags: 
- puppet
- capistrano
---
[前回](/2014/10/06/librarian-puppet/)，[librarian-puppet](http://librarian-puppet.com/)を使ったPuppetモジュールの管理方法について紹介した．
[librarian-puppet](http://librarian-puppet.com/)はPuppet版bundlerのようなツールで，Gemfile風にサードパーティ製Puppetモジュールを管理することが出来る．

librarian-puppetの使い方は前回のブログ記事を参照されたい．
前回のブログ記事の最後で，デプロイに課題が残ることを説明した．
ただlibrarian-puppetを導入しただけでは，デプロイ先で手ずから`librarian-puppet install`コマンドでインストール作業を行わなければいけない．

そこで今回は，capistrano[^1]を利用して，デプロイ先で自動的にlibrarian-puppet経由でモジュールのインストールを行えるようにしたい．

```rb
group :development do
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-withrsync"
end
```

```console
$ bundle exec cap install
mkdir -p config/deploy
create config/deploy.rb
create config/deploy/staging.rb
create config/deploy/production.rb
mkdir -p lib/capistrano/tasks
Capified
```

## librarian-puppetクイックスタート

### librarian-puppetのインストールと初期設定

librarian-puppetはRuby製で，gemからインストールが可能だ．

```sh
gem i librarian-puppet
```

`init`コマンドで初期化を行う．実行すると，`Puppetfile`が実行ディレクトリに生成されるだろう．

```sh
librarian-puppet init
```

### モジュールの追加・編集

`Puppetfile`を編集して，必要なモジュールの追加や修正を行う．
例として，Puppet Labsのstdlib[^3]とTim Sharpe氏のlogrotateモジュール[^4]の追加されたファイルを以下に示す．  
※各モジュールを追加する書式は，`mod "<ORGANIZATION>-<MODULENAME>"`となっていることに注意したい．

```rb
forge "https://forge.puppetlabs.com"

mod "puppetlabs-stdlib"
mod "rodjek-logrotate",
  :git => "git://github.com/rodjek/puppet-logrotate.git"
```

### モジュールのインストール

#### configuration

モジュールのインストールパスのデフォルトは`modules`である[^5]．
変更したい場合は`config`コマンドを実行すればよい．
`config`コマンドは以下のようにKEY/VALUEで指定することが出来る．
（`--local`と`--global`を選択できるが，プロジェクトリポジトリで実行するなら`--local`で良いと思う）

```
librarian-puppet config KEY VALUE --local(--global)
```

サードパーティ製モジュールは自前のモジュールと区別したいので，今回は`vendor/modules`という場所を選択する．
なお，新しいディレクトリを指定する場合は，`modulepath`にそのディレクトリを指定することを忘れないように注意したい（`puppet.conf`に書くか`--modulepath`で指定する）．

```sh
librarian-puppet config path vendor/modules --local
```

#### install

ここまでで準備は完了である．
モジュールのインストールは`install`コマンドで実行可能だ．

```sh
librarian-puppet install
```

これで`Puppetfile.lock`にバージョン情報や依存関係が定義され，`path`で設定したディレクトリにモジュールがインストールされる．
出力が物足りない場合は`--verbose`を付けるといい．

### 更新情報の取得

`outdated`や`update`コマンドで更新情報の確認・変更を行うことが可能である．
`update`はモジュールを単体指定することも可能である．

## 終わりに

ここまででlibrarian-puppetのひと通りの使い方を紹介した．

librarian-puppetによってサードパーティ製Puppetモジュールのバージョン管理を効率良く行えるようになるが，デプロイに課題が残る．
`Puppetfile`によって管理されたモジュールらは，リポジトリにファイルとして含めないようにしたいが，そのままではデプロイ先で毎回`labrarian-puppet install`を手打ちで実行しなければならない．

この課題は，Capistrano(Webistrano)のレシピを作成することで解決しよう．
ペパボではどのようにlibrarian-puppetとCapistranoを連動させているかを，次の機会に紹介したいと思う．

[^1]: A remote server automation and deployment tool written in Ruby. - http://capistranorb.com/
[^2]: Puppet Forge - https://forge.puppetlabs.com
[^3]: puppetlabs/stdlib · Puppet Forge - https://forge.puppetlabs.com/puppetlabs/stdlib
[^4]: rodjek/puppet-logrotate - https://github.com/rodjek/puppet-logrotate
[^5]: https://github.com/rodjek/librarian-puppet/blob/v1.3.2/lib/librarian/puppet/environment.rb#L19-L22
