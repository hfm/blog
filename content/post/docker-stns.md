---
date: 2016-07-15T23:21:14+09:00
title: STNS の Dockerfile を Docker Hub に公開した
draft: true
tags:
- stns
---
STNSは、TOMLフォーマットの設定ファイルを用いてLinuxのユーザ管理を行うことができるシステムです。
LDAPのようにLinuxユーザー、グループや、SSHの公開鍵を管理することができる他、デプロイユーザの
TOMLフォーマットの設定ファイルを用いた、JSONフォーマットのAPIで集中管理出来るようになるサーバとクライアントから成るシステムです。特にLDAPと比較し、導入、ユーザー管理が容易な点が特徴です。

- [Linuxユーザーと公開鍵を統合管理するサーバ&クライアントを書いた\[更新\] \| 天神スナップオン](https://ten-snapon.com/archives/1228)
- [デプロイユーザーをSTNSで管理する \| 天神スナップオン](https://ten-snapon.com/archives/1330)
- [STNS pepabo\_hatena\_tech\_con // Speaker Deck](https://speakerdeck.com/pyama86/stns-pepabo-hatena-tech-con)

今回、STNS サーバの Docker image を Docker Hub に公開しました。

- [STNS/docker\-STNS: Docker image for STNS\.](https://github.com/STNS/docker-STNS)
- https://hub.docker.com/r/stns/stns

[Alpine Linux](http://alpinelinux.org/) をベースイメージとしており、非常に小さいイメージサイズになっています。

```console
core@core-01 ~ $ docker images stns/stns
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
stns/stns           latest              6a568a2fead8        2 days ago          14.4 MB
```

```ini
[users.example]
id = 1001
group_id = 1001
directory = "/home/example"
shell = "/bin/bash"
keys = ["ssh-rsa XXXXX…"]
link_users = ["foo"]
```

```console
core@core-01 ~ $ docker run --name stns -d -p 1104:1104 -v $PWD/stns.conf:/etc/stns/stns.conf stns/stns
d2fb6dd12692bf6e8d2b068583d6846a4d4477a7f2f8f02979d5c5bb65a49012
core@core-01 ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
d2fb6dd12692        stns/stns           "stns"              5 seconds ago       Up 4 seconds        0.0.0.0:1104->1104/tcp   stns
```

```console
core@core-01 ~ $ curl 0.0.0.0:1104/user/name/example
{
  "example": {
    "id": 1001,
    "password": "",
    "hash_type": "",
    "group_id": 1001,
    "directory": "/home/example",
    "shell": "/bin/bash",
    "gecos": "",
    "keys": [
      "ssh-rsa XXXXX…"
    ],
    "link_users": [
      "foo"
    ]
  }
}
```

[^1]: http://www.jil.go.jp/institute/zassi/backnumber/2010/10/pdf/004-015.pdf
[^2]: http://tech.pepabo.com/2015/12/25/professional-career-at-pepabo/
