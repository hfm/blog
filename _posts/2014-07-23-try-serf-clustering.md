---
layout: post
title: serfの基本的な動作を試してみた
tags:
- serf
---
serf[^1]を知るためにアレコレと試した作業記録のようなもの．

@[glidenote](https://twitter.com/glidenote)先生によるserf-muninの設定やブログ[^2]を眺めたり（同じ部署で大変お世話になっている），公式ドキュメントを眺めたりしながら，Vagrant上でserf clusteringを試した．

何番煎じかも分からないほど後発だが，あくまで備忘録である．

### 試験環境

- CentOS 6.5 x86\_64[^3][^4]
- Serf 0.6.3

以下の簡易な図のように，`one.dev`と`two.dev`という2個のVMを用意し，serf clusterとする．

```
+---------+   serf cluster   +---------+
| one.dev | ---------------- | two.dev |
+---------+                  +---------+
```

## Vagrantfile

導入環境を満たすVagrantfileを用意する．
VMは2つ，それぞれにSerf 0.6.3をインストールする．

```rb
$script = <<SCRIPT
[ -f /usr/local/src/serf.zip ] || wget -q https://dl.bintray.com/mitchellh/serf/0.6.3_linux_amd64.zip -O /usr/local/src/serf.zip
[ -f /usr/local/bin/serf ]     || unzip /usr/local/src/serf.zip -d /usr/local/bin

mkdir -p /etc/serf/conf.d
cat<<EOS >/etc/serf/conf.d/config.json
{
  "interface": "eth1",
  "discover": "serftest",
  "encrypt_key": "TywlF+RXm2mHDIUqwCl8/w==",
  "enable_syslog": true
}
EOS
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

`vagrant up --provision`と実行すれば，serfとその設定ファイルが入ったVMが立ち上がる．

#### `/etc/serf/conf.d/config.json`

Vagrantfileのprovisionによって，serf用設定ファイルが用意される．
`config.json`がそれで，今回はシンプルな設定にすることにした．

```json
{
  "interface": "eth1",
  "discover": "serftest",
  "encrypt_key": "TywlF+RXm2mHDIUqwCl8/w==",
  "enable_syslog": true
}
```

`"interface": "eth1", "discover": "serftest"`を用いて，private networkによるクラスタリングを行う．
`encrypt_key`は無くてもいいが，一応付けた．
また，`enable_syslog`を有効化し，ログを`/var/log/messages`に記録する．

## 単純なクラスタリング

まずはクラスタリング自体が出来るかどうかを確認するため，iptablesによる制限は一時的に止めた．

```
sudo service iptables stop
```

まずはそれぞれのVMからserfを起動する．
起動時に`-config-dir=/etc/serf/conf.d`を指定し，該当ディレクトリ以下の設定ファイルを読み込ませる．

### one.devでserfを起動する

ログの出力はデフォルト`-log-level=info`のままにした．

```shell-session
[vagrant@one ~]$ serf agent -config-dir=/etc/serf/conf.d
==> Using interface 'eth1' address '192.168.128.2'
==> Starting Serf agent...
==> Starting Serf agent RPC...
==> Serf agent running!
         Node name: 'one.dev'
         Bind addr: '192.168.128.2:7946'
          RPC addr: '127.0.0.1:7373'
         Encrypted: true
          Snapshot: false
           Profile: lan
      mDNS cluster: serftest

==> Log data will now stream in as it occurs:

    2014/07/21 23:58:32 [INFO] agent: Serf agent starting
    2014/07/21 23:58:32 [INFO] serf: EventMemberJoin: one.dev 192.168.128.2
    2014/07/21 23:58:32 [INFO] agent: joining: [192.168.128.2:7946] replay: false
    2014/07/21 23:58:32 [INFO] agent: joined: 1 nodes
    2014/07/21 23:58:32 [INFO] agent.mdns: Joined 1 hosts
    2014/07/21 23:58:33 [INFO] agent: Received event: member-join
```

one.dev自身がメンバとしてクラスタに参加し，`member-join`イベントが発行されていることが分かる．

### two.devでserfを起動する

続いてtwo.dev側のserfを起動した．

```shell-session
[vagrant@two ~]$ serf agent -config-dir=/etc/serf/conf.d
==> Using interface 'eth1' address '192.168.128.3'
==> Starting Serf agent...
==> Starting Serf agent RPC...
==> Serf agent running!
         Node name: 'two.dev'
         Bind addr: '192.168.128.3:7946'
          RPC addr: '127.0.0.1:7373'
         Encrypted: true
          Snapshot: false
           Profile: lan
      mDNS cluster: serftest

==> Log data will now stream in as it occurs:

    2014/07/21 23:58:43 [INFO] agent: Serf agent starting
    2014/07/21 23:58:43 [INFO] serf: EventMemberJoin: two.dev 192.168.128.3
    2014/07/21 23:58:43 [INFO] agent: joining: [192.168.128.3:7946 192.168.128.2:7946] replay: false
    2014/07/21 23:58:43 [INFO] serf: EventMemberJoin: one.dev 192.168.128.2
    2014/07/21 23:58:43 [INFO] agent: joined: 2 nodes
    2014/07/21 23:58:43 [INFO] agent.mdns: Joined 2 hosts
    2014/07/21 23:58:44 [INFO] agent: Received event: member-join
```

### クラスタリングを確認する

#### two.dev側のログ

さて，two.dev側のログの，以下の5行を見てみる．
one.devと同じクラスタに参加，ノード数が2に加算され，`member-join`イベントが発行されたことが分かる．

```
    2014/07/21 23:58:43 [INFO] agent: joining: [192.168.128.3:7946 192.168.128.2:7946] replay: false
    2014/07/21 23:58:43 [INFO] serf: EventMemberJoin: one.dev 192.168.128.2
    2014/07/21 23:58:43 [INFO] agent: joined: 2 nodes
    2014/07/21 23:58:43 [INFO] agent.mdns: Joined 2 hosts
    2014/07/21 23:58:44 [INFO] agent: Received event: member-join
```

#### one.dev側のログ

two.dev側でserfを起動したタイミングで，one.dev側にもログが出力されていた．
two.devがクラスタに参加した（クラスタに追加された）通知を`member-join`イベントと共に受け取っている．

```
    2014/07/21 23:58:43 [INFO] serf: EventMemberJoin: two.dev 192.168.128.3
    2014/07/21 23:58:44 [INFO] agent: Received event: member-join
    2014/07/21 23:59:32 [INFO] agent: joining: [192.168.128.3:7946] replay: false
    2014/07/21 23:59:32 [INFO] agent: joined: 1 nodes
    2014/07/21 23:59:32 [INFO] agent.mdns: Joined 1 hosts
```

#### メンバの確認

`serf member`コマンドを実行すると，どのホスト，IPが参加しているかが分かる．

```shell-session
[vagrant@one ~]$ serf members
one.dev  192.168.128.2:7946  alive
two.dev  192.168.128.3:7946  alive
```

ここまでで，単純なクラスタリングの確認を行った．

## iptables

iptablesを起動しているとクラスタリングに失敗することがある．  
結論を先回りすると，以下のようにprivate network側をまるごと許可すれば動く．

```sh
sudo iptables -I INPUT -i eth1 -j ACCEPT
```

### TCP7946番ポート

バインドアドレスは`<ETH1 IP ADDR>:7946`で，TCPの7946番ポートを開ける必要がある（ただし，ポート番号も変更可能．）
しかし，7946番ポートを解放しても，クラスタへの参加は可能になるものの，実はまだ充分ではない．

### UDP, あるいはGossip Protocol

`/var/log/messages`に次のようなログが残っている．

```
Jul 22 00:11:40 localhost serf[3202]: memberlist: Responding to push/pull sync with: 192.168.128.3:46428
Jul 22 00:12:10 localhost serf[3202]: memberlist: Responding to push/pull sync with: 192.168.128.3:46429
Jul 22 00:12:40 localhost serf[3202]: memberlist: Responding to push/pull sync with: 192.168.128.3:46430
```

詳細はまだ調べきれていないのだが，これはGossip Protocol[^5]の挙動の1つで，__UDPで__通信をしている．
自動クラスタリングを行うためにはUDP側の解放も必要らしい（らしい，と書いたのは，繰り返しになるが，私自身がGossip Protocolを理解できていないことに起因する．）

粗い調査で申し訳ないが，Gossip Protocolを活用するためには，やはりeth1側を解放しておくのが楽そうだと感じた．

## Event Handler

イベントハンドラの動作を確認するため，今までのserf agentコマンドに`-event-handler=date`を足した．
dateコマンドによって，ログに時刻が出力されることを期待している．

```
serf agent -config-dir=/etc/serf/conf.d/config.json -event-handler=date
```

イベントハンドラの実行タイミングを知るために，以下のような操作を順番に行った．

```
1. twoがoneへmember-join    | one | <-- member-join  --- | two |
2. oneがtwoへmember-leave   | one | --- member-leave --> | two |
3. oneがtwoへmember-join    | one | --- member-join  --> | two |
4. twoがoneへmember-leave   | one | <-- member-leave --- | two |
```

操作に対する`/var/log/messages`は以下のようになった．

```sh
# 1 .'member-join'が発行されて，`date`の結果が出力されている．
Jul 20 03:40:11 localhost serf[22050]: serf: EventMemberJoin: one.dev 192.168.128.2
Jul 20 03:40:12 localhost serf[22050]: agent: Event 'member-join' script output: Sun Jul 20 03:40:12 JST 2014

# 2. 'member-leave'が発行されて，`date`の結果が出力されている．
Jul 20 03:40:16 localhost serf[22050]: serf: EventMemberLeave: one.dev 192.168.128.2
Jul 20 03:40:17 localhost serf[22050]: agent: Event 'member-leave' script output: Sun Jul 20 03:40:17 JST 2014

# 3. 'member-join'が発行されて，`date`の結果が出力されている．
Jul 20 03:40:19 localhost serf[22050]: serf: EventMemberJoin: one.dev 192.168.128.2
Jul 20 03:40:20 localhost serf[22050]: agent: Event 'member-join' script output: Sun Jul 20 03:40:20 JST 2014

# 4. 自分から離れたため，event-handlerは実行されず．
Jul 20 03:40:23 localhost serf[22050]: serf: EventMemberLeave: two.dev 192.168.128.3
```

自らが（`Ctrl-C`かkillシグナル等を受けて）明示的に離脱する以外はイベントハンドラが発行されていた．

イベントの種類は他にもあるが，突然死でも無い限り，自分が離脱する以外の操作は全てイベントハンドラが発行されるのではないだろうか（全て検証するのは骨が折れるのでやってない．）

Specifying Event Handlers[^6]を見る限りは，イベントハンドラに渡せるイベントの種類は自ら設定できるので，特定のイベントにだけ対応するハンドラを設定することは出来る．

## Tagsと環境変数

serfはイベントハンドラ発行時に環境変数をセットする[^7]．
そこで，以下のようなイベントハンドラを設定し，どのような環境変数が得られるのかを見てみた．

```sh
serf agent -config-dir=/etc/serf/conf.d/config.json -event-handler='env | grep SERF'
```

例えば，`member-join`や`member-leave`イベントが発行されると，以下のような結果が得られた．

```
Jul 20 04:05:12 localhost serf[22169]: serf: EventMemberJoin: one.dev 192.168.128.2
Jul 20 04:05:13 localhost serf[22169]: agent: Event 'member-join' script output: SERF_SELF_NAME=two.dev#012SERF_EVENT=member-join#012SERF_SELF_ROLE=
Jul 20 04:05:17 localhost serf[22169]: serf: EventMemberLeave: one.dev 192.168.128.2
Jul 20 04:05:18 localhost serf[22169]: agent: Event 'member-leave' script output: SERF_SELF_NAME=two.dev#012SERF_EVENT=member-leave#012SERF_SELF_ROLE=
```

`SERF_SELF_NAME`と`SERF_EVENT`はそのままなので省略する．

`SERF_SELF_ROLE=`は何も指定していないので空白だ．
ただし，Configuration[^8]では`-role`がdeprecatedになっており，この環境変数の将来は怪しい．

### `tag role=test`

次に，`-tag role=test`というオプションを付与して，先ほどと同じようにイベントを発行してみた．

```sh
serf agent -config-dir=/etc/serf/conf.d/config.json -tag role=test -event-handler='env | grep SERF'
```

結果は以下のようになった．

```
Jul 20 04:27:58 localhost serf[22230]: agent: Event 'member-join' script output: SERF_SELF_NAME=two.dev#012SERF_EVENT=member-join#012SERF_TAG_ROLE=test#012SERF_SELF_ROLE=test
```

`SERF_TAG_ROLE=test`と`SERF_SELF_ROLE=test`から分かるように，どうやらtagで`role`を設定すると両方に値が入ってしまうらしい．

### `tag munin-group=manage`

また別パターンとして，munin-groupというタグを作って試してみたら，面白い結果になった．

```
Jul 20 04:32:06 localhost serf[22244]: agent: Event 'member-join' script output: SERF_SELF_NAME=two.dev#012SERF_TAG_MUNIN_GROUP=manage#012SERF_EVENT=member-join#012SERF_SELF_ROLE=
```

どうも`munin-group`というtagは`SERF_TAG_MUNIN_GROUP`と解釈されるらしい．
ハイフンをアンダースコアに変換しているようだ．
そもそも，変数の命名規則からしてハイフンを使えないので当然の結果とも取れる．

しかし，この挙動はハマりそうなので，TAG名には英数文字とアンダースコアだけを使うのがいいだろう．

### 1つのタグに複数の値を入れるには

`config.json`を修正して，以下のように，roleにArrayを入れるとどうなるかを見てみた．

```json
{
  "interface": "eth1",
  "discover": "serftest",
  "encrypt_key": "tm+rXm2hdIyWLfUqwCl8/w==",
  "tags": {
    "role": [ "storage", "mogfs" ]
  },
  "enable_syslog": true
}
```

結果は以下のとおりで，エラー文から，`tags[role]`はstring型でないといけないことが分かった．

```shell-session
[vagrant@one ~]$ serf agent -config-dir=/etc/serf/conf.d/config.json -event-handler='env | grep SERF'
==> Error decoding '/etc/serf/conf.d/config.json': 1 error(s) decoding:

* 'tags[role]' expected type 'string', got unconvertible type '[]interface {}'
```

よって，1つのタグに複数の値を付与したい（マルチロールなサーバ等）場合は，以下のようなカンマ区切り等のローカルルールを取り決め，プログラム側でsplitするしか無さそうだ．

```json
{ "role": "storage,mogfs" }
```

ちなみに上記の場合，`SERF_TAG_ROLE=storage,mogfs`という値が得られる．

## 終わりに

serfの挙動を知るために，VagrantでVMを用意し，クラスタリングを試してみた．
まだイベントハンドラの扱いが充分ではないが，serf自身の基本的な動作はそれなりに分かってきた．

後，Gossip Protocolについての理解も不十分なので，その辺りの勉強もしていきたい．

[^1]: [Serf](http://www.serfdom.io/)
[^2]: [serf-muninを導入してmunin-nodeの監視追加、削除を自動化した - Glide Note - グライドノート](http://blog.glidenote.com/blog/2013/11/06/serf-munin/)
[^3]: [tacahilo/packer-centos-6](https://github.com/tacahilo/packer-centos-6)
[^4]: [hfm4/centos6](https://vagrantcloud.com/hfm4/centos6)
[^5]: [Gossip Protocol - Serf](http://www.serfdom.io/docs/internals/gossip.html)
[^6]: [Specifying Event Handlers - Serf](http://www.serfdom.io/docs/agent/event-handlers.html)
[^7]: [Event Handlers - Serf](http://www.serfdom.io/docs/agent/event-handlers.html)
[^8]: [Configuration - Serf](http://www.serfdom.io/docs/agent/options.html)
