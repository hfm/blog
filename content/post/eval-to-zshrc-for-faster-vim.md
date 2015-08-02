---
date: 2015-04-19T10:25:16+09:00
title: anyenvの設定を正しい位置に書いたらVimの起動が爆速になった
tags:
- zsh
- vim
---
[riywo/anyenv](https://github.com/riywo/anyenv)を導入した直後から、Vimの起動が急激に重くなって困っていた。
関連性が全く分からず、なんだこれ...と思って調べたところ、以下のような記事を見つけた。

> *[Vim を高速にしたたったひとつの作業 - pekeblog!](http://d.hatena.ne.jp/pekepekesamurai/20130114/1358093193)*
>
> なんじゃこれ・・・？とおもいつつも、デバッグコードをいれたところ、zshenv が異様に遅いことが判明。
>
> 遅いのは rbenv 関連というのは明らかだったので、とりあえずそこら辺をコメント化。

anyenvの設定を`~/.zshenv`にだけ書いていたのがダメだったようだ。
zshenvが思った以上にVimの中で呼ばれまくるらしく、`eval "$(anyenv init - zsh)"`が遅延の根本原因だった。

というわけで、evalしてるコードはzshrcに分けて書くようにしたところ、今までが信じられないくらいVimが高速化した。

```sh
# ~/.zshenv
[ -d ~/.anyenv/bin ] && export PATH=$HOME/.anyenv/bin:$PATH
```

```sh
# ~/.zshrc
[ -f ~/.anyenv/bin/anyenv ] && eval "$(anyenv init - zsh)"
```

`vim --startuptime`を見て比較する
---

ビックリするぐらい速くなったので、数字でもちゃんと比較しようとVimのstartuptimeを見てみた。

### zshenvに全部書いてた頃

特に時間のかかっているところを抜き出してみた。

syntaxやcolorscheme系の読み込みに凄まじく時間がかかっている。
ちなみに[mattn/benchvimrc-vim](https://github.com/mattn/benchvimrc-vim)でvimrcのベンチマークを見たところ、`syntax on`や`colorscheme=hybird`あたりで1000以上消費していた。

```
times in msec
 clock   self+sourced   self:  sourced script
 clock   elapsed:              other lines

000.009  000.009: --- VIM STARTING ---
...
258.910  237.296  237.238: sourcing /usr/local/share/vim/vim74/filetype.vim
1140.998  213.866  213.536: sourcing /usr/local/share/vim/vim74/syntax/synload.vim
1141.053  214.125  000.259: sourcing /usr/local/share/vim/vim74/syntax/syntax.vim
1803.959  662.820  662.175: sourcing /Users/hfm/.vim/bundle/vim-hybrid/colors/hybrid.vim
1805.096  1800.058  680.204: sourcing $HOME/.vimrc
...
2110.973  000.003: --- VIM STARTED ---
```

### evalをzshrcに分けたあと

上記と同じ箇所を抜き出してみた。
そもそも桁一つ違うし、数字の上でも6〜7倍ほど高速化しているのが分かる。

```
times in msec
 clock   self+sourced   self:  sourced script
 clock   elapsed:              other lines

000.008  000.008: --- VIM STARTING ---
...
069.833  044.917  044.860: sourcing /usr/local/share/vim/vim74/filetype.vim
170.830  025.812  025.583: sourcing /usr/local/share/vim/vim74/syntax/synload.vim
170.907  026.050  000.238: sourcing /usr/local/share/vim/vim74/syntax/syntax.vim
247.222  076.189  075.346: sourcing /Users/hfm/.vim/bundle/vim-hybrid/colors/hybrid.vim
248.882  243.995  091.811: sourcing $HOME/.vimrc
...
354.834  000.003: --- VIM STARTED ---
```

## 終わりに

確かrbenvのREADME.mdでzshenvに書くよう促してたよな...と思って調べたら、2〜3年前にzshrcに変更されていた。

> [Better rbenv init instructions for bash · Issue #305 · sstephenson/rbenv](https://github.com/sstephenson/rbenv/issues/305)
> https://github.com/sstephenson/rbenv/commit/c6855e01a9fe66b3ad0a53bb4fc0918798460d23

今までrbenvやplenvのevalもzshenvに書いていて、もっさり挙動は全部これらが原因だった。

ちゃんとドキュメント読め案件ですね...
とはいえ、Vimの起動速度にまさかシェルの設定ファイルが刺さっているとは思いもよらなかった。
