---
date: 2015-04-12T00:50:02+09:00
title: Puppet Server 1.0.8 のリリースノートを読んだ
tags:
- puppet
---
[Puppet Server 1.0.8のリリースノート](https://docs.puppetlabs.com/puppetserver/1.0/release_notes.html#puppet-server-108)を読んだ。
Puppet Server 1.0.3 - 1.0.7はスキップしてのリリースとなる。

- [Puppet Server 1.0.0 のリリースノートを読んだ](/2015/02/11/puppet-server-release-note-100/)
- [Puppet Server 1.0.2 のリリースノートを読んだ](/2015/02/12/puppet-server-release-note-102/)

なお、Puppet Serverは[Semantic Versioning](http://semver.org)を採用している。

> [Ruby 2.1.0 以降のセマンティックバージョニングについて](https://www.ruby-lang.org/ja/news/2013/12/21/ruby-version-policy-changes-with-2-1-0/)

新機能やバグフィックス等から、気になったところをピックアップしていく。

HTTP clientのタイムアウト設定
---

HTTPクライアントからの接続に、ミリ秒単位でタイムアウトを設定出来るようになった。

> http://docs.puppetlabs.com/puppetserver/1.0/configuration.html#puppetserverconf

- `idle-timeout-milliseconds` ... デフォルトは20分
- `connect-timeout-milliseconds` ... デフォルトは2分

デフォルト値についてドキュメントにちゃんと書いてないのだが、設定ファイルのコメントアウトを読む限りは、上記らしい。

HTTPのトラフィックのログ化
---

HTTPのトラフィックをログファイルに取得出来るようになった。

> http://docs.puppetlabs.com/puppetserver/1.0/configuration.html#http-traffic

フォーマットはApache風で、デフォルトでは以下の値が取得出来る。

- remote host
- remote log name
- remote user
- date of the logging event
- URL requested
- status code of the request
- response content length
- remote IP address
- local port
- elapsed time to serve the request, in milliseconds

Vagrantで試してみたところ、以下のようなログが取得出来た。
デバッグ時に便利そう。

```
0:0:0:0:0:0:0:1 - - - 12/Apr/2015:00:26:35 +0900 "GET /production/certificate_revocation_list/ca? HTTP/1.1" 200 954 0:0:0:0:0:0:0:1 0:0:0:0:0:0:0:1 8140 31
0:0:0:0:0:0:0:1 - - - 12/Apr/2015:00:26:36 +0900 "GET /production/node/localhost?transaction_uuid=1b8ae01e-2a3b-4b15-8a07-cbe4ec73ae55&fail_on_404=true HTTP/1.1" 200 79 0:0:0:0:0:0:0:1 0:0:0:0:0:0:0:1 8140 361
0:0:0:0:0:0:0:1 - - - 12/Apr/2015:00:26:36 +0900 "GET /production/file_metadatas/pluginfacts?links=manage&recurse=true&ignore=.svn&ignore=CVS&ignore=.git&checksum_type=md5 HTTP/1.1" 200 278 0:0:0:0:0:0:0:1 0:0:0:0:0:0:0:1 8140 96
0:0:0:0:0:0:0:1 - - - 12/Apr/2015:00:26:36 +0900 "GET /production/file_metadatas/plugins?links=manage&recurse=true&ignore=.svn&ignore=CVS&ignore=.git&checksum_type=md5 HTTP/1.1" 200 278 0:0:0:0:0:0:0:1 0:0:0:0:0:0:0:1 8140 51
0:0:0:0:0:0:0:1 - - - 12/Apr/2015:00:26:37 +0900 "POST /production/catalog/localhost HTTP/1.1" 200 570 0:0:0:0:0:0:0:1 0:0:0:0:0:0:0:1 8140 495
0:0:0:0:0:0:0:1 - - - 12/Apr/2015:00:26:37 +0900 "PUT /production/report/localhost HTTP/1.1" 200 9 0:0:0:0:0:0:0:1 0:0:0:0:0:0:0:1 8140 152
```

reboot後にPuppet Serverが起動しない問題の修正
---

特にRHEL7とUbuntu 14.4で生じる問*らしく、reboot後にPuppet Serverの起動に失敗するケースがあった。

原因は`/var/run`ディレクトリにある。

RHEL7では/var/runディレクトリは/runへのsymlinkになっており、更にこの/runはtmpfsとなっている。 (Ubuntuは未確認だけど多分同じだろう)

```shell-session
[root@localhost ~]# mount | grep run
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
```

rebootするとtmpfsの中身が消失してしまうため、/var/run以下のPuppet Server用ディレクトリまで消えてしまうというカラクリのようだ。

この問題に対し、Puppet Serverを起動する前に`install`コマンドで`/var/run/puppet`ディレクトリを作成するという方法を取っている。

> https://github.com/puppetlabs/puppet-server/pull/422
>
> ```diff
> resources/ext/ezbake.conf
> @@ -21,7 +21,8 @@ ezbake: {
>                           "mkdir -p /etc/puppet/manifests"],
>                 install: ["echo \\\"os-settings: {\\\"                         > $DESTDIR/$projconfdir/conf.d/os-settings.conf",
>                           "echo \\\"    ruby-load-path: [$rubylibdir]\\\"      >> $DESTDIR/$projconfdir/conf.d/os-settings.conf",
> -                         "echo \\\"}\\\"                                      >> $DESTDIR/$projconfdir/conf.d/os-settings.conf" ]
> +                         "echo \\\"}\\\"                                      >> $DESTDIR/$projconfdir/conf.d/os-settings.conf" ],
> +               pre-start-action: ["/usr/bin/install --group={{user}} --owner={{user}} -d /var/run/puppet"]
>               }
>
>        debian: { dependencies: ["puppet-common (>= 3.7.3-1puppetlabs1)"
>  @@ -35,7 +36,8 @@ ezbake: {
>                           "mkdir -p /etc/puppet/manifests"],
>                 install: ["echo \\\"os-settings: {\\\"                       > $DESTDIR/$projconfdir/conf.d/os-settings.conf"
>                           "echo \\\"    ruby-load-path: [$rubylibdir]\\\"    >> $DESTDIR/$projconfdir/conf.d/os-settings.conf",
> -                         "echo \\\"}\\\"                                    >> $DESTDIR/$projconfdir/conf.d/os-settings.conf"]
> +                         "echo \\\"}\\\"                                    >> $DESTDIR/$projconfdir/conf.d/os-settings.conf"],
> +               pre-start-action: ["/usr/bin/install --group={{user}} --owner={{user}} -d /var/run/puppet"]
>               }
>     }
>  }
> ```

バージョンが1.0系になったとはいえ、まだまだ足りてないところも多い印象がある。
