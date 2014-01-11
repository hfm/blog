---

layout: post
title: xbuildをpuppet化するにあたって考えたこと
tags: 
- puppet
- xbuild
---
[@tagomoris](https://twitter.com/tagomoris)さんの作ったxbuildをpuppetで管理しようと思って一考しました。

 * [tagomoris/xbuild](https://github.com/tagomoris/xbuild)
 * [本番環境でのperl/ruby/nodeのセットアップ - tagomorisのメモ置き場](http://d.hatena.ne.jp/tagomoris/20130326/1364289705)

## modularize

xbuildは、puppetで管理するのであれば、そしてモダンなやり方であればmodulesに管理するのがいいと思います。

```
.
├── manifests
│   ├── arole.pp
│   └── ...
├── modules
│   ├── xbuild
│   │   └── manifests
│   ├── othermodules
│   │   ├── files
│   │   ├── manifests
│   │   └── templates
│   └── ...
├── roles
│   ├── arole
│   └── ...
└── spec
    └── hostname or localhost
    └── spec_helper.rb
```

何を持ってモダンと言っているのかについては、以下の書籍を参考にしました。

また、puppetlabsはmodulesとrolesの中間層にprofilesというパターンを提案しているのですが、これは大規模サービスでも無い限りは、抽象化されすぎるあまり、かえって分かりづらくなるのではないかと懸念されます。

{% slideshare 16411183 %}

自宅サーバとか、そこまで大規模でないサービスの運営にあたっては、modulesとrolesで十分ではないでしょうか。

### base classの置き場所

とはいえ、modules/roles構成の難所としては、いわゆる「base」クラスをどっちに置くかという問題があります。

rolesというディレクトリは、文字通り役割です。
この役割はサーバごとに割り当てられるもので、「このサーバはアプリケーションサーバだ」とするのであれば、app(lication)というrole名でディレクトリが生成されるでしょう。
データベースやプロキシサーバがあれば、それも同様かと思われます。

しかし、baseというクラスはなんでしょうか。
私の考えでは、これは役割ではないと感じています。しかし、moduleでも無いと思います。

とくにmodulesにしたくない理由としては、modulesというのは互いに独立した存在であったほうが好ましく、baseというクラスに複数のmodulesをincludeしておきたくないのです。

先ほどのprofilesという概念を用いることでこの問題は解消されるのですが、たかだかbaseクラスの置き場所のためだけにmodules/profiles/rolesという三段構成にするのも、構造の複雑さを増してしまいます。

なので歯痒い思いはしますが、baseクラスはmodules or rolesディレクトリに設置し、特例としていることが多いです。

## xbuild経由の言語のmodule化


