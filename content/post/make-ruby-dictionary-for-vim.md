---
layout: post
title: vim用にrubyの辞書が欲しかったので用意した
date: 2014-04-27
tags:
- ruby
- vim
---
「[vimで使うRuby用の辞書を作った](http://masterka.seesaa.net/article/385955044.html)」を参考に、コードをちょっと修正してRuby 2.1.1用のvim辞書を用意した。

## ソースコード

```rb
#!/usr/bin/env ruby
 
require 'uri'
 
if ARGV.size != 1
  fail ArgumentError, "Set directory path like $HOME/.rbenv/versions/2.1.1/"
end
 
methods = []
Dir.glob(File.expand_path(ARGV[0]) + "/**/*.ri").each do |file|
  method = URI.decode(File.basename(file))
 
  if /\A(.*)-\w*\.ri\Z/ =~ method
    methods << $1
  end
end
 
methods.uniq.sort.each do |method|
  puts method unless method.size == 1
end
```

## 設定

このコードに`makedict.rb`みたいな名前をつけて、用語一覧を`.vim/dict/ruby.dict`に保存。

```sh
./makedict.rb ~/.rbenv/versions/2.1.1 > ~/.vim/dict/ruby.dict
```


vim補完にneocompleteを使っているので、`.vim/vimrc`で以下のように設定した（vim 7.4以降は`.vimrc`じゃなくて`$HOME/.vim/vimrc`がデフォルトっぽいです）

```vim
" Dictionary
let $VIMHOME = $HOME . '/.vim'
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'ruby' : $VIMHOME.'/dict/ruby.dict'
\ }
```

rubyを書く時にしょっちゅうメソッド名が分からなくなってしまい、その度に調べるのが面倒だったが、これで少しは手間も省けて、typoも減らせるかな。

## 参考

 * [vimで使うRuby用の辞書を作った: BLOGΣ（゜Д゜）カッ!](http://masterka.seesaa.net/article/385955044.html)
 * [Shougo/neocomplete.vim](https://github.com/Shougo/neocomplete.vim#configuration-examples)
