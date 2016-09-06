---
date: 2016-09-06T21:00:18+09:00
title: mruby のテスト用に MySQL 環境を自動で構築する mruby-test-mysqld を書いた
tags:
- mruby
- mysql
---
タイトルは『[Kazuho@Cybozu Labs: Perl のテスト用に MySQL 環境を自動で構築するモジュール Test::mysqld を書いた](http://developer.cybozu.co.jp/archives/kazuho/2009/08/perl-mysql-test.html)』のオマージュです。

[Test::mysqld](http://search.cpan.org/~kazuho/Test-mysqld/) は、テスト用に MySQL のデータディレクトリを一時ディレクトリに用意し、 mysqld サーバの立ち上げ・削除を自動実行してくれる大変便利なツールです。同じことを mruby で扱いたくなったので、見よう見まねで移植版を作ってみました。実装にあたっては [miyucy/test\-mysqld](https://github.com/miyucy/test-mysqld) も大変参考になりました。

- [hfm/mruby\-test\-mysqld: Setting up a mysqld instance in tmpdir, and destroying it when a mruby program exits\.](https://github.com/hfm/mruby-test-mysqld)

TestMysqld.new をすると、DB を初期化し、mysqld を起動します。また、TestMysqld#close を呼ぶか、プログラム終了時に mysqld インスタンスは削除されます。ちなみに、mruby から MySQL へのアクセスには [mattn/mruby\-mysql](https://github.com/mattn/mruby-mysql/) の使用を想定しています。

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

MySQL 5.7.6 から mysql_install_db が deprecated になり、代わりに mysqld --initialize に変わりましたが、mruby-test-mysqld は両方に対応しています。動作は OSX El Capitan でそれぞれ試し、Travis-CI で 5.5 系のテストをしています。両コマンドの差異は、[日々の覚書: MySQL 5\.7\.6でデータベースの初期化が変わる mysql\_install\_dbからmysqld \-\-initialize](https://yoku0825.blogspot.jp/2015/03/mysql-576-mysqlinstalldbmysqld.html) に詳しい説明があります。

その過程で、バージョン比較をする [hfm/mruby\-versioncmp](https://github.com/hfm/mruby-versioncmp) も作りました。x.y.z で書かれているバージョン同士しか出来ない雑な作りなので、少しずつ手を加えていく予定。
