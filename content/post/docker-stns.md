---
date: 2016-07-31T22:16:37+09:00
title: STNS の Dockerfile を Docker Hub に公開した
tags:
- stns
---
STNS は TOML フォーマットの設定ファイルを用いて Linux のユーザ管理を行うことができるシステムです。Linux の名前解決や公開鍵取得、sudo 認証が主な機能で、サーバへのログインやデプロイをシンプルに管理することができます。詳しくは「[Linuxユーザーと公開鍵を統合管理するサーバ&クライアントを書いた\[更新\]](https://ten-snapon.com/archives/1228)」や「[時代が求めたSTNSと僕](https://speakerdeck.com/pyama86/shi-dai-gaqiu-metastnstopu)」をご覧ください。

今回、stns をより簡単に触れる環境を提供するため、 stns の Docker image を Docker Hub に公開しました。

- [STNS/docker\-STNS: Docker image for STNS\.](https://github.com/STNS/docker-STNS)
- https://hub.docker.com/r/stns/stns

[Alpine Linux](http://alpinelinux.org/) をベースイメージとしており、非常に小さいイメージサイズに保つことが出来ました。

```console
core@core-01 ~ $ docker images stns/stns
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
stns/stns           latest              6a568a2fead8        2 days ago          14.4 MB
```

例えば、以下のような stns.conf を用意し、docker コンテナにマウントさせるだけで stns サービスが立ち上がります。

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

「stns 気になるなー」と思っている方、是非一度お試しあれ!
