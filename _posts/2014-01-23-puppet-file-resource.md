---
layout: post
title: PuppetのFileリソースタイプにはensure属性をなるべくつけた方が良い
tags: 
- puppet
- design pattern
---
例えば以下のようなPuppet Manifestがある時に、その実行結果はどうなるでしょうか。

```puppet
file { '/foo/bar':
  source => 'puppet:///modules/one_module/foo/bar',
}
```

結論から言うと、`bar`のタイプによって少なくとも3種類の結果が予測されます。
`bar`がfileであればファイルが、directoryであれば空のディレクトリが設置され、linkであればsymlinkが設置されます。

※ただしsymlinkはtargetが存在しなければ失敗します。

## ファイルタイプ次第で挙動を変えてしまうsource

上述の通り、fileリソースにsource __だけ__ を指定すると、source URIに指定されたパスの中身次第で、puppetはその挙動を変えてしまいます。

良く言えば柔軟な対応なのですが、実際の運用の場合はsourceが何であるかを判別しにくく、source onlyの指定は好ましいとは言えません。

### file

パスの中身がファイルであれば、そのファイルがそのまま設置されるので、以下のManifestと等価となります。

```puppet
file { '/foo/bar':
  ensure => file, #あるいはpresent
  source => 'puppet:///modules/one_module/foo/bar',
}
```

### directory

ディレクトリである場合は、以下のManifestと等価であることを意味します。

```puppet
file { '/foo/bar':
  ensure => directory,
}
```

### symlink

symlinkである場合は、linktargetが有効であるかを判定し、有効であればsymlinkを、無効であればエラーを返します。

```
puppetdir/
|-- modules
|   `-- one_module
|       `-- files
|           `-- foo
|               `-- bar -> ../baz
`-- test.pp
```

上記のような構成で、以下のようにbarを設置しようと試みます。

```puppet
file { '/home/vagrant/bar':
  source => 'puppet:///modules/one_module/foo/bar',
}
```

すると結果は以下のとおり。

```
[root@localhost puppetdir]# puppet apply test.pp --modulepath=modules
Error: /Stage[main]//File[/home/vagrant/bar]: Could not evaluate: Could not retrieve information from environment production source(s) puppet:///modules/one_module/foo/bar
Notice: Finished catalog run in 0.02 seconds
```

symlinkが無効の場合はこのようなエラーが出ます。

## Fileリソースタイプでsourceを使う場合

このように、Fileリソースでsourceを使うときは指定先の種類が複数考えられるため、ensure属性も併せて指定することで可読性を保ちましょう。

```puppet
file { '/foo/bar':
  ensure => file,
  source => 'puppet:///modules/one_module/foo/bar',
}
```

### 参考

 * [Type Reference #file — Documentation — Puppet Labs](http://docs.puppetlabs.com/references/latest/type.html#file)
 * [The Puppet File Server — Documentation — Puppet Labs](http://docs.puppetlabs.com/guides/file_serving.html)
