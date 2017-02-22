---
date: 2017-02-23T07:00:00+09:00
title: 2017年版nginx.vim（大した話ではありません）
tags:
- nginx
- vim
---
2年半ほど前に[nginx vim syntaxを導入した](/2014/10/21/nginx-vim/)のだが、nginxも日々進化しており、syntax highlightの効かない項目が増えてきた。使える機能に色がつかないと地味に気を取られるし、いつの間にか生産性を下げていたのかもしれない（そういう意味では、syntax highlightを使わない選択は合理的なのかも。）

いつものようにnginx-develメーリスを眺めていたら、Vim用のパッチが送られており、Vimの設定ファイルがメンテされていることに気づいた[^1] [^2]。そしてその設定ファイルこそが、元々使っていた[evanmiller/nginx-vim-syntax](https://github.com/evanmiller/nginx-vim-syntax)の移管先だった。nginx-vim-syntaxのREADMEをよく見ると、2013年12月に移管した旨が書かれている...ずっと気づいてなかった。公式が最強だった。

早速nginx-vim-syntaxを捨てて、以下のコマンドで設定ファイルを追加した。

```sh
# $HOME/.vim/{ftdetect,ftplugin,indent,syntax}/nginx.vim が展開される
curl -sSf http://hg.nginx.org/nginx/archive/tip.tar.gz/contrib/vim/ | tar xv --strip=3 -C $HOME/.vim
```

最近はあまり頑張ってVimを管理しないようにしていて、アップデートする場合は上記のコマンドをもう一度叩けばいいかと思ってる。

ちなみにnginx-vim-syntaxと公式リポジトリの差分は以下のようになった。主にSSL/TLS関連ディレクティブのシンタクスが強化されている印象だ。

- https://gist.github.com/hfm/bf9c0749ad37bbe6ded1b03e1a646363

2017年にもなってVimを使っているのはさておき、まだまだ疎いなあと感じた瞬間だった。

[^1]: http://mailman.nginx.org/pipermail/nginx-devel/2017-February/thread.html
[^2]: http://hg.nginx.org/nginx/file/tip/contrib/vim
