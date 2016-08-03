---
date: 2016-08-03T22:08:56+09:00
title: プロセスは nsswitch.conf を一度しか読み込まない
tags:
- linux
---
Puppet で、以下のような一連の処理を実行しようとしたところ、最後で `Could not find group <group name>` なエラーが出てしまい、上手くいかなかった。

1. [libnss-stns](https://github.com/STNS/libnss_stns)[^1] インストール
1. nsswitch.conf の group に stns 追加
1. あるディレクトリの group を、stns で管理されている group に chgrp する

3 の実行において、 2 の変更を無視している気がする。そう思って nsswitch.conf(5) を読んでみたところ、Notes にまさにこれ！な一節を発見した。

> Within each process that uses nsswitch.conf, the entire file is read only once. If the file is later changed, the process will continue using the old configuration.
>
> _http://linux.die.net/man/5/nsswitch.conf_

プロセスは nsswitch.conf を一度しか読み込まないらしい。なので、プロセスが動いている途中に nsswitch.conf を変更したとしても、その変更は当該プロセスに反映されない。古い内容を抱えたまま処理が継続するので、3の処理でコケてしまうのだった。とほほ。

[^1]: stns を ldap に読み替えてもらうと分かりやすいかもしれない
