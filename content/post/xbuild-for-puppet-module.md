---
layout: post
title: puppet-xbuildをmodule化しました
date: 2014-02-22
tags: 
- puppet
- xbuild
---
『[xbuildのpuppet化にあたり考えたこと](http://blog.hifumi.info/2014/01/12/puppetize-xbuild/)』で書いたxbuild用puppet manifestsをmodule化しました。

 * [hfm/xbuild · Puppet Forge](https://forge.puppetlabs.com/hfm/xbuild)
 * [tacahilo/puppet-xbuild](https://github.com/tacahilo/puppet-xbuild)

![](/images/2014/02/22/puppetxbuild@2x.png)

## 使い方

### module install

installするには以下のようなコマンドを実行します。

```sh
puppet module install -i modules/ hfm/xbuild
```

`-i`のあとに入れるのはmodules pathです。

上記コマンドを実行すると、以下のようなmanifestsがインストールされます。

```
xbuild/
├── init.pp
├── install.pp
└── lang
    └── install.pp
```

### example

このmoduleの実行例は以下のとおりです。
`/usr/local/<LANG>-<VERSION>`にインストールされます。

```puppet
include ::xbuild

::xbuild::lang::install { 'ruby':
  version => '2.1.0',
}

::xbuild::lang::install { 'python':
  version => '2.7.6',
}

::xbuild::lang::install { 'php':
  version => '5.6.0alpha2',
}
```

インストールしたいディレクトリを変更する場合は、`$installdir`変数にパスを指定します。

```puppet
::xbuild::lang::install { 'ruby':
  version    => '2.1.0',
  installdir => '/usr/local/lang/',
}
```

xbuild最高ですね!
