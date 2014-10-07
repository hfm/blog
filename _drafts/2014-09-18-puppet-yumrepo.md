---
layout: post
title: Puppetのyumrepoリソース
tags:
- puppet
---
Puppetのyumrepoリソースは属性が多くて覚えにくいので，「この属性は必要だ」と思った項目についてまとめた．

## モチベーション

`/etc/yum.repos.d/`の中身をPuppet manifestsで管理したい．
けど，yumrepoは属性が多すぎて，一体どれを設定すればいいのかいっつも分からなくなり，「puppet yumrepo」で調べている．

`yum.conf(5)`の各項目との対応付けが公式ドキュメントに記載されているので，それと一緒に見ると分かりやすい．



```puppet
yumrepo { 'epel':
  name 
}
```



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

## 備考

### yumrepoリソースは複数のrepositoryidを1つのファイルにまとめられない

yumrepoリソースは，1つの宣言に対して1つのファイルを生成する．
これは，rpmで直接インストールする時と勝手が違うので違和感があるかもしれない．

yumrepoリソースを使っていると，「あれ？epelとかpuppetlabs-*とか，複数repositoryidを持ってる奴を1ファイルにまとめるのはどうやるんだ？」って疑問が出てくる．

例えば`puppetlabs-release-el-6.noarch.rpm`わインストールしたりすると，以下のような`/etc/yum.repos.d/puppetlabs.repo`が作成される．

```ini
[puppetlabs-products]
name=Puppet Labs Products El 6 - $basearch
baseurl=http://yum.puppetlabs.com/el/6/products/$basearch
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
enabled=1
gpgcheck=1
 
[puppetlabs-deps]
name=Puppet Labs Dependencies El 6 - $basearch
baseurl=http://yum.puppetlabs.com/el/6/dependencies/$basearch
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
enabled=1
gpgcheck=1
...
```

しかし，この状態をPuppet yumrepoリソースで再現することは出来ない（2014/09/23時点）．
`yumrepo`は1つの宣言に対して1つのファイルを生成するようになっており，
