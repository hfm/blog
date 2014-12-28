---
layout: post
date: 2014-12-28 23:35:16 +0900
title: Puppetで外部リポジトリを管理するときにyumrepo/packageリソースを選ぶ基準
tags:
- puppet
---
Puppetには外部リポジトリを管理するためのyumrepoリソース[^1]がある．
しかし，packageリソース[^2]を使っても同様に管理が実現出来る．
では，どちらを選ぶべきか，その選択基準について一考した．

## TL;DR

- rpmに外部リポジトリとの依存関係があるならpackageリソースが良い
- rpmに外部リポジトリとの依存関係がないならyumrepoリソースでも良い

## 背景

前回，Puppetのyumrepoリソースについて記事を書いた．

- [Puppetのyumrepoリソースでよく指定する属性 | blog: takahiro okumura](/2014/12/27/puppet-yumrepo/)

そこで，yumrepoを使った管理方法以外にも，packageリソースを使った管理方法も添え書きした．

> ちなみにepelやrpmforgeであれば，packageリソースでインストールすれば良いと思う．
> 
> ```puppet
> package { 'epel-release':
>   ensure   => installed,
>   source   => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
>   provider => rpm,
> }
> ```

これを読んだときに，「yumrepoでもpackageでも同じことが達成できるなら，どちらを選べばいいのだろう？」と疑問を浮かべるかもしれないので補足のために記事を書く．

## yumrepoを使うべきかpackageを使うべきか

私としては，TL;DRにも書いたとおりの基準で使い分けることをオススメする．
1行で書くなら以下のようになる．

- あるREPO-release.rpmが外部リポジトリと依存関係を持つならpackageリソース，特に無ければyumrepoリソースを使う

外部リポジトリとの依存関係とは何か，例を上げて説明していこう．

### 依存関係のあるrpmならpackageリソースを使う

例えば，remi-releaseのrpmは依存関係を持っている．
`rpm -qR`コマンドで確認すると，remp-releaseはepel-releaseが無いといけないことが分かる．

別の角度から見ると，epel-releaseは他の外部リポジトリに依存されているということになる．

```
# rpm -qRp remi-release-6.rpm
config(remi-release) = 6.5-1.el6.remi
epel-release >= 6
redhat-release >= 6
rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
yum
rpmlib(PayloadIsXz) <= 5.2-1
```

もし，依存されている側のepel-releaseをyumrepoリソースを使って管理すると，少々厄介なことになる．

どういうことか．

以下の様なバッドケースを例に見てみる．
例なので少々奇妙だが，yumrepoリソースでepelを管理し，remiはpackageからインストールしようとしているコードだ．

```puppet
yumrepo { 'epel':
  descr          => 'Extra Packages for Enterprise Linux 6 - $basearch',
  enabled        => 1,
  mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
  failovermethod => 'priority',
  gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
  gpgcheck       => 1,
}

package { 'remi-release':
  ensure   => installed,
  source   => 'http://remi.kazukioishi.net/enterprise/remi-release-6.rpm',
  provider => rpm,
}
```

このPuppet manifestsはエラーになる可能性が高い．
なぜなら，yumrepoリソースでインストールされたepelは，RPMデータベースに登録されないため，rpmから見れば「epel-releaseなんてものはインストールされていない」ように見えてしまうからだ．

以下はPuppet経由では無いが，epel-releaseが無い状態でremi-releaseをインストールしようとした時に出るエラーだ．

```
# rpm -ivh http://remi.kazukioishi.net/enterprise/remi-release-6.rpm
Retrieving http://remi.kazukioishi.net/enterprise/remi-release-6.rpm
error: Failed dependencies:
	epel-release >= 6 is needed by remi-release-6.5-1.el6.remi.noarch
```

Puppet manifestsでもこれと同様の問題が生じる．
そのため，epelやremiのような「外部リポジトリとの依存関係を持つもの」はpackageリソースを使ってインストールした方がいいと思っている．

#### epelやremiはpackageリソースを使おう

```puppet
package { 'epel-release':
  ensure   => installed,
  source   => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
  provider => rpm,
}

package { 'remi-release':
  ensure   => installed,
  source   => 'http://remi.kazukioishi.net/enterprise/remi-release-6.rpm',
  provider => rpm,
  require  => Package['epel-release'],
}
```

### 依存関係が無いrpmならyumrepoリソースを使う

例えば，puppetlabs-releaseには外部リポジトリとの依存が無い．

```
# rpm -qRp puppetlabs-release-el-6.noarch.rpm
config(puppetlabs-release) = 6-11
redhat-release >= 6
rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
rpmlib(VersionedDependencies) <= 3.0.3-1
rpmlib(PayloadIsXz) <= 5.2-1
```

このようなリポジトリであれば，yumrepoリソースで管理しても問題無いだろう．

```puppet
yumrepo {
  'puppetlabs-products':
    descr    => 'Puppet Labs Products El 6 - $basearch',
    baseurl  => 'http://yum.puppetlabs.com/el/6/products/$basearch',
    enabled  => 1,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    gpgcheck => 1;

  'puppetlabs-deps':
    descr    => 'Puppet Labs Dependencies El 6 - $basearch',
    baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
    enabled  => 1,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    gpgcheck => 1;
}
```

### Puppet manifestsとServerspec

yumrepoリソースで管理すると，Serverspecとの対比的な構造を可視化できることが優位であると考えている．

どういうことか．

コードレベルで見た場合，**「PuppetのyumrepoリソースとServerspecのyumrepoリソース」という関係性で記述できる**という優れた面が浮かび上がる．

```rb
describe yumrepo('puppetlabs-products') do
  it { should exist }
  it { should be_enabled }
end

describe yumrepo('puppetlabs-deps') do
  it { should exist }
  it { should be_enabled }
end
```

もちろん，packageリソース経由でも上記のテストは通るだろう．
結果に差は無い．
しかし，「1つの宣言に対しての1つのテスト」を書くほうが，ホワイトボックステストらしくて良い．

## まとめ

Puppetで外部リポジトリを管理するときにyumrepoリソースを使うべきか，packagegリソースを使うべきか，その基準について以下のように考えた．

- rpmに外部リポジトリとの依存関係があるならpackageリソースが良い
- rpmに外部リポジトリとの依存関係がないならyumrepoリソースでも良い

yumrepoリソースを使うことで，Serverspecとの関係性を綺麗に保つことが出来る．
baseurl等の属性を1つ1つ記述することも良い．
rpmはアップデートするかわからないため，packageリソースによるrpmインストールは冪等性をやや損なう．

しかし一方で，remi-releaseのように別の外部リポジトリへ依存しているような存在には要注意だ．
epel-releaseは他の外部リポジトリに依存されているので，こればかりはpackageリソースをオススメしたい．

ちなみにこの問題は，rpmの仕組みとのconflictとも言える．
せっかくの専用リソースなわけだし，基本的にはyumrepoリソースを使うのがいいのではないだろうか．

とはいえpackageはそれはそれで悪くないので，どちらが正解というわけではない．
なので「yumrepoリソース**でも**良い」と書いた．

[^1]: https://docs.puppetlabs.com/references/latest/type.html#yumrepo
[^2]: https://docs.puppetlabs.com/references/latest/type.html#package
