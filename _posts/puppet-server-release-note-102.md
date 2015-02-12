---
layout: post
date: 2015-02-12 11:46:30 +0900
title: Puppet Server 1.0.2 のリリースノートを読んだ
tags:
- puppet
---
[Puppet Server 1.0.2のリリースノート](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-102)を読んだ．
ちなみにPuppet Server 1.0.1はスキップしてのリリースとなる．

- [Puppet Server 1.0.0 のリリースノートを読んだ](/2015/02/11/puppet-server-release-note-100/)

Puppet Serverは[Semantic Versioning](http://semver.org)を採用しているため，`PATCH`レベルの変更は後方互換性の保たれたバグフィックスが中心となる．

- 参考
  - [Ruby 2.1.0 以降のセマンティックバージョニングについて](https://www.ruby-lang.org/ja/news/2013/12/21/ruby-version-policy-changes-with-2-1-0/)
  - [Semantic Versioning 2.0.0](http://shijimiii.info/technical-memo/semver/) (日本語訳)

## Filebucketのファイルをバイナリデータとして扱う変更

[Filebucket files treated as binary data](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#filebucket-files-treated-as-binary-data)より．

Filebucketに格納されたファイルをバイナリデータとして扱うことで，不必要な変更が入ることを避けられるようにしたとか．
[報告のあったチケット](https://tickets.puppetlabs.com/browse/SERVER-269)を読む限りだと，リクエストしたデータを勝手にUTF-8に変換してくる！みたいなバグがあったらしい．

## `puppetserver gem env`のバグ修正

[puppetserver gem env command now works](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppetserver-gem-env-command-now-works)より．

`puppetserver gem env`コマンドは，Rubyの`gem env(ironment)`と同様にRubyGemsの環境を出力するコマンドである．

どうもPuppet Server 1.0.0にはこのコマンドにバグがあったらしく，特定条件下において`puppetserver gem env`を実行すると例外を投げていたそうだ．
*the entire system environment was being cleared*というのが理由らしいんだけど，clearedってのは，環境変数が何も無いときって感じなんだろうか．
[チケット](https://tickets.puppetlabs.com/browse/SERVER-262)や[PullRequest](https://github.com/puppetlabs/puppet-server/pull/342/files)を眺めると，`PATH`と`GEM_HOME`に修正が入っているみたいなので，この辺の値が何もないと死んでたのかな．

ちなみにうまく動作する場合は，普通の`gem env`と何ら変わりない動作をする．

```
[vagrant@localhost ~]$ puppetserver gem env
RubyGems Environment:
  - RUBYGEMS VERSION: 2.1.9
  - RUBY VERSION: 1.9.3 (2014-09-03 patchlevel 392) [java]
  - INSTALLATION DIRECTORY: /var/lib/puppet/jruby-gems
  - RUBY EXECUTABLE: java -jar /usr/share/puppetserver/puppet-server-release.jar
  - EXECUTABLE DIRECTORY: /var/lib/puppet/jruby-gems/bin
  - SPEC CACHE DIRECTORY: /home/vagrant/.gem/specs
  - RUBYGEMS PLATFORMS:
    - ruby
    - universal-java-1.7
  - GEM PATHS:
     - /var/lib/puppet/jruby-gems
     - /home/vagrant/.gem/jruby/1.9
     - file:/usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/gems/shared
  - GEM CONFIGURATION:
     - :update_sources => true
     - :verbose => true
     - :backtrace => false
     - :bulk_threshold => 1000
     - "install" => "--no-rdoc --no-ri --env-shebang"
     - "update" => "--no-rdoc --no-ri --env-shebang"
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /usr/local/bin
     - /bin
     - /usr/bin
     - /usr/local/sbin
     - /usr/sbin
     - /sbin
     - /sbin
     - /usr/sbin
     - /home/vagrant/bin
```

## 起動時間の延長

[Startup time extended for systemd](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#startup-time-extended-for-systemd)より．

バージョン1.0.0で，Puppet Serverの起動のタイムアウト設定を60秒から120秒に延長したが，systemdの設定が漏れていた．
今回のリリースで，起動スクリプトとsystemdの設定ファイルに同じタイムアウト値を設定した．

それにしても，起動時間長くなってんのかな...JVMだし仕方ないか．

## ログレベルの変更に対する改善

[Improvements](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#improvements)より．

ランタイム時にログレベルの変更を反映出来るようになったらしい．
以前は，システムの再起動（*a system restart...*とあるけど，多分Puppet Serverを指してる）をしないとLogbackの変更を検知出来なかったようだ．
