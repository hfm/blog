---
date: 2014-11-16T18:46:45+09:00
title: .irbrcの設定を見直した
tags:
- ruby
- diary
---
rubyのインタプリタはpryじゃなくてirbを使ってます．

ruby触り始めた頃は，pryを紹介されたのでそっちを使っていたんですが，irbも結構カスタマイズ出来るし別にpryをわざわざインストール必要も無いかな，と思って使わなくなりました．
binding.pryを使うようなケースも普段は無いし，あとPygmentsのレキサが何故かirbに対応しているので，codeblockとして貼り付けやすいのも嬉しい．

ただ，最近全然`.irbrc`の手入れを全然していなくて，いつの間にかいろいろ動かなくなっていた（ちゃんと管理してなかった）ので，これだけあれば充分かなあという設定で見直してみました．

```rb
# readline
require 'readline'
IRB.conf[:USE_READLINE] = true

# completion
require 'irb/completion'

# indent
IRB.conf[:AUTO_INDENT] = true

# histroy
require 'irb/ext/save-history'
IRB.conf[:HISTORY_FILE] = "~/.backup/irb_history"
IRB.conf[:SAVE_HISTORY] = 100000

# colorize
require 'wirb'
Wirb.start
```

とりあえずこれだけ入れとけば，色はつくしindentは勝手にやってくれるし（indentは時々邪魔だなと感じてしまう時もあるけど），Tab補完も効くので，私としてはこれで満足．

`wirb`入れとかないと色つかないのでご注意．

プロンプトは，下手に変えちゃうとPygmentsのレキサが反応しなくなる恐れがあるので素のままです．
