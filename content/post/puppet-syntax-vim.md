---
title: puppet-syntax-vimでattributesを自動整列する
date: 2014-05-05
tags:
- vim
- puppet
---
Puppet用vimプラグイン[puppet-syntax-vim](https://github.com/puppetlabs/puppet-syntax-vim)の紹介。

## Arrow `=>` Alignment

PuppetlabsのStyle Guideにこんな文言がある。

> #### [Style Guide — Documentation — Puppet Labs](http://docs.puppetlabs.com/guides/style_guide.html#arrow-alignment)
> ##### 9.2. Arrow Alignment
> All of the fat comma arrows (`=>`) in a resource’s attribute/value list should be aligned. The arrows should be placed one space ahead of the longest attribute name.

つまり、以下のようなコードが見た目的にBadだと言うことだ。

```puppet
file { '/etc/foo.d':
  source => 'puppet:///foo.d',
  owner => 'root',
  recurse => true,
}
```

ではGoodは何か。それは次のようにattributesとvalueを、`=>`の記号を軸に整列させることだ。

```puppet
file { '/etc/foo.d':
  source  => 'puppet:///foo.d',
  owner   => 'root',
  recurse => true,
}
```

あくまで見た目の問題でしか無いのだが、人にコードを見せる上ではこうした部分にも気を使いたい。

とはいえ、いちいちSpaceキーを打って調整して、また削除して調整しての繰り返しは苦しい。
また、vimプラグインの[Align](https://github.com/vim-scripts/Align)を使ってもいいが、毎回整列のためにコマンドを打つのも虚しい（もちろん使うには使う）。

第一そんなことをしていたら、どこかしらに確認漏れが発生する。
[puppet-lint](https://github.com/rodjek/puppet-lint)を入れても損は無いが、そもそもの話、たかだか見た目の問題を外部から指摘されて直している時点で、状況が改善していない。

書いているだけで、自然とスタイルガイドを踏襲したコードになっているのが良いと思う。
スタイルガイドを身体に覚えさせなくてもいい、別な方法で。

## puppetlabs/puppet-syntax-vim

実は、先の要望を叶えてくれるvimプラグインをPuppetlabsが用意してくれている。

それが[puppet-syntax-vim](https://github.com/puppetlabs/puppet-syntax-vim)である。もちろん、[puppet-syntax-emacs](https://github.com/puppetlabs/puppet-syntax-emacs)もある。

私は[neobundle.vim](https://github.com/Shougo/neobundle.vim)を使っているので、以下の2行でインストールしている。
導入自体、これだけで良い。

```vim
NeoBundleLazy 'puppetlabs/puppet-syntax-vim', {
  \ 'autoload': {'filetypes': ['puppet']}}
```

さて、このプラグインが実際どんな動きをするのか、スクリーンキャプチャを撮ってみた。
[OS X Screencast to animated GIF](https://gist.github.com/dergachev/4627207)に倣って15秒ほどのGIFアニメにしてみた。
これで動作を確認してもらいたい。

![](/images/2014/05/05/puppet-syntax-vim.gif)

attributeを書いて、arrow `=>`を書いて、空白スペースを押す。

これまでと変わらない操作で、自動的にリソースのattributesが整列されていることが分かる。
気を使うことなく、自然とスタイルガイドに倣ったコードになってくれている。

このような自動整列の他にも、puppet-syntax-vimにはシンタクスハイライトやインデントルールの設定ファイルも含まれているので、vimmerなPuppet使いならおすすめする。

## 更にミスを減らす

エラー構文を減らすためには以下のような設定をすればいいと思う。

 * [PuppetのSyntaxをvim(syntastic)とgit hooks(pre-commit)の2重でチェックするようにした - Glide Note - グライドノート](http://blog.glidenote.com/blog/2013/03/16/puppet-syntax-check/)

悲しいtypoや動かないコードをpushすることが避けられるので、こちらも併せておすすめする。

## referrence

 * [puppetlabs/puppet-syntax-vim](https://github.com/puppetlabs/puppet-syntax-vim)
 * [puppetlabs/puppet-syntax-emacs](https://github.com/puppetlabs/puppet-syntax-emacs)
 * [Style Guide — Documentation — Puppet Labs](http://docs.puppetlabs.com/guides/style_guide.html#arrow-alignment)
 * [PuppetのSyntaxをvim(syntastic)とgit hooks(pre-commit)の2重でチェックするようにした - Glide Note - グライドノート](http://blog.glidenote.com/blog/2013/03/16/puppet-syntax-check/)
