---
layout: post
date: 2015-03-22 05:46:59 +0900
title: vim-gistaとvim-auto-saveでGistファイルの変更を自動反映する
tags:
- vim
---
なにかしらの説明資料を作る時に，まずはGistでつらつらと文書を書くようにしてる．
文書以外にも，どこかで使おうと思って書いた雑なスクリプトがすぐに紛失するという個人的な問題を解決してくれる．

Gistを編集・更新するのに[lambdalisue/vim-gista](https://github.com/lambdalisue/vim-gista)を使っている．
unite.vimと連携させて検索出来るのが特に重宝している．
更なるvim-gistaの魅力は，作者本人のブログを参考にするのが良いと思う．

> [vim-gistaで訪れる世界で最も快適なGist環境 in Vim - Λlisue's blog](http://lambdalisue.hatenablog.com/entry/2014/07/01/203015)

ところで，vim-gistaは大変便利なんだけど，デフォルトでは`:Gista`か`:Gista --post`を実行しないとGist上にアップデートを反映出来ない．
(Dropboxでもいいかもと思ったんだけど，Gistの方が他者の共有しやすいと感じた)

そこで，vim-auto-saveをvim-gistaと組み合わせて，Gistファイルの変更を自動的に反映出来るように設定した．

## vimrc

vimrcで以下のように設定した．
(NeoBundleとunite.vimを使っているので専用の設定が入っている．)

```vim
NeoBundle '907th/vim-auto-save'
NeoBundleLazy 'lambdalisue/vim-gista', { 'autoload': {
      \  'commands': ['Gista'],
      \  'mappings': '<Plug>(gista-',
      \  'unite_sources': 'gista',
      \}}

"" vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

"" vim-gista
let g:gista#github_user = '<YOUR GITHUB ACCOUNT>'
let g:gista#update_on_write = 1
let g:gista#auto_yank_after_save = 0
let g:gista#auto_yank_after_post = 0
```

## vim-auto-save側の設定

### `g:auto_save = 1`

自動保存を有効にするために必要なのオプションはこの1つだけ．

残りの設定は個人の好みによるので必須では無い．

#### 一応他の設定についてサクッと説明

- `g:auto_save_in_insert_mode = 0`としているのは，insertモード中に保存されると流石に鬱陶しく感じたため
- `g:auto_save_silent = 1`は，ステータスラインが保存情報で埋没するのを阻止するために設定した

## vim-gista側の設定

### `g:gista#github_user = '<YOUR GITHUB ACCOUNT>'`

`g:gista#github_user`には自分のアカウントを入れる．
`:Gista --login`を押すと，パスワードあるいはPersonal Account Tokenを要求されるので，入力しておく．
トークンは`~/.gista/tokens/tokens.json`に保存される．

### `g:gista#update_on_write = 1`

`g:gista#update_on_write = 1`は，保存と同時にGistへのアップデートを行うためのオプション．
`:w`をトリガーになっている．
(2を指定すると`:w!`がトリガーに変わる．)

### その他のオプション

- 以下の2つを入れて，自動更新する度にバッファにGist IDやURLを保存することを防いでいる
  - `g:gista#auto_yank_after_save = 0`
  - `g:gista#auto_yank_after_post = 0`

## 気になる点

Gistのrevisionが気づかないうちに大量更新されてしまうこと．
文書を操作する度に履歴が残ってしまうので，思考の過程がダダ漏れになりかねない．
だけど，まあそこまでrevisionを遡る人もいないだろう（差分を追い切れない気もする）．

あとは，自動保存の度にGistとの通信が発生するので，操作に引っかかる瞬間がある．
例えばinsertモードで都度保存していると，ひっかかってウッとくるかもしれない．
今のところは大丈夫だが，ひっかかりが顕著になったら止めようと思う．

## 終わりに

vim-auto-saveとvim-gistaで，Gistファイルの自動更新環境らしきものは作れた．

通信のひっかかりについて，[Shougo/vimproc.vim](https://github.com/Shougo/vimproc.vim)と組み合わせれば非同期通信も実現出来る気がするけど，Vim script力が低すぎるのでどうすればいいか全然わからなかった．

とりあえず[Vim scriptテクニックバイブル](http://www.amazon.co.jp/exec/obidos/ASIN/B00OHH5688/hifumiass-22/ref=nosim/)でも買ってみようと思う．
