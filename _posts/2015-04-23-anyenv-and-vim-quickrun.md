---
layout: post
date: 2015-04-23 13:14:36 +0900
title: anyenv (rbenv) で入れたrubyをvim-quickrunで実行させる
tags:
- zsh
- vim
---
前回、[anyenvの設定を正しい位置に書いたらVimの起動が爆速になった](/2015/04/19/2015-04-19-eval-to-zshrc-for-faster-vim/)んだけど、実はこれでは十分ではなかった。

というのも、Vimで[quickrun](https://github.com/thinca/vim-quickrun)を実行しても、(anyenvで入れた) rbenvから入れたrubyが実行されない。

ぐぐってみても`eval $(rbenv init -)`をzshenvに入れるというアドバイスしか見つからず、それをすると元の低速環境に戻ってしまう...と悩んでいたが、割と簡単な解決方法を見つけた。

`.zshenv`に以下のように、各envツールのshimsのPATHを入れるだけ。

```sh
[ -f ~/.anyenv/bin/anyenv ] && export PATH=$HOME/.anyenv/bin:$PATH
[ -d ~/.anyenv/envs/rbenv ] && export PATH=$HOME/.anyenv/envs/rbenv/shims:$PATH
[ -d ~/.anyenv/envs/plenv ] && export PATH=$HOME/.anyenv/envs/plenv/shims:$PATH
[ -d ~/.anyenv/envs/pyenv ] && export PATH=$HOME/.anyenv/envs/pyenv/shims:$PATH
```

vimで`:!echo $PATH`を実行してみると、shimsへのPATHが入って無いことに気づいて、上記を試してみたところ上手くいった。

あと、[@ryot_a_rai](https://twitter.com/ryot_a_rai)君から `rbenv init - --no-rehash` という方法も教えてもらった。
これはrbenv initの挙動からrbenv rehashを行わないようにするもので、まあ普段使っている限りにおいては毎回rehashなんてしなくても良いので、これも使うことにした。

ちなみにrbenv initやらの挙動を追いかけるのに先輩の書いたブログが大変参考になった。

> [rbenv + ruby-build はどうやって動いているのか - takatoshiono's blog](http://takatoshiono.hatenablog.com/entry/2015/01/09/012040)
