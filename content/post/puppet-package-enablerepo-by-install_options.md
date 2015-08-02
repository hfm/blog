---
date: 2014-12-29T05:34:11+09:00
title: Puppet 3.6からpackageリソースでenablerepo/disablerepoが使える
tags: 
- puppet
---
yumコマンドでパッケージを入れるときに，`--enablerepo`や`--disablerepo`を使ってリポジトリを指定することが出来る．

Puppet 3.6から，この2つの機能を`install_options`という属性に任せることで利用可能になった．

## `install_options`と`enable/disablerepo`の使い方

使い方は簡単で，以下のように`install_options`属性に配列か文字列で`--enablerepo``--disablerepo`を指定すれば良い．

```puppet
package { 'the-package':
  ensure          => installed,
  install_options => ['--enablerepo=rpmforge', '--disablerepo=*'],
}
```

### いつから使えるようになったか

タイトルにも出だしにも書いたが，Puppet 3.6.0から使えるようになった．

> Several providers were updated to support the `install_options` attribute, and the yum provider now has special behavior to make `--enablerepo` and `--disablerepo` work well when you set them as `install_options`.
> 
> *https://docs.puppetlabs.com/puppet/3.6/reference/release_notes.html#package*

このオプションが入るまでの細かい経緯は以下のコミットやチケットを見るのが良い．

- https://tickets.puppetlabs.com/browse/PUP-1060
  - ちなみにだけど，チケットURLの"Description"にあるのは「要望」であって，実現された機能では無いことに注意．enablerepoなんて属性は無いし，disablerepoなんて属性も無い．
- https://github.com/puppetlabs/puppet/commit/a4abf13d353371c3568360f3101d01d4e3b7b4e6
- https://github.com/puppetlabs/puppet/commit/6dc0a0efbd8fd03bfddbf0c1066e2c252a154900

## 別々のリポジトリに同名のパッケージがある可能性

このオプションがどういうところで役に立つかというと，例えばCentOSのbaseリポジトリとrpmforgeリポジトリにある**rrdtool**のうち，rpmforgeのほうが欲しい時とか．

- http://vault.centos.org/6.6/os/Source/SPackages/rrdtool-1.3.8-7.el6.src.rpm
- http://pkgs.repoforge.org/rrdtool/rrdtool-1.4.7-1.el6.rfx.x86_64.rpm

複数箇所にあるrrdtoolのうち，新しい方が欲しい，古い方は要らないという宣言を記述するには，例えば以下のようにすればいい．

```puppet
package { 'rrdtool':
  ensure          => installed,
  install_options => ['--enablerepo=rpmforge', '--disablerepo=*'],
  require         => Yumrepo['rpmforge'],
}
```

複数のリポジトリを使っている時に，名前が重複していてうまくインストール出来ない時に大変便利である．
というかyumでもともと使えるものがPuppetでも出来るようになっただけなんだけれど．
