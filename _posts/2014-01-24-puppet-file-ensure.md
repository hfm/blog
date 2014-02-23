---
layout: post
title: PuppetのFileリソースのensure属性present, fileの使い分けについて
tags: 
- puppet
- design pattern
---
Puppet manifestsにおける下記2種類の宣言は、結果が同じになります。

```puppet
file { '/foo/bar':
  ensure => present,
}

file { '/foo/bar':
  ensure => file,
}
```

あまり意識していなかったのですが、どうやらドキュメントを読む限り推奨される使い分けがあるようなので、そのメモを残しておきます。

## ensure => present or file?

ドキュメントには、presentとfileに対してそれぞれ次のような説明が与えられています。

> [___Type Reference — Documentation — Puppet Labs___](http://docs.puppetlabs.com/references/latest/type.html#file-attribute-ensure)
> 
> * `present` will accept any form of file existence, and will create a normal file if the file is missing. (The file will have no content unless the `content` or `source` attribute is used.)
> * `file` will make sure it’s a normal file, and enables use of the `content` or `source` attribute.

`present`は、どのような形式であれ、まずはファイルの存在を確認します。そして、ファイルが存在しなければ通常ファイルを作成しようとします。

一方、`file`は通常ファイルの生成を前提とし、その上で`content`や`source`属性によってファイルの中身を設定します。

### 【注】`present`でも`content`や`source`は使える

もちろん、`file`で出来ることは`present`でも出来ます。

```puppet
file { '/foo/bar':
  ensure  => present,
  content => templates('baz'),
}

file { '/foo/bar':
  ensure  => file,
  content => templates('baz'),
}
```

上記のようなコードを書いた時、ensure属性に対する`present`と`file`は同じ動作をします。
（もしかしたらソースコードを読むと違うのかもしれませんが、[puppetlabs/puppet](https://github.com/puppetlabs/puppet)を読んでも正直わかりませんでした…）

ですので、上に書いた話はあくまで軽く意識しておけばいい話だと思います。

## 補足説明

### 指定ファイルがディレクトリだったら？

上記の話には直接関わらないのですが、`present`と`file`が最も違う挙動をするとすれば、それは「既に指定したパスに __ディレクトリ__ が存在していた場合」です。

#### 実験

例えば次のように、`baz`というディレクトリを設置します。

```console
vagrant@localhost$ file /home/vagrant/puppetdir/baz/
/home/vagrant/puppetdir/baz/: directory
```

次に、この`baz`に対して次のようなmanifestを記述します。

```puppet
file { '/home/vagrant/puppetdir/baz':
  ensure => file,
}
```

これは`/home/vagrant/puppetdir/baz`を通常ファイルとする宣言です。
この実行結果はどのようになるでしょうか。

#### 結果

```console
vagrant@localhost$ puppet apply test.pp
Notice: /Stage[main]//File[/home/vagrant/puppetdir/baz]: Not removing directory; use 'force' to override
Notice: /Stage[main]//File[/home/vagrant/puppetdir/baz]: Not removing directory; use 'force' to override
Error: Could not set 'file' on ensure: Is a directory - /home/vagrant/puppetdir/baz at 3:/home/vagrant/puppetdir/test.pp
Error: Could not set 'file' on ensure: Is a directory - /home/vagrant/puppetdir/baz at 3:/home/vagrant/puppetdir/test.pp
Wrapped exception:
Is a directory - /home/vagrant/puppetdir/baz
Error: /Stage[main]//File[/home/vagrant/puppetdir/baz]/ensure: change from directory to file failed: Could not set 'file' on ensure: Is a directory - /home/vagrant/puppetdir/baz at 3:/home/vagrant/puppetdir/test.pp
Notice: Finished catalog run in 0.03 seconds
```

何故か2回ずつ出力されてしまっているのですが、`Error: Could not set 'file' on ensure: Is a directory`とある通り、ディレクトリに対しての`ensure => file`は無効とされます。

もしディレクトリからファイルへ強制的に変更する場合は、`force => true`を追加すればいいでしょう。

### `present`では成功する

なお、当たり前ですが`ensure => present`ではもちろん成功します。

```puppet
file { '/home/vagrant/puppetdir/baz':
  ensure => present,
}
```

```console
vagrant@localhost$ puppet apply test.pp
Notice: Finished catalog run in 0.03 seconds
```
