---
title: Puppet Fileリソースのbackup属性を試してみる
date: 2014-05-30
tags:
- puppet
---
PuppetのFileリソースには[backup属性](http://docs.puppetlabs.com/references/latextfile/type.html#file-attribute-backup)がある。

ドキュメントにも書いてあるが、挙動について簡単にまとめると、次のようになる。

- `backup => false`なら、既存のファイルを置き換える
- `backup => true`なら、`.puppet-bak`というsuffixをつけてバックアップする
- `backup => .hoge`なら`.hoge`というsuffixをつけてバックアップする
 - ただしsuffixはドット __`.`__ キャラクタ始まりでなければいけない
- `filebucket`名を指定すると、filebucket先にデータを保存する

## backup機能の確認

### manifestの用意

以下のmanifestは`textfile`というファイルに`world`というテキストの書き込みを宣言している。
また、manifest適応時にバックアップを作成するように属性指定している。

```puppet
# filebackup.pp
file { '/home/vagrant/textfile':
  content => "world\n",
  backup  => true,
}
```

### 対象ファイルの中身

対象の`textfile`ファイルには`hello`というテキストが既に書かれているものとする。

```shell-session
[vagrant@filebackup ~]$ cat textfile
hello
```

### 実験

実験環境にはCentOS 6.5のVagrant環境を用意した。
Puppetのバージョンは3.6.1である。

manifestを適応する。

```shell-session
[vagrant@filebackup ~]$ puppet apply filebackup.pp --verbose --show_diff
Notice: Compiled catalog for filebackup.vagrant.dev in environment production in 0.05 seconds
Info: Applying configuration version '1401441347'
Notice: /Stage[main]/Main/File[/home/vagrant/textfile]/content:
--- /home/vagrant/textfile      2014-05-30 18:15:46.306020296 +0900
+++ /tmp/puppet-file20140530-2194-1gmsxh1-0     2014-05-30 18:15:48.000017879 +0900
@@ -1 +1 @@
-hello
+world

Info: /Stage[main]/Main/File[/home/vagrant/textfile]: Removing old backup of type file
Notice: /Stage[main]/Main/File[/home/vagrant/textfile]/content: content changed '{md5}b1946ac92492d2347c6235b4d2611184' to '{md5}591785b794601e212b260e25925636fd'
Notice: Finished catalog run in 0.05 seconds
```

### 結果

manifest適応後、textfileの他にtextfile.puppet-bakが生成された。

```shell-session
[vagrant@filebackup ~]$ ls -l textfile*
-rw-rw-r-- 1 vagrant vagrant 6 May 30 18:15 textfile
-rw-rw-r-- 1 vagrant vagrant 6 May 30 18:15 textfile.puppet-bak
```

中身は以下のとおりである。
manifestの内容通り、`textfile`には`world`のテキストが書き込まれ、`textfile.puppet-bak`には元のテキストがあり、`.puppet-bak`にバックアップされていることが分かる。

```shell-session
[vagrant@filebackup ~]$ cat textfile
world
[vagrant@filebackup ~]$ cat textfile.puppet-bak
hello
```

## localでのfilebucketの確認

[filebucket](http://docs.puppetlabs.com/references/latest/type.html#filebucket)はファイルコンテンツ用リポジトリを提供するリソースである。
ローカル環境またはpuppet masterサーバに、MD5チェックサムによって分類されたファイルコンテンツを集約することが出来る。

### manifestの用意

以下のmanifestは先ほどと同じ宣言に加えて、`main`という名前のfilebucketを用意している。
また、`textfile`のbackup先にfilebucketを指定している。

```puppet
filebucket { 'main':
  path => '/home/vagrant/filebucket',
}

file { '/home/vagrant/textfile':
  content => "world\n",
  backup  => true,
}
```

### 実験

ログを見ると、対象コンテンツの置換前後のMD5が表示されている。

- before: `b1946ac92492d2347c6235b4d2611184`
- after: `591785b794601e212b260e25925636fd`

```shell-session
[vagrant@filebackup ~]$ puppet apply filebucket.pp -v --show_diff
Notice: Compiled catalog for filebackup.vagrant.dev in environment production in 0.05 seconds
Info: Applying configuration version '1401442671'
Notice: /Stage[main]/Main/File[/home/vagrant/textfile]/content:
--- /home/vagrant/textfile      2014-05-30 18:37:40.489017666 +0900
+++ /tmp/puppet-file20140530-2943-1bttz18-0     2014-05-30 18:37:51.429017677 +0900
@@ -1 +1 @@
-hello
+world

Info: /Stage[main]/Main/File[/home/vagrant/textfile]: Filebucketed /home/vagrant/textfile to main with sum b1946ac92492d2347c6235b4d2611184
Notice: /Stage[main]/Main/File[/home/vagrant/textfile]/content: content changed '{md5}b1946ac92492d2347c6235b4d2611184' to '{md5}591785b794601e212b260e25925636fd'
Notice: Finished catalog run in 0.05 seconds
```

### 結果

指定した通り、`filebucket`という名前のディレクトリが生成されている。
また、元コンテンツのMD5を1文字ずつ切り出した複数階層のディレクトリツリーが内部に用意されていることが分かる。

```shell-session
[vagrant@filebackup ~]$ ls -ld filebucket
drwxrwx--- 3 vagrant vagrant 4096 May 30 18:37 filebucket
[vagrant@filebackup ~]$ tree -apug filebucket
filebucket
`-- [drwxrwx--- vagrant  vagrant ]  b
    `-- [drwxrwx--- vagrant  vagrant ]  1
        `-- [drwxrwx--- vagrant  vagrant ]  9
            `-- [drwxrwx--- vagrant  vagrant ]  4
                `-- [drwxrwx--- vagrant  vagrant ]  6
                    `-- [drwxrwx--- vagrant  vagrant ]  a
                        `-- [drwxrwx--- vagrant  vagrant ]  c
                            `-- [drwxrwx--- vagrant  vagrant ]  9
                                `-- [drwxrwx--- vagrant  vagrant ]  b1946ac92492d2347c6235b4d2611184
                                    |-- [-r--r----- vagrant  vagrant ]  contents
                                    `-- [-rw-r----- vagrant  vagrant ]  paths
```

`contents`と`paths`の中身は以下のとおりである。
`contents`には置換前のファイルが格納されており、`paths`には対象ファイルまでの絶対パスが記述されている。

```shell-session
[vagrant@filebackup ~]$ cat filebucket/b/1/9/4/6/a/c/9/b1946ac92492d2347c6235b4d2611184/contents
hello
[vagrant@filebackup ~]$ cat filebucket/b/1/9/4/6/a/c/9/b1946ac92492d2347c6235b4d2611184/paths
/home/vagrant/textfile
```

### リストア

なお、置換したファイルをリストアする場合は、`puppet filebucket restore`コマンドを用いることが出来る。

```shell-session
[vagrant@filebackup ~]$ cat textfile
world
[vagrant@filebackup ~]$ puppet filebucket restore textfile b1946ac92492d2347c6235b4d2611184 --bucket /home/vagrant/filebucket --verbose
Info: FileBucket read b1946ac92492d2347c6235b4d2611184
[vagrant@filebackup ~]$ cat textfile
hello
```

`puppet filebucket restore`の後に、対象ファイルと元コンテンツのMD5値を指定する。
filebucketディレクトリは`--bucket`で指定できる。
無指定の場合は、デフォルト (`/var/lib/puppet/bucket`等) から探す。

また`puppet filebucket`コマンドには、他にもバックアップを行う`backup`コマンドやバックアップされたコンテンツを取得・表示する`get`コマンドがある。

## まとめ

- Puppet FileリソースのBackup属性の動作を確認した
- FileBucketはローカルでの検証を行い、指定先のディレクトリにmd5値を利用したファイルコンテンツが保存されることを確認した
- `puppet filebucket`コマンドを使えばリストア可能

puppet master/agent構成を利用したリモートFileBucketは別途検証していく予定です。
