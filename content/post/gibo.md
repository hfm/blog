---
date: 2014-11-12T03:14:29+09:00
title: giboを使って楽に.gitignoreを用意する
tags: 
- git
---
[gibo](https://github.com/simonwhitaker/gibo)はGitignore Boilerplatesの略称で、[github/gitignore](https://github.com/github/gitignore)にある言語やフレームワーク等の.gitignoreを出力するツールです。
とても便利なツールなのですが、自分の周りであまり使われている印象が無いので、ブログ書いてみます。

## インストール

OSXなら、homebrewからインストール可能です。

```
brew install gibo
```

## デモ

まずは簡単なgiboの使い方から。
例えば`gibo rails`のように打つだけで、Ruby on Railsの.gitignoreが出力されます。
通常はteeコマンドやリダイレクトして.gitignoreに流し込んだりして使います。

![](/images/2014/11/12/demo.gif)

また、どのようなテンプレが用意されているかは、`gibo -l`で確認できますし、`peco`のようなフィルタリングツールと組み合わせると、強力です。
`gibo -l | peco | xargs peco`のように使うことも可能です。

![](/images/2014/11/12/demo2.gif)

※デモ用のアニメGifは[sugyan](https://twitter.com/sugyan)さんの[ttygif](https://github.com/sugyan/ttygif)を使いました

### 補足：複数のテンプレを同時出力する

ちなみにgiboは複数のテンプレを同時に出力することが可能で、例えば私は、OSXでPackerを使ってVagrantboxをビルドする環境を作る場合は、`gibo osx vagrant packer > .gitignore`のように利用できます。

```
$ gibo osx vagrant packer
### https://raw.github.com/github/gitignore/170b9f808b34c9df63cbefb50c6b3517270755ec/Global/osx.gitignore

.DS_Store
.AppleDouble
.LSOverride

# Icon must ends with two \r.
Icon

# Thumbnails
._*

# Files that might appear on external disk
.Spotlight-V100
.Trashes


### https://raw.github.com/github/gitignore/170b9f808b34c9df63cbefb50c6b3517270755ec/Global/vagrant.gitignore

.vagrant/


### https://raw.github.com/github/gitignore/170b9f808b34c9df63cbefb50c6b3517270755ec/packer.gitignore

# Cache objects
packer_cache/

# For built boxes
*.box
```

## 終わりに

シンプルで便利なgiboというツールの紹介をしました。
また、github/gitignoreに欲しい.gitignoreが見つからない場合は、PRを送ってみるといいと思います。
（packerのテンプレは私がPRしたものだったりします[^1]）

[^1]: https://github.com/github/gitignore/commit/2fcafd7140770b8dc623e10d26480eea54994eff
