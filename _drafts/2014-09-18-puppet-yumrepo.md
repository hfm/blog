---
layout: post
title: Puppetのyumrepoリソース
tags:
- puppet
---
Puppetのyumrepoリソースで「これだけは必要だ」と思った属性についてまとめた．

## モチベーション

`/etc/yum.repos.d/`の中身をPuppet manifestsで管理したい．
けど，yumrepoは属性が多すぎて，一体どれを設定すればいいのかいっつも分からなくなり，「puppet yumrepo」で調べている．

`yum.conf(5)`の各項目との対応付けが公式ドキュメントに記載されているので，それと一緒に見ると分かりやすい．



```puppet
yumrepo { 'epel':
  name 
}
```

## 諦めなければいけない仕様

### 複数のrepositoryidを1つのファイルにまとめられない

例えば`puppetlabs-release-el-6.noarch.rpm`わインストールしたりすると，`/etc/yum.repos.d/puppetlabs.repo`が作成される．
内容は以下のようになっている．

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



yumrepoリソースを使っていると，「あれ？epelとかpuppetlabs-*とか，複数repositoryidを持ってる奴を1ファイルにまとめるのはどうやるんだ？」って疑問が出てくる．


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
