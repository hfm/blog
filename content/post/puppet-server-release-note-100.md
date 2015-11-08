---
date: 2015-02-11T22:06:13+09:00
title: Puppet Server 1.0.0 のリリースノートを読んだ
tags:
- puppet
---
[Puppet Server 1.0.0のリリースノート](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-100)を読んだ。
そのうち、気になったところをピックアップしていく。

## Puppet Serverのバージョニング

[Puppet Server 1.0.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-100)より。

Puppet Serverは[Semantic Versioning](http://semver.org)を採用している。
Semantic Versioningについては以下のリンクを参照すると良い。

- [Ruby 2.1.0 以降のセマンティックバージョニングについて](https://www.ruby-lang.org/ja/news/2013/12/21/ruby-version-policy-changes-with-2-1-0/)
- [Semantic Versioning 2.0.0](http://shijimiii.info/technical-memo/semver/) (日本語訳)

## 互換性について

[Compatibility Note](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#compatibility-note)より。

Puppet Server 1.x系は、Puppet 3.7.3以上のPuppet 3.x系で動作する。
もちろん、将来的にリリースされる予定のPuppet 4もサポート対象内に入る。

## puppetserverのサブコマンド

Puppet Serverは`puppetserver`というCLIも同梱している。
helpで実際に使用可能なコマンドを見てみる。

```
[vagrant@localhost ~]$ puppetserver --help
usage: puppetserver ([--help] | [--version]) <command> [<args>]

The most commonly used puppetserver commands are:
   foreground
   gem
   irb
   ruby

See 'puppetserver <command> -h' for more information on a specific command.
```

これらのうち、`gem`以外はPuppet Server 1.0.0で実装された機能である。

### puppetserver ruby と puppetserver irb

[New Feature: puppetserver ruby and puppetserver irb Commands](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#new-feature-puppetserver-ruby-and-puppetserver-irb-commands)より。

どちらもPuppet ServerのJRuby環境を使ったコマンド実行を可能にする。
貧弱な環境のせいなのか、Vagrantだとビックリするぐらい重かった。

```
[vagrant@localhost ~]$ time puppetserver ruby -v
jruby 1.7.15 (1.9.3p392) 2014-09-03 82b5cc3 on OpenJDK 64-Bit Server VM 1.7.0_75-mockbuild_2015_01_20_23_39-b00 +jit [linux-amd64]

real    0m10.912s
user    0m16.732s
sys     0m0.339s
```

そしてirbはなぜか死んだ。syntax errorって言ってるんだけど、一体それは...

```
[vagrant@localhost ~]$ puppetserver irb
SyntaxError: file:/usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb/lc/ja/encoding_aliases.rb:7: syntax error, unexpected kEND
end
  ^
         eval at org/jruby/RubyKernel.java:1101
    real_load at /usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb/locale.rb:134
         load at /usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb/locale.rb:110
   initialize at /usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb/locale.rb:32
  init_config at /usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb/init.rb:114
        setup at /usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb/init.rb:16
        start at /usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/lib/ruby/1.9/irb.rb:53
       (root) at file:/usr/share/puppetserver/puppet-server-release.jar!/META-INF/jruby.home/bin/irb:17
         load at org/jruby/RubyKernel.java:1081
       (root) at -e:1
       invoke at irb.clj:29
       invoke at subcommand.clj:38
     doInvoke at irb.clj:33
       invoke at core.clj:617
       invoke at main.clj:335
     doInvoke at main.clj:440
```

### puppetserver foreground

[New Feature: puppetserver foreground Command](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#new-feature-puppetserver-ruby-and-puppetserver-irb-commands)より。

Puppet Serverインスタンスをforegroundで起動するためのコマンドらしい。
コンソールに直接ログを吐けたりするので、デバッグに向いてると捉えていいのかな。

foregroundコマンドは、当然だけどバックグラウンドにPuppet Serverが起動してると設定がカチ合って死ぬので注意。
一旦Puppet Serverを停止させてからforegroundを押すと、インスタンスが立ち上がってくる。

```
[vagrant@localhost ~]$ sudo service puppetserver stop
Stopping puppetserver:                                     [  OK  ]
[vagrant@localhost ~]$ sudo puppetserver foreground
2015-02-11 21:43:34,512 INFO  [p.s.j.jruby-puppet-service] Initializing the JRuby service
2015-02-11 21:43:34,526 INFO  [p.t.s.w.jetty9-service] Initializing web server(s).
2015-02-11 21:43:46,184 INFO  [puppet-server] Puppet Puppet settings initialized; run mode: master
2015-02-11 21:43:47,582 INFO  [p.s.j.jruby-puppet-agents] Finished creating JRubyPuppet instance 1 of 4
2015-02-11 21:43:47,630 INFO  [p.s.c.puppet-server-config-core] Initializing webserver settings from core Puppet
2015-02-11 21:43:47,671 INFO  [p.p.certificate-authority] CA already initialized for SSL
2015-02-11 21:43:47,672 INFO  [p.s.c.certificate-authority-service] CA Service adding a ring handler
2015-02-11 21:43:47,694 WARN  [o.e.j.s.h.ContextHandler] Empty contextPath
2015-02-11 21:43:47,704 INFO  [p.s.p.puppet-admin-service] Starting Puppet Admin web app
2015-02-11 21:43:47,764 INFO  [p.p.certificate-authority] Master already initialized for SSL
2015-02-11 21:43:47,765 INFO  [p.s.m.master-service] Master Service adding a ring handler
2015-02-11 21:43:47,767 WARN  [o.e.j.s.h.ContextHandler] Empty contextPath
2015-02-11 21:43:47,771 INFO  [p.t.s.w.jetty9-service] Starting web server(s).
2015-02-11 21:43:47,793 INFO  [p.t.s.w.jetty9-core] webserver config overridden for key 'ssl-cert'
2015-02-11 21:43:47,793 INFO  [p.t.s.w.jetty9-core] webserver config overridden for key 'ssl-key'
2015-02-11 21:43:47,793 INFO  [p.t.s.w.jetty9-core] webserver config overridden for key 'ssl-ca-cert'
2015-02-11 21:43:47,793 INFO  [p.t.s.w.jetty9-core] webserver config overridden for key 'ssl-crl-path'
2015-02-11 21:43:48,727 INFO  [p.t.s.w.jetty9-core] Starting web server.
2015-02-11 21:43:48,736 INFO  [o.e.j.s.Server] jetty-9.1.z-SNAPSHOT
2015-02-11 21:43:48,856 INFO  [o.e.j.s.h.ContextHandler] Started o.e.j.s.h.ContextHandler@662cb51a{/,null,AVAILABLE}
2015-02-11 21:43:48,864 INFO  [o.e.j.s.h.ContextHandler] Started o.e.j.s.h.ContextHandler@4a993988{/puppet-admin-api,null,AVAILABLE}
2015-02-11 21:43:48,864 INFO  [o.e.j.s.h.ContextHandler] Started o.e.j.s.h.ContextHandler@b34c224{/,null,AVAILABLE}
2015-02-11 21:43:49,104 INFO  [o.e.j.s.ServerConnector] Started ServerConnector@47ddbed4{SSL-HTTP/1.1}{0.0.0.0:8140}
2015-02-11 21:43:49,116 INFO  [p.s.m.master-service] Puppet Server has successfully started and is now ready to handle requests
2015-02-11 21:43:52,786 INFO  [puppet-server] Puppet Puppet settings initialized; run mode: master
2015-02-11 21:43:53,866 INFO  [p.s.j.jruby-puppet-agents] Finished creating JRubyPuppet instance 2 of 4
2015-02-11 21:43:58,387 INFO  [puppet-server] Puppet Puppet settings initialized; run mode: master
2015-02-11 21:43:58,975 INFO  [p.s.j.jruby-puppet-agents] Finished creating JRubyPuppet instance 3 of 4
2015-02-11 21:44:02,571 INFO  [puppet-server] Puppet Puppet settings initialized; run mode: master
2015-02-11 21:44:03,103 INFO  [p.s.j.jruby-puppet-agents] Finished creating JRubyPuppet instance 4 of 4
```

この状態でagentがアクセスしにくると、以下のような様子でコンソールにドバっとログが出る。

```
2015-02-11 21:47:27,932 INFO  [puppet-server] access[^/catalog/([^/]+)$] allowing 'method' find
2015-02-11 21:47:27,933 INFO  [puppet-server] access[^/catalog/([^/]+)$] allowing $1 access
2015-02-11 21:47:27,934 INFO  [puppet-server] access[^/node/([^/]+)$] allowing 'method' find
2015-02-11 21:47:27,935 INFO  [puppet-server] access[^/node/([^/]+)$] allowing $1 access
...
```

## Environment Cacheに関するAdmin APIの追加

[New Feature: Admin API for Refreshing Environments](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#new-feature-puppetserver-ruby-and-puppetserver-irb-commands)より。

新しく追加されたAPIは、環境設定値のリフレッシュに関するもの。

以前のバージョンでは、なにか変更がある度にPuppet Serverをまるごと再起動させなければならなかったのが、再起動無しで環境のリフレッシュを行えるようになったらしい。

リリースノートでは`environment-cache`とあるのだけど、これは恐らく`/etc/puppet/puppet.conf`に書かれたmodulepathや`environment.conf`に書かれた諸々の設定値のことだと思う。
Admin APIのEnvironment Cacheについてのドキュメントは以下を参照すると良い。

- [Configuring Directory Environments — Documentation — Puppet Labs](https://docs.puppetlabs.com/puppet/latest/reference/environments_configuring.html)
- [Puppet Server: Admin API: Environment Cache — Documentation — Puppet Labs](https://docs.puppetlabs.com/puppetserver/1.0/admin-api/v1/environment-cache.html)

Puppet Masterを使っていた頃も、カスタムFacterやカスタムProviderを新規に設置したり、puppet.confをいじくった後、設定が反映されないことがあった。
今でも全容を把握出来ていないのだけど、変更を反映させるためにPuppet Masterの再起動はよくやっていた。

それがAPIを叩けばキャッシュクリア出来るようになるみたいなので、嬉しい機能であると言える。

## おまけ

Puppet Serverが1.0.0になるまでに、以下のリリースがあったらしい（ざっくり説明付きで。）

- [0.2.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-020) ... OSSとしての最初のリリース
- [0.2.1](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-021) ... CVE-2014-7170 への対応
- [0.2.2](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-022)
  - reportプロセスの処理中のファイルディスクリプタのリークを修正（なんだそれは...）
  - the Apache 2.0 Licenseのライセンスを追記 [puppetlabs/puppet-server#196](https://github.com/puppetlabs/puppet-server/pull/196)
- [0.3.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-030)
  - 低メモリなシステムで起動した時のエラーメッセージを改善
  - HTTP Basic認証をサポートし、reportプロセッサのバグを修正 [puppetlabs/puppet-server#217](https://github.com/puppetlabs/puppet-server/pull/217)
- [0.4.0](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-040) ... SSLやsystemd周りの改善
