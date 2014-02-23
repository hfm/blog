---
layout: post
title: 多段sshを利用した時の設定メモ
tags: 
- ssh
---
会社の先輩であるglidenote先生に教えてもらった多段sshを設定してみました。便利！

 * [多段SSHで4段先のサーバに一発ログイン - Glide Note - グライドノート](http://blog.glidenote.com/blog/2012/02/19/ssh-proxycommand/)

初歩的なことなんですが、設定中に「お？」となってしまったところを忘れないようにメモしました。

## 多段sshの基本

```
+-------+  ssh   +----------------+  ssh   +----------------+
| local | -----> | linux server 1 | -----> | linux server 2 |
+-------+        +----------------+        +----------------+
```

## 接続先のUser名がそれぞれ異なる時

```kconfig
Host mhete
HostName manage.heteml.jp
User hfm-paperboy
IdentityFile ~/.ssh/id_rsa

Host sakura
HostName  219.94.241.187
User hfm
Port 5331
IdentityFile ~/.ssh/id_rsa

Host main
HostName main.okkun.pb
User hfm
IdentityFile ~/.ssh/id_rsa

Host mheter
HostName manage.heteml.jp
User hfm-paperboy
ProxyCommand ssh main nc %h %p

Host *
ForwardAgent yes
ServerAliveInterval 60
```
