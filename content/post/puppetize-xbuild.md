---
title: xbuildのpuppet化にあたり考えたこと
date: 2014-01-12
tags: 
- puppet
- xbuild
---
xbuildをpuppetで管理しようと思って、その構成について考えたことです。

#### この記事で書かないこと

 * なぜpuppetなのか
 * puppetの書き方・使い方の基本
 * puppetの本番での活用方法

この辺りは、[栗林さん](https://twitter.com/kentaro)著の『[入門Puppet](http://www.amazon.co.jp/dp/B00CL92JC0/)』がオススメです。

[![入門Puppet - Automate Your Infrastructure](http://ecx.images-amazon.com/images/I/31pxYolccUL._SL160_.jpg)  
入門Puppet - Automate Your Infrastructure](http://www.amazon.co.jp/exec/obidos/ASIN/B00CL92JC0/hifumiass-22/ref=nosim/)

## modularize xbuild

### xbuild

[xbuild](https://github.com/tagomoris/xbuild)は[@tagomorisさん](https://twitter.com/tagomoris)が開発したproduction環境向けプログラミング言語インストーラです。
現在はPerl, Ruby, Node.js, PHP, Pythonをサポートしています。

 * [tagomoris/xbuild](https://github.com/tagomoris/xbuild)
 * [本番環境でのperl/ruby/nodeのセットアップ - tagomorisのメモ置き場](http://d.hatena.ne.jp/tagomoris/20130326/1364289705)

```sh
$ xbuild/ruby-install 2.1.0 ~/local/ruby-2.1.0
```

このようなコマンドを実行すると、ruby-2.1.0が指定ディレクトリにインストールされます。あとはPATHを追加するだけでruby-2.1.0が使えるようになる、という仕組みです。

今回はこのxbuildをpuppetで管理しようと思った時に、そのmanifests構成についてあれこれ考えたことをまとめています。

### manage as a module

puppetで管理するのであれば、modulesとして以下のように管理しましょう。

```
puppet_dir/
|-- manifests
|   `-- a_role.pp
|-- modules
|   `-- xbuild
|       `-- manifests
|           |-- init.pp
|           `-- install.pp
`-- roles
    `-- a_role
```

この所以はpuppetlabsが公式にアナウンスしているBest Practiceです。

> [*Best Practices — Documentation — Puppet Labs*](http://docs.puppetlabs.com/guides/best_practices.html#use-modules-when-possible)
> 
> Use Modules When Possible  
> [Puppet modules](http://docs.puppetlabs.com/puppet/latest/reference/modules_fundamentals.html) are something everyone should use. If you have an application you are managing, add a module for it, so that you can keep the manifests, plugins (if any), source files, and templates together.

### xbuild manifests

xbuildのmanifestsを構成する際は、以下の様な実装が考えられます。  
※これは弊社ペパボでも実際に使われている、[栗林さん](https://twitter.com/kentaro)による実装です。

```
modules/xbuild/
`-- manifests
    |-- init.pp
    `-- install.pp
```

```puppet
class xbuild {

  include xbuild::install

}
```

```puppet
class xbuild::install {

  exec { 'install xbuild':
    path    => '/usr/bin',
    command => 'git clone git@github.com:tagomoris/xbuild.git /usr/local/xbuild',
    creates => '/usr/local/xbuild',
    require => Package['git'],
  }

}
```

あとはroleクラスで`include xbuild`すれば、xbuildが利用可能になります。

## xbuild経由の言語のmodule化

ここからが悩んだことなんですが、xbuild経由での言語インストールを構成管理化する際に、manifestsはどのように設計すべきでしょうか。

### lang modulesの配置案その1

例えば以下のような実装を考えてみましょう。

```
modules/
|-- ruby
|   `-- manifests
|       `-- init.pp
`-- xbuild
    `-- manifests
        |-- init.pp
        `-- install.pp
```

この構成における`modules/ruby/manifests/init.pp`は以下のような実装とします。

```puppet
define ruby (
  $version    = $title,
  $installdir = '/usr/local',
) {

  exec { "ruby-build ${version}":
    path    => ['/bin', '/usr/bin', '/usr/local/xbuild'],
    command => "ruby-install ${version} ${installdir}/ruby-${version}",
    creates => "${installdir}/ruby-${version}",
    timeout => 0,
  }

}
```

この実装によれば、例えばruby-2.1.0を扱いたいroleにおいて、`::ruby { '2.1.0': }`と書けばインストールが可能です。

あるいはこの実装のファイル名を`modules/ruby/manifests/install.pp`に変えて、define名を`define ruby::install`とすると、呼び出し側は`::ruby::install { '2.1.0': }`と書くことができるので、こちらのほうが可読性が高いとも言えます。

しかし、上記の設計には次のような難所を抱えています。

### module同士の依存

あるmoduleが別のmoduleを宣言するようなmodule同士の依存はあまり良くありません。
これは再配布のしにくさや、ちょっとした変更・修正からの思わぬコンフリクトを生みかねないからです。

これはpuppetlabsの公式ドキュメントにも明記されています。

> [Module Fundamentals — Documentation — Puppet Labs](http://docs.puppetlabs.com/puppet/latest/reference/modules_fundamentals.html#best-practices)
> 
> #### Best Practices
> 
> The classes, defined types, and plugins in a module should all be related, and the module should aim to be as self-contained as possible.
> 
> Manifests in one module should never reference files or templates stored in another module.
> 
> Be wary of having classes declare classes from other modules, as this makes modules harder to redistribute. When possible, it’s best to isolate “super-classes” that declare many other classes in a local “site” module.

出来る限り、module同士の依存は避けるべきです。

### lang modulesの配置案その2

そこで考えたのは次の案です。  
※`modules/xbuild/manifests/{init,install}.pp`の実装は上述のとおりです。

```
modules/xbuild/
`-- manifests
    |-- init.pp
    |-- install.pp
    |-- node
    |   `-- install.pp
    |-- perl
    |   `-- install.pp
    |-- php
    |   `-- install.pp
    |-- python
    |   `-- install.pp
    `-- ruby
        `-- install.pp
```

これはxbuild moduleのinplementationとして実装する方法です。

 * [Module Fundamentals#Example — Documentation — Puppet Labs](http://docs.puppetlabs.com/puppet/2.7/reference/modules_fundamentals.html#example)

そして`modules/xbuild/manifests/ruby/install.pp`は以下の様に実装します。

```puppet
define xbuild::ruby::install (
  $version    = $title,
  $installdir = '/usr/local',
) {

  exec { "ruby-build ${version}":
    path    => ['/bin', '/usr/bin', '/usr/local/xbuild'],
    command => "ruby-install ${version} ${installdir}/ruby-${version}",
    creates => "${installdir}/ruby-${version}",
    timeout => 0,
  }

}
```

全体像が見やすくなるよう、GitHubにリポジトリを用意しました。

 * [tacahilo/puppet-xbuild-each](https://github.com/tacahilo/puppet-xbuild-each)



この実装はmodule同士の依存がなく、名前空間的にも言語インストールにxbuildを経由していることが分かりやすくになっています。

しかし、この実装にもやはり気になるところがあります。

#### 各言語のinstall.ppが決め打ちになっている

`::xbuild::ruby::install`というクラスは一見分かりやすいですが、やや具体的になりすぎています。
ここで言う具体的とは、悪く言えば限定的な設計で、変化に弱いということになります。

puppet manifestsによる構成管理を考える上で、またxbuildがサポートを拡張する可能性※も考慮すると、もう少し設計を抽象化させた方が使いやすさの向上に繋がると考えました。

※xbuildのサポート拡張可能性は私が勝手に考えているだけのことですが、プロダクトは常に変化していくものである以上、対象プロダクトに問わず適宜バランスを取るべきだと思います。

### lang modulesの配置案その3

最終的に自分の中で落ち着いた実装は以下になります。

```
modules/xbuild/
`-- manifests
    |-- init.pp
    |-- install.pp
    `-- lang
        `-- install.pp
```

`modules/xbuild/lang/install.pp`の実装は次の通りです。

```puppet
define xbuild::lang::install (
  $language   = $title
  $version,
  $installdir = '/usr/local',
) {

  exec { "{$language}-build ${version}":
    path    => ['/bin', '/usr/bin', '/usr/local/xbuild'],
    command => "${language}-install ${version} ${installdir}/${language}-${version}",
    creates => "${installdir}/${language}-${version}",
    timeout => 0,
  }

}
```

このmanifestの使い方は次の通りです。

```puppet
::xbuild::lang::install { 'ruby':
  version    => '2.1.0',
}
```

こちらもGitHubにリポジトリを用意しています。

 * [tacahilo/puppet-xbuild](https://github.com/tacahilo/puppet-xbuild)

#### 適切な抽象化と再配布可能性について

長々と遠回りをしてきた気もしますが、これぐらいの抽象度をもっておけば、例えばxbuildが新たな言語をサポートした時も対応できますし、無効な言語を指定してもxbuild側で吸収してくれます。

会社で使ってるpuppetにはまだ適応していない（休み中に思いついたので…）ですが、個人用のpuppet manifestsには早速利用しています。

puppetで管理すべき内容と、module自体（今回で言えばxbuild）で制御すべき内容についての議論は様々ありますが、今回の落とし所はこの辺りじゃないかなあと考えています。

この実装についてご意見等あればツイッター等で是非お願いします。

## 補足

### timeoutについて

ビルドには時間がかかるため、timeoutを0（無効）にするか、大きめの数字を取る方が良いです。  
※default timeoutは300秒 (ref: [Type Reference — Documentation — Puppet Labs](http://docs.puppetlabs.com/references/latest/type.html#exec-attribute-timeout))。

```puppet
  timeout => 0,
```

### インストールディレクトリについて

今回はインストールディレクトリを`/usr/local/<LANG>-<VERSION>/`としていますが、これはサービスのproduction環境によって異なると思うので、利用別に検討すべきだと思います。
