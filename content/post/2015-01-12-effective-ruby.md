---
layout: post
date: 2015-01-12T23:21:06+09:00
title: 「Effective Ruby」を読んだ
tags:
- book
- ruby
---
「Effective Ruby」を読んだ．

[![Effective Ruby](http://ecx.images-amazon.com/images/I/51zHkUmvyaL.jpg)](http://www.amazon.co.jp/exec/obidos/ASIN/4798139823/hifumiass-22/ref=nosim/)
[Effective Ruby](http://www.amazon.co.jp/exec/obidos/ASIN/4798139823/hifumiass-22/ref=nosim/)

## Rubyを書くときの必携書になった

学ぶことが多い本だった．

仕事で社内用のGemを作ってみたり，ちょっとしたbotをcinchで作ってみたり，Rubyを用いたツール開発を最近するようになった．
やっていて楽しいし，業務を楽に出来るのでガリガリ書いているのだけれど，ふとした時に「もっとより良い方法があるのでは？」と思うことが多い．

そうした時にこの本が役に立ちそうだ．

プログラムを設計するうえで，より良いメソッド，手法を提示してくれる指南書．
あるいはRubyという言語の特性上，陥りがちなバッドパターンやその回避法についてのFAQ．
そうしたEffectiveなプラクティスの詰まった良い本だと思う．

Rubyでコードを書くとき，手元においておきたい一冊になった．

## 感想

「1章 Rubyに身体を慣らす」「2章 クラス、オブジェクト、モジュール」「3章 コレクション」はとても勉強になった．
知らなかったメソッドや設計パターンの紹介，Rubyのコレクションは強力だと再認識させられる．

Array#compactは知らなかったメソッドで，これは便利だと思った．

```irb
irb(main):004:0> ['foo', :bar, nil, 1].compact                                                                                                                                                                                        Regenerating: 1 files at 2015-01-12 23:31:02 ...done.
=> ["foo", :bar, 1]
```

あと，文字列比較において，`=~`よりString#matchを使う方が有用なケースに納得性を感じた．
`=~`で拾った文字列を`$1`というPerl然とした記法で扱うよりは，以下のようにMatchDataオブジェクトで扱うほうが良いのではないか，というアドバイス．

```irb
# Perlっぽい $1 を使ったパターン
irb(main):014:0> if "A Sample String" =~ /(Sample)/
irb(main):015:1>   $1
irb(main):016:1> end
=> "Sample"

# matchメソッドを使ったパターン
irb(main):004:0> if m = "A Sample String".match(/Sample/)
irb(main):005:1>   m[0]
irb(main):006:1> end
=> "Sample"
```

ちなみに，拾った文字列を使わないのなら，別に前者でもいいのでは無いだろうかという気もする．

「5章 メタプログラミング」は，『メタプログラミングRuby』と合わせて読む方がいいかもしれない．
どちらも主張の強い本だが，良い比較になりそう．
『メタプログラミングRuby』の方がまるごとページを割いているので，しっかり取り組むならこっちの方が良さそうだけど．
（と言いつつ，「メタプログラミングRuby」にどんなこと書いてあったっけ？となっているので，また読み返そう...）

## おわりに

Rubyについては，『初めてのRuby』と（これはRubyの本ではないけど）[Ruby on Rails Tutorial](https://www.railstutorial.org/)から入り，その後メタプログラミングRubyや本書に出会った．
いまだと『初めてのRuby』に変わって『パーフェクトRuby』が良いかなと思う．

『パーフェクトRuby』『メタプログラミングRuby』，そして本書がRubyでコードを書くうえでの必携書になった．
もちろんドキュメントも読むけどね．
