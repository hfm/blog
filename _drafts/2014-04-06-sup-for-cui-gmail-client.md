---
layout: post
title: Console-basedなメールクライアントSupで、ターミナルからGmailを管理する
tags:
- gmail
- ruby
- terminal
---
仕事はもっぱらターミナル上で、サーバ作業にWeeChatにVimにと、ターミナルへの執着が増してきている。

ブラウザを開く目的はGitHub (とGitHub Enterprise)とGmailくらいで、コードとかはAlfred PowerpackとDashで済むようになってきた。
Gmailをブラウザから覗くとメモリ消費も大きく、段々億劫になってきたので、ターミナルからGmailを管理できないものかと調べていた。

最初は[The Mutt E-Mail Client](http://www.mutt.org/)を使ってみようかと思ったが、なんとなく気に入らなくて調べていたら、supというRuby製のメールクライアントが見つかった。

> #### ___[sup](http://supmua.org/)___
> 
> Sup is a console-based email client for people with a lot of email.
> 
> It presents an interface of a list of threads, which are each hierarchical collections email messages. Threads can have multiple tags applied to them. It supports a very fast full-text search, automatic contact-list management, custom code insertion via a Ruby hook system, and more. If you’re the type of person who treats email as an extension of your long-term memory, Sup is for you.

[READMEに書いてあるFeatures / Problems](https://github.com/sup-heliotrope/sup#features--problems)によると、

 * Gmailのようなスレッド管理で、アーカイブやタグ、ミュートが利用可能
 * mboxやMaildirといった複数の形式を扱える
 * [Xapian](http://xapian.org/)というC++製検索エンジンライブラリによる高速検索 (昔はgolang製の[Ferret](https://github.com/argusdusty/Ferret)を使用していたらしい)
 * 複数アカウントの設定
 * Rubyで書かれており、プログラマブルなフック機構を備えている
 * 自動的に近々の連絡先をトラッキング可能 ~~（どういう意味だ？）~~

などを主な特徴としている。

複数アカウントを利用できることにあまり旨味を感じないが、Rubyで書かれており、またRubyで拡張可能であり、なによりGmailライクなスレッド形式なのがありがたい。

## Install on OS X

以下のような環境でインストールした。

 * OS X 10.9.2
 * homebrew 0.9.5
 * ruby 2.1.1p76 (with rbenv)

### sup

```sh
brew install ncurses
brew link --force ncurnes
gem install sup
```

このインストールに結構時間がかかる。
完了後、初期設定を実行する。

```console
$ sup-config
...
What's your name? (enter for "Okumura Takahiro"):
What's your (primary) email address? (enter for "hfm@giant.local"): YOUR@MAIL.ADDRESS
...
Alternate email addresses:
What file contains your signature? (enter for "/Users/USER/.signature"):
What editor would you like to use? (enter for "vim"):
```

こんな感じでメールアドレス等の設定を進めていく。

### msmtp

https://github.com/sup-heliotrope/sup/wiki/Mac-OSX ではSMTP clientとして __ssmtp__ と __msmtp__ が紹介されていた。

プロジェクトサイトを見る限りmsmtpの方が活発そうだった (google groupのdiscuss[[gentoo-user] ssmtp alternatives: msmtp vs. dma - Google グループ](https://groups.google.com/forum/#!topic/linux.gentoo.user/an_DE1BgMus)では、ssmtpがメンテナンスされてないとまで言われてる) のと、セットアップがより楽そうなmsmtpを選んだ。

 * ssmtpとmsmtpの比較のために読んだWebサイト
   * [Debian Package Tracking System - ssmtp](http://packages.qa.debian.org/s/ssmtp.html)
   * [msmtp | Free Communications software downloads at SourceForge.net](http://sourceforge.net/projects/msmtp/)

```sh
brew install msmtp --with-curl-ca-bundle
```

```
account        gmail
host           smtp.gmail.com
port           587
protocol       smtp
auth           on
from           YOURADDRESS@gmail.com
user           YOURADDRESS@gmail.com
tls            on
tls_trust_file /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
```

一番最後の行の`/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt`は、msmtpを入れた時のオプション`--with-curl-ca-bundle`で入ってくる（`brew install curl-ca-bundle`も同じ。）


### isync



 * [isync: free IMAP and MailDir mailbox synchronizer](http://isync.sourceforge.net/)

```sh
brew install isync
```

```
IMAPAccount          gmail
Host                 imap.mail.com
User                 YOURADDRESS@gmail.com
Pass                 YOURPASSWORD
UseIMAPS             yes
CertificateFile      /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

IMAPStore            gmail_remote
Account              gmail

MaildirStore         gmail_local
Path                 $HOME/Mail
Inbox                $HOME/Mail/Inbox

Channel              gmail
Master               :gmail_remote:
Slave                :gmail_local:
Patterns             * ![Gmail]* "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail"
Create               Slave # this will create the appropriate folders locally
Syncstate            * # to store the sync state of each folders in each folder separately
```

## 参考

 * [Mac OSX · sup-heliotrope/sup Wiki](https://github.com/sup-heliotrope/sup/wiki/Mac-OSX)
   * 基本的なセットアップは全部ここに書いてある
 *
