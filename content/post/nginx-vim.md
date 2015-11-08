---
date: 2014-10-21T01:52:30+09:00
title: nginx vim syntaxを導入した
tags: 
- nginx
- vim
- diary
---
nginxのConfigurationファイルをずっと触っていて、syntax highlightが欲しくなり、ついでにnginx関連ファイルを開いた時はいい感じに検知するプラグインは無いかと思って調べた。

検索して最初に出会ったのが[vim-scripts/nginx.vim](https://github.com/vim-scripts/nginx.vim)なのだが、4年前から更新が無い。

おそらく、これでもある程度の要求を満たせるのだろうけど、もうちょっといいのは無いかと調べてたら、 __[evanmiller/nginx-vim-syntax](https://github.com/evanmiller/nginx-vim-syntax)__ が見つかった。

- https://github.com/evanmiller/nginx-vim-syntax

どちらのリポジトリも http://www.vim.org/scripts/script.php?script_id=1886 を参照していて、どうやらversion 0.3.3からはevanmiller/nginx-vim-syntaxが主になったらしい。
新しい方にはftdetect/nginx.vimが用意されていて、（完全ではないが）nginxの設定ファイルを検知するようになっている。

ちなみに、nginx-vim-syntaxはnginxソースのcontribディレクトリに本家があるらしい[^1]が、githubとnginx.orgにあるvim filesに差分は無さそうだ。
一応以下のようなコマンドで差分がないことは確認した

```sh
diff -u \
    <(curl -sL https://raw.githubusercontent.com/evanmiller/nginx-vim-syntax/master/syntax/nginx.vim) \
    <(curl -sL http://hg.nginx.org/nginx/raw-file/973fded4f461/contrib/vim/syntax/nginx.vim)
```

これでnginxのConfigurationファイルを開いた時に色がついて分かりやすくなる。

[^1]: http://hg.nginx.org/nginx/file/f38043bd15f5/contrib/vim
