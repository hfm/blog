---
layout: post
title: serf-hostsを試してみた
tags:
- serf
---
前回[^1]同様，serfの動作確認を行う．
今回は，ペパボのアドバンスドシニアエンジニア[^2]であるantipopさん[^3]が開発された，serf-hosts[^4]を試してみた．

## serf-hosts

serf-hostsは`/etc/hosts`の自動管理を行う．
`member-join, member-leave (member-failed)`のイベントに応じて，`/etc/hosts`へ対象ホストの追加・削除を行う．

serf-hostsの挙動について，QuickCasts[^5]を使って動画を作成したので，こちらを見てもらえば実際の動作が分かる．

{% youtube xUpuI3aqVjc %}

ここからは，上記の動画撮影のために揃えた環境についての説明となる．

## Vagrantfile

前回使ったVagrantfileにちょっと修正を加えた．

```rb
$script = <<SCRIPT
[ -f /usr/local/src/serf.zip ] || wget -q https://dl.bintray.com/mitchellh/serf/0.6.3_linux_amd64.zip -O /usr/local/src/serf.zip
[ -f /usr/local/bin/serf ]     || unzip /usr/local/src/serf.zip -d /usr/local/bin
[ -d /usr/local/libexec/serf ]     || {
  mkdir /usr/local/libexec/serf
  wget https://raw.githubusercontent.com/kentaro/serf-hosts/master/event_handler.pl -O /usr/local/libexec/serf/serf-hosts
  chmod 755 /usr/local/libexec/serf/serf-hosts
}

mkdir -p /etc/serf/conf.d
cat<<EOS >/etc/serf/conf.d/config.json
{
  "interface": "eth1",
  "discover": "serftest",
  "encrypt_key": "TywlF+RXm2mHDIUqwCl8/w==",
  "event_handlers": ["/usr/local/libexec/serf/serf-hosts /etc/hosts"],
  "enable_syslog": true
}
EOS

sudo iptables -I INPUT -i eth1 -j ACCEPT
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "hfm4/centos6"
  config.vm.provision :shell, inline: $script

  config.vm.define :one do |c|
    c.vm.hostname = "one.dev"
    c.vm.network :private_network, ip: "192.168.128.2"
  end

  config.vm.define :two do |c|
    c.vm.hostname = "two.dev"
    c.vm.network :private_network, ip: "192.168.128.3"
  end
end
```

以下のコマンドを実行すれば，2つのVMが起動し，serfとserf-hostsが所定の場所に設置される．

```
vagrant up --provision
```

### `/usr/local/libexec`

イベントハンドラ用スクリプトの設置場所については，RHEL6のFHSの説明[^6]を読み，`/usr/local/libexec/serf`で管理するようにした
(FHS 2.3版[^7]にはlibexecが無かったので，`/usr/local/lib`にするか悩んだ．)

> #### 2.2.1.13. /usr/ ディレクトリ
> - __/usr/libexec__、他のプログラムから呼び出される小さなヘルパープログラムを収納

この説明は`/usr/libexec`についてだが，今回はローカルソフトウェアに提供される`/usr/local`を利用する．

### `/etc/serf/conf.d/config.json`

serfの設定ファイルは以下の通りである．`event_handlers`の値はarrayでなければならない．

```json
{
  "interface": "eth1",
  "discover": "serftest",
  "encrypt_key": "TywlF+RXm2mHDIUqwCl8/w==",
  "event_handlers": ["/usr/local/libexec/serf/serf-hosts /etc/hosts"],
  "enable_syslog": true
}
```

### 実行コマンド

このserf (のイベントハンドラ) は`/etc/hosts`へ変更を加えるため，rootユーザで実行されなければならない．
また，単一の設定ファイルであれば`-config-file`で指定すればよい．

```sh
sudo /usr/local/bin/serf agent -config-file=/etc/serf/conf.d/config.json
```

これまでは，gitリポジトリに`/etc/hosts`を管理させ，変更が生じたらデプロイツールでバラ撒いて対応していたが，serf-hostsによって，ホスト情報の追加・削除がとても楽になると思う．

[^1]: [serfの基本的な動作を試してみた](/2014/07/23/try-serf-clustering/)
[^2]: [エンジニアの働き方 | キャリア採用 | 採用情報 | GMOペパボ株式会社](http://pepabo.com/recruit/career/engineer/)
[^3]: [@kentaro](https://twitter.com/kentaro)
[^4]: [kentaro/serf-hosts](https://github.com/kentaro/serf-hosts)
[^5]: [QuickCast. Make. Publish. Share. 3 Minute Screencasts - Free screencasting software for the Apple Mac.](http://quickcast.io/)
[^6]: [2.2. ファイルシステム階層標準 (FHS) の概要](https://access.redhat.com/documentation/ja-JP/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/s1-filesystem-fhs.html)
[^7]: [Filesystem Hierarchy Standard](http://www.pathname.com/fhs/pub/fhs-2.3.html)
