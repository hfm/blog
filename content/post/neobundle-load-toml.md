---
date: 2015-03-29T09:58:18+09:00
title: NeoBundleのプラグイン管理をTOMLに任せてvimrcをスッキリさせる
tags:
- vim
---
NeoBundleがTOML[^1] parserを導入して，TOMLファイルにプラグイン管理を任せられるようになった．

- [Add TOML parser · Shougo/neobundle.vim@75e836f](https://github.com/Shougo/neobundle.vim/commit/75e836f566b94abfb6428f412173558953eb84a7)

![](/images/2015/03/29/neobundletoml.png)

## 設定ファイルのサンプル

vimrcの設定は，ドキュメントとShougo氏のvimrc[^2]を参考にすると，`neobundle#begin`〜`neobundle#end`の間を以下のように書けば良さそうだ．

```vim
call neobundle#begin(expand('~/.vim/bundle/'))

if neobundle#has_cache()
  " キャッシュから高速に起動
  NeoBundleLoadCache
else
  NeoBundleFetch 'Shougo/neobundle.vim'

  " TOMLファイルを指定
  call neobundle#load_toml('~/.vim/neobundle.toml')
  " NeoBundleLazyで指定した場合と同じ
  call neobundle#load_toml('~/.vim/neobundlelazy.toml', {'lazy' : 1} )

  " TOMLパーサが遅いため，一度読み込んだ設定をキャッシュに保存
  NeoBundleSaveCache
endif

call neobundle#end()
```

vimrcに書かれていた大量のプラグインリストは，`neobundle#load_toml`のおかげでたった数行に収められた．

ちなみに，遅延読み込みしたいプラグインとそうでないプラグインがある場合，1つのTOMLファイルだと管理が難しかったので，2つに分けている．
他により良い方法があったらご教授願いたい．

TOMLファイルは以下のように設定する．これもShougo氏によるサンプル[^3]があるので参考にされたい．

```ini
[[plugins]]
repository = 'ctrlpvim/ctrlp.vim'

[[plugins]]
repository = 'Shougo/neocomplete.vim'
insert = 1

[[plugins]]
repository = 'osyo-manga/vim-watchdogs'
depends = ['osyo-manga/shabadou.vim', 'cohama/vim-hier']
filetypes = 'all'
```

その他細かな設定に関しては，私のvimrcを参考にしてもらうと良いかもしれない．
割と更新頻度が高いのと，あまり綺麗に管理出来てないのはご容赦．

- https://github.com/tacahilo/.vim

## 終わりに

`NeoBundle 'user/repo'`や`NeoBundleLazy 'user/repo', { ... }`でvimrcはどんどん縦に長くなっていたが，TOMLファイルに書き出すことで，vimrcをスッキリ整理できた．

最近は更に，vimrcに書く設定は最小限に留めるようにして，プラグインの設定は`plugins.rc.vim`に書くように切り替えた．

```vim
if filereadable(expand('~/.vim/plugins.rc.vim'))
  source ~/.vim/plugins.rc.vim
endif
```

以前はvimrcがジャングルみたいでやる気が起きなかったが，スッキリさせたおかげで，遅延読み込みを活用して，Vimの起動をもっと高速化させてみようとか考えるようになってきた．

エディタいじりは飽きないなあ．

[^1]: [toml-lang/toml](https://github.com/toml-lang/toml)
[^2]: https://github.com/Shougo/shougo-s-github/tree/master/vim
[^3]: neobundle の toml 記法サンプル https://gist.github.com/Shougo/3d2adcb83e9eb0e8d4af
