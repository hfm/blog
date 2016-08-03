---
date: 2016-08-03T18:55:32+09:00
title: プロセスは nsswitch.conf を一度しか読み込まない
draft: true
tags:
- linux
---
Puppet で、以下のような一連の処理を実行しようとしたところ、最後でコケてしまい上手くいかなかった。(libnss-stns などは ldap に読み替えてもらうと分かりやすいかもしれない。)

1. [libnss-stns](https://github.com/STNS/libnss_stns) インストール
1. nsswitch.conf の group に stns 追加
1. あるディレクトリを、stns で管理されている group に chgrp する

STNSサーバから group 情報を取ってきて、その group で chgrp してほしかったのだけど、 `Could not find group <group name>` なエラーで撃沈する。

どうも nsswitch.conf の設定が読み込まれていない気がしたので、 nsswitch.conf(5) を読んでみたところ、Notesのところに正にこれ！な一節を発見した。

> Within each process that uses nsswitch.conf, the entire file is read only once. If the file is later changed, the process will continue using the old configuration.
>
> _http://linux.die.net/man/5/nsswitch.conf_

プロセスは nsswitch.conf を一度しか読み込まないらしい。なので、プロセスが動いている途中に nsswitch.conf を変更したとしても、その変更は当該プロセスに反映されない。古い内容を抱えたまま処理が継続するので、3の処理でコケてしまうのだった。とほほ。
