---
layout: post
title: ペパボ新卒３期生エンジニア研修，席替えスクリプトの思い出
tags:
- diary
- pepabo
---
今から1年と少し前，自分を含むペパボ新卒3期生エンジニアの研修[^1]で，席替えスクリプト[^2]なるものが生まれた．

## 席替えスクリプトの生まれた経緯

ペパボの新卒3期生エンジニアは4人いて，（長いので3ジニアって呼ばれることもあって数字に混乱しがちだった，）研修時にはこんな感じに座っていた．

```
                 @kentaro     @hsbt      @hiboma
                 あんちぽさん  しばたさん  ひろやんさん
              +-----------------------------------------------+
@gosukenator  |                                               |
  mizzyさん   |              技術基盤チームの島                 |
              |                                               |
              +-----------------------------------------------+
                 3ジニア     3ジニア     3ジニア     3ジニア
```

3ジニアが一列になっていて，分からないことがあると隣同士で相談していた．ある日，同じ席だと話す相手も固定化されるということで，毎日席替えをしようということになった．

その時に，（誰の発案か記憶が曖昧だけど，）「エンジニアなんだからスクリプト書けば？」という流れになって，よっしゃよっしゃと3ジニアで席替えスクリプトを書くことにした．

## 初めてのPerlスクリプトと[@kyanny](https://twitter.com/kyanny)さん

そこで僕が書いたのはこのPerlスクリプト．Perlを書くのは初めてで，何よりの低スキルだ，お作法もまるで分からないまま書いてしまっていた．

```perl
use strict;
use List::Util;
 
my @name_list = ( "おっくん", "きたけー", "たけお", "ぐっさん" );
my @s_name_list = List::Util::shuffle @name_list;
 
print join(", ", @s_name_list);
```

このスクリプトを公開した直後，当時ペパボスタッフだった[@kyanny](https://twitter.com/kyanny)さんから一枚のGist URLが送られてきた．
内容は，僕の書いたスクリプトの改良版．

{% gist kyanny/5632249 %}

URL先にある，「おれならこう書く」と書かれた，Perlの作法に関するコメント[^3]がメインだと思っている．

自分の書いたコードを直してもらったり，アドバイスをいただけたり，何よりものの数分でこれが送られてきたことに大きく衝撃を受けた．
これが僕にとってのOSS文化の原体験となっている．
他の人にとっては，初心者の書いたコードを修正しただけに見えるかもしれないが，それだけじゃない大きな経験を得られた．

今でも，このGistは時々見るようにしている．

## 終わりに

一人一人名前を上げるとキリがないのだけど，[contributors](https://github.com/pepabo/sekigae/graphs/contributors)を見ると，今もお世話になっている[@matsumotory](https://twitter.com/matsumotory)さんをはじめ，錚々たる方々からのPRをいただいており，OSSは斯くも暖かく楽しい場所なんだなあと思ったりする．

{% tweet https://twitter.com/hfm/status/498395965716307971 %}

{% tweet https://twitter.com/hfm/status/498397315783081984 %}

{% tweet https://twitter.com/hfm/status/498397388583616512 %}

[^1]: [ペパボ新卒エンジニア研修 前編 | blog: takahiro okumura](http://blog.hifumi.info/2013/12/31/rails-tutorial/)
[^2]: https://github.com/pepabo/sekigae
[^3]: https://gist.github.com/kyanny/5632249#comment-833822
