---
layout: post
title: .tigrcでtigの表示を変更する
date: 2014-01-18
tags: 
- git
---
gitのYet Anotherなブラウジングツールとして、[tig](https://github.com/jonas/tig)をよく利用します。

## .tigrc

Gitリポジトリのあるディレクトリで`tig`と打つと、コミットログ一覧が表示されますが、`.tigrc`を使うとデフォルト表示を変えられるのを知りました。

 * [tigrc(5)](http://jonas.nitro.dk/tig/tigrc.5.html)

わざわざ`.tigrc`を作らなくても割とリッチな画面ですが、せっかくなので以下のような設定にしてみました。

```ini
set show-author = full
set show-refs = true
set show-rev-graph = true
set show-date = local
set show-line-numbers = yes
set line-number-interval = 10
set line-graphics = ascii
set show-file-size = units
set horizontal-scroll = 20%
```

このように設定すると、tig画面が以下のようになります。

![](/images/2014/01/18/tig@2x.png)

### 行番号

`show-line-numbers`と`line-number-interval`で10行ごとに行番号を打っています。地味に便利でした。

### リビジョングラフ

`line-graphics = utf-8`でクロマル●に変わりますが、これと`default`はフォントが微妙に崩れたので`ascii`にしました。

`\*`はコミット、`M`はマージまで分かるんですが、`I`はよく分かっていません。
ブランチ毎のInitial Commitだと思うんですが、実際どうなんでしょう。

### タイムゾーン修正

`show-date = local`にしておくと、タイムゾーンが違うコミットログでもlocaltime(3)で表示します。  
※コミット差分の表示画面ではタイムゾーン付きの時刻が表示されます。

## 余談

[tigのマニュアル](http://jonas.nitro.dk/tig/manual.html)を読むと、実はブラウズ以外にもcommitやgcを使えたり、tigから直接ファイルオープンして編集ができるなど多機能です。
ただこれ使ってる人いるんでしょうか…（私はあくまでブラウジングのみの利用者でした）。
