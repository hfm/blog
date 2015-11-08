---
date: 2014-12-27T22:44:16+09:00
title: Puppetのyumrepoリソースでよく指定する属性
tags:
- puppet
---
Puppetのyumrepoリソースは属性が多くて覚えにくいので、「この属性は必要だ」と思った項目についてまとめた。

## その前に`yumrepo`リソースについて

外部リポジトリをPuppet manifestsで管理したい場合に、`yumrepo`リソースがある。

- Type Reference  
https://docs.puppetlabs.com/references/latest/type.html#yumrepo

ちなみに、各属性の意味については、`yum.conf(5)`の各項目との対応付けが公式ドキュメントに記載されている。

### yumrepoリソースの属性は多すぎる

Type Referenceのyumrepoリソースを見ると、yumrepo固有の属性は38個もある。
中には`s3_enabled`みたいな普段使わなさそうな属性もあったり、何よりこれだけ属性があると優先順位が分からない。

## 普段指定する属性

### サンプル

場合によってはgpgkey, gpgcheckも付けなかったりするけど、まあこれまであれば大体不自由なく動く。
`rpm -ivh`でインストールしても、だいたいこれぐらいの項目とプラスアルファが付いてくる。

```puppet
# a sample manifest
yumrepo { 'epel':
  descr    => 'Extra Packages for Enterprise Linux 6 - x86_64',
  enabled  => 1,
  baseurl  => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
  gpgcheck => 1,
}
```

### descr

descrをつけないと、yum.conf(5)の`name`パラメタが指定されず、yum実行時に以下のような警告が出る。

```
Repository 'REPOSITORYID' is missing name in configuration, using id
```

これは地味にうざいので、descrはちゃんとつけたほうがいいと思う。

### enabled

コレがなかったらどうするのと言うレベルで必要な奴。

### baseurl

上に同じく。
これが無いとリポジトリにアクセス出来ないし。

### gpgkey

epelとかpuppetlabsとかにちゃんとGPGキーは付いてるので、コレは属性としてあった方が良さそう。

### gpgcheck

gpgkeyつけるならこちらも。たまにどっちも省いたり、わざとチェックしないとかもするけど、基本的にはチェックした方がいいと思う。

## 悩んだけど付けなかった項目

### `mirrorlist`

epelとかrpmforgeにはついてくるミラーリスト指定用の属性。

だけどyumrepoリソースを使って管理したい外部リポジトリって、epelやrpmforgeよりも、treasuredataやpuppetlabs, あるいはオレオレyumリポジトリだったりするので、まあ良いかなという感じ。

ちなみにepelやrpmforgeであれば、packageリソースでインストールすれば良いと思う。

```puppet
package { 'epel-release':
  ensure   => installed,
  source   => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
  provider => rpm,
}
```

### `failovermethod`

`mirrorlist`を省いたのでこちらも省いた。

## おまけ: neosnippets.vim用snippet

普段Puppet manifestsに使っているyumrepo用snippetを残しておく。

```vim
snippet yumrepo
  yumrepo { '${1:repo name}':
    descr    => '${2:$1}',
    enabled  => ${3:1},
    baseurl  => '${4:url}',
    gpgkey   => '${5:key}',
    gpgcheck => ${6:1},
  }
```
