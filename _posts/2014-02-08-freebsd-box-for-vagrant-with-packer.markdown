---
layout: post
title: Vagrant用FreeBSDのboxをPackerで作った
tags:
- vagrant
- freebsd
- packer
---
Packerの練習をしたくて、FreeBSD 10.0のVagrant boxを作るためのテンプレを用意してみた。

 * [Tacahilo/packer-FreeBSD-10.0](https://github.com/Tacahilo/packer-FreeBSD-10.0)

## Usage

これの使い方は簡単で、Macであれば以下のように実行していけばいい。

```console
$ brew install packer # beforehand, brew tap homebrew/binary
$ git clone git@github.com:Tacahilo/packer-FreeBSD-10.0.git && cd packer-FreeBSD-10
$ packer build packer/FreeBSD-10.0-RELEASE-amd64.json
```

実質、最後の1行がビルドするコマンドになる。

もし様子がおかしい時は、テンプレの`boot_command`の`<wait>`を`<wait10>`に変えたりして、各コマンド間の実行間隔を調整してみてほしい。

## Vagrant up

ちなみにVagrantで簡単に試せるようにVagrantfileも用意しているので、packerでのビルド完了後に、

```console
$ vagrant up amd64
```

と打てば、FreeBSD 10.0なVagrant boxにログイン出来る。

ちなみに、FreeBSDはNFSじゃないと`synced_folder`が言うこと聞いてくれないんだけど、NFSにしたらしたで、これがまたmountするだけのクセにめちゃんこ重たい。
upするときはコーヒーブレイクするといいと思う。

一応boxをあげたDropboxリンクも用意した。

 * https://www.dropbox.com/s/y1gtvrl8l7fp8dp/freebsd-10.0-amd64_puppet.box
 * https://www.dropbox.com/s/37yxdu7mhj8nih4/freebsd-10.0-i386_puppet.box

## Packerでの箱作成で難しかったこと

とは言ったものの、Packer自体はそんなに難しくなくて、これはテンプレファイルの中身を順番に実行してくれるだけだから、[公式ドキュメント](http://www.packer.io/docs)さえ読めばだいたいのことは分かった。

むしろ、OSへの理解が足りなくてとにかく困った。

### FreeBSDの起動プロセスが分からず、`boot_command`が書けない

『[第13章 FreeBSD の起動のプロセス](http://www.freebsd.org/doc/ja/books/handbook/boot.html)』あたりを読んでようやく理解した。

### bsdinstallのscriptの書き方がよく分からない

RedHat系で言うところのkickstart的なスクリプトの書き方が分からず、結局は`man 8 bsdinstall`の最後の方に書いてあったのでそれを真似した。

### FreeBSDはNFSじゃないと`synced_folder`でマウント出来ない

普通に`vagrant up`しようとすると以下のようなエラーが出てしまう。

```
[amd64] Mounting shared folders...
[amd64] -- /vagrant
Vagrant attempted to execute the capability 'mount_virtualbox_shared_folder'
on the detect guest OS 'freebsd', but the guest doesn't
support that capability. This capability is required for your
configuration of Vagrant. Please either reconfigure Vagrant to
avoid this capability or fix the issue by creating the capability.
```

これはPackerではなくVagrant側だけど、地味にめんどくさかった。
`private_ip`を付けて、`:nfs => true`にすると上手くいったけど、mountにえらく時間がかかる…。

ひとまずこれでFreeBSDの箱は出来た。作るのに2〜3日くらい使ってしまったけど、OS installationの勉強にもなって良かった。

ZFSをPuppetで定義したり、pkgngをserverspecで使えるようにするための検証環境として作ったつもりなので、これから色々と試していこうと思う。
