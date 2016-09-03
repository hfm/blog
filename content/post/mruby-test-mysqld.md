---
date: 2016-09-03T04:32:43+09:00
title: mruby のテスト用に MySQL 環境を自動で構築する mruby-test-mysqld を書いた
cover: /images/2016/08/19/mruby_logo_red.png
draft: true
tags:
- mruby
- mysql
---
タイトルは『[Kazuho@Cybozu Labs: Perl のテスト用に MySQL 環境を自動で構築するモジュール Test::mysqld を書いた](http://developer.cybozu.co.jp/archives/kazuho/2009/08/perl-mysql-test.html)』のオマージュです。Test::mysqld 最高。

テスト用に MySQL のデータディレクトリを一時ディレクトリに用意し、 mysqld サーバの立ち上げ・削除を自動実行してくれる大変便利な [Test\-mysqld](http://search.cpan.org/~kazuho/Test-mysqld/) ですが、mruby から扱いたいシーンが出てきたので、見よう見まねで mruby 移植版を作ってみました。実装にあたっては [miyucy/test\-mysqld: port of Test::mysqld](https://github.com/miyucy/test-mysqld) も大変参考になりました。

- [hfm/mruby\-test\-mysqld: Setting up a mysqld instance in tmpdir, and destroying it when a mruby program exits\.](https://github.com/hfm/mruby-test-mysqld)

使い方は簡単で、 `TestMysqld.new` をすると、mysql_install_db または mysqld --initialize が実行されたあと、mysqld を起動します。auto_start は個人的にまだ必要と感じなかったので実装してませんが、そのうちやるつもりです。また、mruby から MySQL にアクセスするには[mattn/mruby\-mysql](https://github.com/mattn/mruby-mysql/) を用います。

```ruby
mysqld = TestMysqld.new
# ... Initialize mysqld ...
# ... Starting mysqld ...
# => #<TestMysqld:0x7fcec1821480 @pid=28004, @mysql_install_db="/usr/local/bin/mysql_install_db", @mycnf={:socket=>"/tmp/mruby_testmysqld_1472791284/tmp/mysql.sock", :datadir=>"/tmp/mruby_testmysqld_1472791284/var", :pid_file=>"/tmp/mruby_testmysqld_1472791284/tmp/mysqld.pid"}, @base_dir="/tmp/mruby_testmysqld_1472791284", @mysqld="/usr/local/bin/mysqld">

db = MySQL::Database.new 'localhost', 'root', '', 'test', 3306, mysqld.socket
# => #<MySQL::Database:0x7ff03481e1d0 context=#<Object:0x7ff03481e1a0>>
# ... Execute db query...

db.close
# => nil

mysqld.stop
# ... Shutting down mysqld ...
# => nil
```

厄介だったのは、 MySQL 5.7.6 から DB 初期化コマンドの mysql_install_db が deprecated になり、代わりに mysqld --initialize に変わったこと。MySQL のバージョン判定を行い、 5.7.6 前後で初期化コマンドを変えなければいけないのが地味に面倒でした。この2つのコマンドの挙動が若干違うため、両方ちゃんと動いてるのが実は自信が無い。一応、OSX El Capitan で5.6, 5.7系それぞれ試したのと、 Travis-CI で 5.5 系でのテストも行っているので、動くとは思いますが。

- [日々の覚書: MySQL 5\.7\.6でデータベースの初期化が変わる mysql\_install\_dbからmysqld \-\-initialize](https://yoku0825.blogspot.jp/2015/03/mysql-576-mysqlinstalldbmysqld.html)

- [hfm/mruby\-versioncmp](https://github.com/hfm/mruby-versioncmp)
