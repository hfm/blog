---
layout: post
title: Vagrantfileを複数枚に分割する、あるいはVagrantfileが別ファイルをincludeする方法
tags:
- vagrant
---
### TL;DR

- Vagrantfileの中身はrubyなので、`load`すれば別ファイルに書かれた設定を持ってこれる

## 長大化するVagrantfile

サービスが複雑性を増すと、Vagrantfileも比例して大きくなる。コードが縦に長くなるに連れて可読性も低下する。

そのような問題に対して、そもそもVagrantfileは分割出来ないのか？と思い至り、調べたところ、[erran-r7/multiple_vagrantfiles](https://github.com/erran-r7/multiple_vagrantfiles)を見つけた。

そこによれば、次のようなやり方で簡単にVagrantfileを分割出来ることがわかった。

こちらが`Vagrantfile`とする（エラー処理を省いているのはご容赦いただきたい）。

```rb
# -*- mode: ruby -*-
# vi: set ft=ruby :

load 'second_vagrantfile'
```

こちらは`second_vagrantfile`とする。

```rb
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hfm4/centos-with-docker"
end
```

これだけで良い。
そもそもVagrantfileはrubyコードなのだから、loadも出来るということだった。

しかし、このやり方にはある問題がある。

### 課題

#### zsh-completionsでVMリストが得られない

zsh利用者にとって痛手となるのは、このやり方だとVMリストの補完が一部効かなくなるということだ。

これは[zsh-completionsのsrc/\_vagrant#L78-81](https://github.com/zsh-users/zsh-completions/blob/master/src/_vagrant#L78-81)を見れば分かる。

```sh
# 今日時点 (2014/06/23)のコード
grep Vagrantfile -oe '^[^#]*\.vm\.define * ['\\''":]\?\([a-zA-Z0-9\-_]\\+\)['\\''"]\?' 2>/dev/null |  awk '{print $NF}' | sed 's/'\\''//g'|sed 's/\"//g'|sed 's/^://'
```

分かると書いたが、これではあまりにも読みにくいので分解してみる（だがまだ...）。

```sh
grep Vagrantfile -oe '^[^#]*\.vm\.define * ['\\''":]\?\([a-zA-Z0-9\-_]\\+\)['\\''"]\?' 2>/dev/null | \
    awk '{print $NF}' | \
    sed 's/'\\''//g' | \ 
    sed 's/\"//g' | \
    sed 's/^://'
```

何故コンソール入力でも無いのにgrepしてawkするのか[\*1](#uuog)、何故sedを三連発もするのか[\*2](#sed)、何故パイプの前後に半角スペースがあったりなかったりするのか、等といった疑問はさておき、Vagrantfileから`*.vm.define`のある行をgrepして補完リストを作成しているので、Vagrantfile以外の名前は当然補完対象ではなくなる。

他にも、分割による管理の複雑化といった大きな課題もあるが、それはまた別の機会に考察したい。

斯様な欠点は抱えつつも、Vagrantfileの分割はやろうと思えば出来るということを備忘録程度に残しておく。

#### 脚注

- <a name='uuog'></a>\*1 ... http://www.smallo.ruhr.de/award.html#grep
- <a name='sed'></a>\*2 ... しかし、まとめて`sed -E "s/('|\"|^:)//g"`でいいのかと言われると唸ってしまう。だがせめてクォートの排除くらいはまとめた方がよいと思う
