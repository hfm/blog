---
layout: post
date: 2015-03-28T02:29:00+09:00
title: Gitリポジトリのカレントブランチ名を取得する
tags:
- git
---
Gitのcurrent branchを取得したくて`git branch | awk '$1=="*" {print $2}'`を思いついたんだけど，もうちょっと便利なヤツあるだろうと思って調べたらあった．
...というのを3回繰り返したのでブログに書くことにした．

Stack Overflowに自分とまったく同じ状況の人がいて，そこにある回答がズバリ欲しいものだった．

> [How to get current branch name in Git? - Stack Overflow](http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git)

```sh
git rev-parse --abbrev-ref HEAD
```

パイプしなくてもgitのコマンドだけで表示できて便利．

ちなみに，Git 1.8以降なら以下でも可能らしい．
(CentOS6あたりまでGit 1.7なので使えなかったりする)

```sh
git symbolic-ref --short HEAD
```

## 余談

ところで，Gitにおける*symbolic ref*という概念は，`refs/head/master`みたいなコミットオブジェクトの参照を指すらしい．
知らなかった．

> A symbolic ref is a regular file that stores a string that begins with ref: refs/. For example, your .git/HEAD is a regular file whose contents is ref: refs/heads/master.
>
> *http://git-scm.com/docs/git-symbolic-ref*

上記の引用のとおり，HEADファイルには作業ブランチへのsymbolic ref (`refs/heads/master`) が示されている．

```console
$ cat .git/HEAD
ref: refs/heads/master
```

Gitのことをちょっと調べようと思ったら，知らなかった概念が次から次へと現れるので一苦労する．
