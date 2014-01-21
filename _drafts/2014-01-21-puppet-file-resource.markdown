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

ファイルであれば、

特にディレクトリである場合は、以下のManifestと等価であることを意味します。

```puppet
file { '/foo/bar':
  ensure => directory,
}
```

## source属性とPuppet URI scheme

### source属性の挙動

source属性はリモートファイルのURIを指定することで、指定先からデータをダウンロードし、宣言箇所 (`/foo/bar`) に設置するための属性です。

ここで注意しなければいけないのは、source属性はあくまでURIでしかなく、リモートにあるものがfile, dir, linkなのかはその後の処理に任せているということです。

PuppetにおけるFileリソースタイプというのは、`/foo/bar`という絶対パスに対して

### Puppet URI schemeの読み方

詳しくは公式ドキュメントに書いてあるので、理解を深めるためにはそちらにも必ず目を通しましょう。

 * [The Puppet File Server — Documentation — Puppet Labs](http://docs.puppetlabs.com/guides/file_serving.html)

Puppet固有のURI schemeは以下のような構成になっているようです。

```
puppet://{server hostname (optional)}/{mount point}/{remainder of path}
```

この内、`{server hostname (optional)}`の部分に関しては省略されることもあります。

```
puppetdir/
└── modules
    └── one_module
        ├── files
        │   └── foo
        │       └── bar
        ├── manifests
        └── templates
```

 * [Type Reference #File — Documentation — Puppet Labs](http://docs.puppetlabs.com/references/latest/type.html#file)
