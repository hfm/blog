---
date: 2014-11-29T16:15:49+09:00
title: cronで祝日判定しようと思ったら，emasaka/jpholidaypが素晴らしかった
tags: 
- python
---
## TL;DR

- [emasaka/jpholidayp](https://github.com/emasaka/jpholidayp)を使えば二値判定で祝日 or notが得られる
- cronに`M H d m 1-5 /path/to/jpholidayp || /path/to/cron-job`と入れれば，平日かつ非祝日にcronを実行出来る

## 平日動かしているjobが，祝日でも動いてしまう問題

cronは，`* * * * 1-5 /path/to/program`と入力すれば，月−金の平日にだけ仕事をするようになるが，祝日までは考慮しない．
営業日のみ，IRCへの通知やジョブの実行をしたい．

そこで，「cron 祝日」でググってみたところ，真っ先に以下がヒットした．

- [本を読む cronから使えるよう祝日判定コマンドを書いた](http://emasaka.blog65.fc2.com/blog-entry-1091.html)
- [emasaka/jpholidayp](https://github.com/emasaka/jpholidayp)
    
jpholidaypは祝日か否かを二値判定するプログラムで，祝日であれば`0`，祝日でなければ`1`を返す．

このプログラムはPythonで書かれているのだが，一枚の簡単なスクリプトになっているのが素晴らしい．
例えば営業日の10時に実効したいジョブがあれば，以下のように設定する．

```sh
0 10 * * 1-5 /path/to/jpholidayp || /path/to/job
```

これで月-金10時にcronが実行されるようになるが，祝日の場合はjpholidaypが`0`を返すため，jobは実行されない．

### ちょっと気になったこと

以前のjpholidaypの祝日情報の取得はGoogle Calendarだったが，最近[k1LoW/holiday_jp](https://github.com/k1LoW/holiday_jp)に切り替えた[^1]らしい．

- [日本の祝日データセット "holiday_jp" はじめました - Copy/Cut/Paste/Hatena](http://k1low.hatenablog.com/entry/2014/11/19/232050)

この変更は悪くないのだが，1つ残念なことがあって，jsonからyamlへとモジュールを変更してしまったようだ．
jsonはPython 2.6から標準ライブラリに搭載されているのだが，yamlは実は入っていない．
RHEL系なら`yum install PyYAML`を使って，別途インストールしないと動かなくなってしまった．

とはいえ，pythonからyamlを扱うケースは往々にしてあるだろうし，そこまで嘆くほどでもない．
重要なのは，このたった一枚のスクリプトが，祝日か否かという面倒くさい問題を解決してくれることにある．
（あと，yamlが嫌なら古いバージョンを使えばいい[^2]）

jpholidaypをサーバに設置すれば即使用可能になるのは本当に素晴らしいと思う．

[^1]: https://github.com/emasaka/jpholidayp/commit/3985df2c9c868e74edac207fa7495d523255b3b9
[^2]: [d29a61f](https://github.com/emasaka/jpholidayp/commit/d29a61f76331a502b8710757da39b0fe15373508)の時点までは，Google Calendarからjsonで読み込んでおり，Python 2.6系なら問題なく扱えるようになる
