---
title: tigのバージョンが上がって過去の.tigrcがobsolatedになっていた
date: 2014-05-29
tags: 
- git
---
いつの間にかtigのバージョンが2.xに上がっていて、過去の`.tigrc`がobsolatedになっていた。

 - [The Tig Manual](http://jonas.nitro.dk/tig/manual.html)
 - [tigrc(5)](http://jonas.nitro.dk/tig/tigrc.5.html)

新しい`.tigrc`は結局以下のようになった。

行番号や日付、コミッタ等の順番や間隔を自分で調整しやすくなったので、今まで気に入ってなかった部分に手を加えられた。

```ini
set blame-view = date:local author:full id line-number:true,interval=1 text
set main-view = line-number:true,interval=10 date:local author:full id commit-title:true,graph=true,refs=true
set refs-view = date:local author:full id ref:true commit-title:true
set status-view = file-name status:long
set tree-view = date:local author:full id file-size:unit mode file-name

set line-graphics = ascii
set horizontal-scroll = 20%

# Esc-c で、コミットハッシュ値をコピーできるようにする
bind generic <Esc>c !@bash -c "cut -c-7 <<<%(commit) | xargs echo -n | pbcopy"
```

印象としては、1.xの頃よりカスタマイズ性が上がった分、設定がめんどくさくなってしまった。
まあ、何もいじらなくてもそこそこいい感じにしてくれるので、そもそもそんなに設定凝らなくてもいい気がする。
