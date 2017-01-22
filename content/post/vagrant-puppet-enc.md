---
date: 2014-12-31T08:45:11+09:00
title: Vagrant で Puppet ENC (External Node Classifiers) を試す
tags:
- puppet
- vagrant
---
PuppetにはExternal Node Classifiers (以降ENC)という、node定義を`site.pp`以外に任せられる仕組みがある。

- https://docs.puppetlabs.com/guides/external_nodes.html

これを利用すると、hieraや`site.pp`以外にnodeの管理を任せることが出来る。

あまり使い方が分かっていなかったのだけど、基礎的な部分を[@lamanotrama](https://twitter.com/lamanotrama)さんから教えてもらったので、今回はVagrant越しに実行できるか試してみた。

## ENCの実装・フォーマットについて

ENCの実装自体は何であっても構わないが、出力は**YAML**でなければならない。
(あと、精確には`site.pp`等との併用も可能で、その辺は上手いことPuppetがマージしてくれるらしい)

[ENC Output Format](https://docs.puppetlabs.com/guides/external_nodes.html#enc-output-format)を見ると、出力には`classes``parameters``environment`のハッシュキーが認められると書かれている。
かつ、少なくともENCから出力されるデータには`classes`か`parameters`が無いといけない。

ENCによる出力例を以下に示す。

```yaml
--- 
classes:
  - base
  - ntp
environment: development
parameters:
  ntp_servers:
    - 0.pool.ntp.org
    - 1.pool.ntp.org
```

classesにはbase, ntpが含まれ、environmentはdevelopment、parametersにはntp_servers:として0.pool.ntp.orgと1.pool.ntp.orgが含まれている。

## Vagrant で ENC を試す

さて、ここからはVagrantを用いて、ENCの単純な実装例とその結果を見てみる。

### 構成

今回実験で使用する構成は以下のとおりだ。
`Vagrantfile``enc``init.pp`の3つを基礎としている。

```
$ ls -l
total 24
-rw-rw-r--  1 usr0600296  wheel   833 12 31 07:58 Vagrantfile
-rwxr-xr-x@ 1 usr0600296  wheel   125 12 31 08:06 enc
-rw-rw-r--  1 usr0600296  wheel  1966 12 31 07:43 init.pp
```

### Vagrantfile

以下にVagrantfileの例を示す。

hfm4/centos6は私が作成したvirtualbox用のboxだ[^1][^2]。
shellプロビジョンでPuppet 3.7.3をインストールしている。
puppqtプロビジョンのオプションでは、ENCを使うために、`--node_terminus=exec`と`--external_nodes=/vagrant/enc`を指定している。
`init.pp`は後述する。

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "hfm4/centos6"

  config.vm.provision :shell do |install_puppet|
    install_puppet.inline = <<-'SCRIPT'
      require_version='3.7.3'
      puppet_version=$(rpm -q --queryformat '%{VERSION}' puppet)
      [ "$puppet_version" = "$require_version" ] || {
          rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
          rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
          yum install -y "puppet-${require_version}"
      }
    SCRIPT
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "."
    puppet.manifest_file  = "init.pp"
    puppet.options = []
    puppet.options << "--node_terminus=exec"
    puppet.options << "--external_nodes=/vagrant/enc"
  end
end
```

### init.pp

`base`クラスがincludeされたら`notice`で返事するようにしている。

```puppet
class base {
  notice('I'm included!')
}
```

### ENC

肝心のENCだが、今回はRubyで実装してみた。
今回は`classes`情報だけを持たせることにした。

```ruby
#!/usr/bin/env ruby
# coding: utf-8

require 'yaml'

enc = {}
enc['classes'] = []
enc['classes'] << 'base'

puts enc.to_yaml
```

このENCを単体実行すると、以下の様な出力が得られる。

```yaml
--- 
classes:
- base
```

余談だが、`ARGV[0]`にはFQDNが入っているようだ。

## 実行結果

shellプロビジョンは長いので、2回目以降の結果を表示する。

```
$ vagrant provision
==> default: Running provisioner: shell...
    default: Running: inline script
==> default: Running provisioner: puppet...
==> default: Running Puppet with init.pp...
==> default: Notice: Scope(Class[Base]): I'm included!
==> default: Notice: Compiled catalog for localhost in environment production in 0.10 seconds
==> default: Info: Applying configuration version '1419906181'
==> default: Notice: Finished catalog run in 0.04 seconds
```

`==> default: Notice: Scope(Class[Base]): I'm included!`とあるように、init.ppにある`base`クラスが無事呼びだされていることが分かる。
先述の通り、`classess`が`base`クラスを内包しているからだ。

さて、今回使った検証環境はGitHubに公開している。
実行してみたい方は以下のURLからご確認頂きたい。

- https://github.com/hfm/vagrant-puppet-enc-demo

## まとめ

サーバの台数やロールが増えるに連れて、manifestsでのnode管理は面倒になる。
site.ppやnode.ppといったファイルに手動でnode情報を管理するのは大変で、スケールもしにくい。

Puppet ENCは、そんな面倒なnode管理をRubyやPythonといった外部プログラムに任せることが出来る。
manifestsに比べて、柔軟なnode管理が実現出来るだろう。

ちなみにENCは、hieraと組み合わせることも可能だ。
ENCにhieraの情報を読み込ませるようにすれば、（hieraとENC、どちらに何を任せるべきかが難しくなるが）より柔軟な設計が出来るようになるだろう。

[^1]: https://vagrantcloud.com/hfm4/boxes/centos6
[^2]: https://github.com/hfm/packer-centos-6
