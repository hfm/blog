---
layout: post
title: Puppetモジュールの管理にlibrarian-puppetを使う
date: 2014-10-06T09:21:34+09:00
tags: 
- puppet
---
[librarian-puppet](http://librarian-puppet.com/)はbundlerのPuppet版ツールだ．
Puppet関連ツールではおなじみと言ってもいい，Tim Sharpe氏[^1]の作品でもある．
the Puppet Forge[^2]というPuppetモジュールのリポジトリやGitHub, あるいはgitアドレスを持つモジュール等をGemfile風に管理することが出来る．

サードパーティ製のPuppetモジュールを直接リポジトリで管理しようとすると，更新に追い付くことが大変になる．
バージョン情報の確認が面倒だし，あれこれ入れているとリポジトリの肥大化も招く．

bundelrを知っている人にとって，バージョントラッキングとインストール情報の管理の恩恵は最早不要だと思う．
librarian-puppetは`Puppetfile`と`Puppetfile.lock`によって，サードパーティ製モジュールの管理を行う．
ここから先は，librarian-puppetの使い方を簡単に紹介しようと思う．

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

[^1]: rodjek (Tim Sharpe) - https://github.com/rodjek
[^2]: Puppet Forge - https://forge.puppetlabs.com
[^3]: puppetlabs/stdlib · Puppet Forge - https://forge.puppetlabs.com/puppetlabs/stdlib
[^4]: rodjek/puppet-logrotate - https://github.com/rodjek/puppet-logrotate
[^5]: https://github.com/rodjek/librarian-puppet/blob/v1.3.2/lib/librarian/puppet/environment.rb#L19-L22
