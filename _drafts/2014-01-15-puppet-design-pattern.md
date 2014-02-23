---
layout: post
title: Puppet, そしてデザインパターンについて
tags: 
- puppet
- design pattern
---
Puppetのデザインパターンについての提案とそれに対する考察、実際について。

## Index

 * [Introduction](#intro)
   * [What's "Puppet" and other provisioning tools?](#what)
   * [As is, To be](#asistobe)
     * [Infrastructure as a code](#sample)
     * [However, actually...](#actuality)
   * [Why Puppet?](#why)
     * [Past performance](#performance)
     * [Text book and job training](#materials)
 * [Design Pattern](#designpattern)
   * [Roles / Profiles](#roles-and-profiles)

## <a name="intro"></a>Introduction

### What's "Puppet" and other provisioning tools?

サーバ構成の管理自動化ツールとしてペパボでは主にPuppetを利用している。

`puppet apply`あるいは`puppet agent`等とコマンドを打つことで、そのサーバに全うしてもらいたい役割を与えられる。
Puppetを使うことで、`yum install foo`を数回叩くこと、エディタでファイルを何回も編集することを自動化させることが出来る。

しかし、PuppetやChef、あるいは別なProvisioning toolsは決して「自動インストールツール」だけではない。

それはあくまで1つの要素、1つの側面に過ぎず、その真価は「 __あるべき状態を定義し、管理する__」ことにあると思う。

### As is, To be

あるべき状態とは何か。

例えば、あるサーバにApacheが入っていてほしいとか、サーバ再起動後にhttpdも自動起動してほしいとか、用意したapache.confがあるべきディレクトリ内に設置されていてほしいとか、httpdを動かすUID/GIDはwwwであってほしいとか、そうしたサーバを構築する上で必要な各要素・要件をPuppetを用いて「定義」しておく。

「役割に応じた構成そのもの」を定義するのがProvisioning Toolsで、Puppetはその仲間の一つだ。

上述の通り、一度定義しておけば、あとはコマンドを実行するだけでパッケージや設定ファイル等が順次適応されていく。

一度定義された構成は、「 __冪（べき）等性__ 」言う、何度実行しても同じ構成を保てるProvisioning Toolsの加護のもとに自動化され、管理されることになる。

#### Infrastructure as a code

具体的にコードで書いてみる。
例えば次の要件があるとする。

 * httpdをyum installしたい
 * installされたhttpdは起動させたい
 * httpdは再起動しても自動起動するようにしたい
 * init scriptによる起動後のステータスコードは0であるべき
 * httpd.confには自分で用意したファイルを設置したい

この要件を満たしたいと思えば、次のようなPuppet manifestsが必要になる。

```puppet
package { 'httpd':
  ensure => installed,
}

service { 'httpd':
  ensure    => running,
  enable    => true,
  hasstatus => true,
}

file { '/etc/httpd/httpd.conf':
  ensure => file,
  source => 'puppet:///httpd/etc/httpd/httpd.conf',
}
```

このPuppet manifestsが実行されると、`yum install httpd`、`/etc/init.d/httpd start`、`chkconfig httpd on`、そして`/etc/httpd/httpd.conf`に設定ファイルが設置される。

先に述べた通り、冪等性を担保するmanifestsであれば、何度実行しても結果は同じになる。
つまり、2度目の実行では何も起きないし、`yum remove httpd`のあとで実行すれば、1度目と同じ状態に戻る。

#### However, actually...

もちろん各要素には少なからず依存関係があり、複雑な環境においては、コマンド一発で全てが通らないこともある。

理想とは裏腹に、Puppet manifestsそのものがゴチャついてしまい、実行時に依存関係でエラーを起こしてしまったりしている。
その結果、複数回manifestsを実行したり不要なファイル・パッケージを取り除いたり、そういう現実もある。

### Why "Puppet"?

#### Past performance

今でこそChefやAnsibleのような後発のProvisioning Toolsがあり、なぜPuppetなのかといえば、それはペパボにおける実績である。  

性能的に優れているとか、どういうシーンで同類ツールと比べてどう適当であるとか、そういう明確な数値による評価を期待していた人には申し訳なく思う。
ただ、実績があるということは、（決して盲信してはいけないが）やはりそれだけでも素晴らしいことだ。

#### Text book and job training

私が入社後に受けさせていただいた新卒エンジニア研修でもPuppetを利用した内容があり、またそこでは[栗林さん](https://twitter.com/kentaro)が書いた『[入門Puppet](http://www.amazon.co.jp/dp/B00CL92JC0/)』を利用したことも過去のブログで紹介している。

 * [ペパボ新卒エンジニア研修 後編 | blog: takahiro okumura](http://blog.hifumi.info/2014/01/04/web-operation/)
 * [『入門Puppet - Automate Your Infrastructure』という電子書籍を出版しました - delirious thoughts](http://blog.kentarok.org/entry/2013/04/30/225404)

また、2010年のものになるが、ペパボのテクニカルマネジャである[宮下さん](https://twitter.com/gosukenator)がhbstudy#8でPuppetの紹介をしている。

{% slideshare 3258268 %}

そしてこれも宮下さんによるものだが、gihyo.jpの連載『オープンソースなシステム自動管理ツール Puppet』でPuppetの具体的な使い方や活用事例を紹介している。

 * [オープンソースなシステム自動管理ツール Puppet：連載｜gihyo.jp … 技術評論社](http://gihyo.jp/admin/serial/01/puppet)

## Puppet Design Pattern

簡単に、と言っておきながら非常に長くなってしまった。

Roles / Profilesというデザインパターンを提案している。

 * [Designing Puppet – Roles and Profiles. - - Craig Dunn's Blog](http://www.craigdunn.org/2012/05/239/)

また上記ブログ内容をスライド形式で紹介したスライドは以下にある。

{% slideshare 16411183 %}


## Roles / Profiles

```
puppetdir/
|-- manifests
|-- modules
|   |-- ntp
|   |-- selinux
|   |-- xbuild
|   `-- ...
|-- profiles
|   |-- base
|   |-- manage
|   `-- ...
`-- roles
    `-- localhost
```
