---
date: 2015-03-08T02:50:29+09:00
title: MySQL 5.5未満で pt-online-schema-change を使おうとして、innodb_lock_wait_timeout にハマった話
tags:
- mysql
---
**pt-online-schema-change**という[Percona Toolkit](http://www.percona.com/software/percona-toolkit)同梱ツールを使えば、対象をロックせずにスキーマの変更が出来る。

Perl製のツールで、DBIとDBD::mysqlが必須となる他、DESCRIPTION[^1]にある通り *"this tool only works with MySQL 5.0.2 and newer."* である。

さて、MySQL 5.0.2以上なら動作するとあるが、実はMySQLのバージョンが古いと上手く動かないケースがある。

## Unknown system variable 'innodb_lock_wait_timeout'

**MySQL 5.5未満**でpt-online-schema-changeによるALTERを実行しようとすると、次のようなエラーが出てしまうことがある。

```console
$ /usr/bin/pt-online-schema-change --ask-pass --alter "SQL" h=localhost,D=db,t=table,u=user
Enter MySQL password:
Error setting innodb_lock_wait_timeout: DBD::mysql::db do failed: Unknown system variable 'innodb_lock_wait_timeout' [for Statement "SET SESSION innodb_lock_wait_timeout=1"], <STDIN> line 1.  The current value for innodb_lock_wait_timeout is 50.  If the variable is read only (not dynamic), specify --set-vars innodb_lock_wait_timeout=50 to avoid this warning, else manually set the variable and restart MySQL.
```

これは**innodb_lock_wait_timeout**に関するエラーだ。
innodb_lock_wait_timeoutはInnoDBのトランザクションの行ロックに対するタイムアウト値（秒）のことで、MySQL 5.x (1 ≦ x ≦ 7) でのデフォルトは50秒となっている。

### pt-online-schema-changeのドキュメントを見てみる

pt-online-schema-changeでperldocで覗いてみると、コマンド実行時に`innodb_lock_wait_timeout=1`をセットすると説明がある。

> - **The tool sets "innodb_lock_wait_timeout=1"** and (for MySQL 5.5 and newer) "lock_wait_timeout=60" so that it is more likely to be the victim of any lock contention, and less likely to disrupt other transactions.  These values can be changed by specifying "--set-vars".

実はここに問題がある。
なんと、MySQL 5.5未満のMySQLのinnodb_lock_wait_timeoutは**動的に変更不可**なのだ。

#### Q: MySQL 5.5未満で値を変えようとすると？

A: 当然だがエラーになる。

```sql
mysql> set global innodb_lock_wait_timeout = 1;
ERROR 1193 (HY000): Unknown system variable 'innodb_lock_wait_timeout'
```

#### Q: innodb_lock_wait_timeoutのバージョンごとのシステム変数としての違いは？

A: MySQL 5.xにおけるinnodb_lock_wait_timeoutの違いを見てみる[^2][^3][^4]と、innodb_lock_wait_timeoutは5.5からDynamic Variablesに変わっていることが分かる。

                 | MySQL 5.0.x | MySQL <= 5.1.37 | MySQL >= 5.1.38 | MySQL 5.5
-----------------|-------------|-----------------|-----------------|----------------
Variable Scope   | Global      | Global          | Global, Session | Global, Session
Dynamic Variable | No          | No              | No              | **Yes**

MySQL 5.5未満でinnodb_lock_wait_timeoutを変更したい場合は、my.cnfに書いてMySQLを再起動するしか無い。

## 問題の回避策: `--set-vars`

さて、古いMySQLではpt-online-schema-changeの挙動に問題があることが分かった。

この問題を回避するためには、`--set-vars`でタイムアウト値を既存の設定値に合わせる必要がある。
デフォルト値は50なので、`--set-vars innodb_lock_wait_timeout=50`のように指定すれば良い（my.cnfで設定済みなら、現在の値に合わせれば良い）。

```sh
pt-online-schema-change \
    --set-vars innodb_lock_wait_timeout=50 \
    OTHER-OPTIONS DSN
```

## ところで、エラー文をもう一度

ちなみにこれ、エラーをよく読めば原因と対処法がハッキリと書いてある。

> Error setting innodb_lock_wait_timeout: DBD::mysql::db do failed: Unknown system variable 'innodb_lock_wait_timeout' [for Statement "SET SESSION innodb_lock_wait_timeout=1"], <STDIN> line 1.  The current value for innodb_lock_wait_timeout is 50.  If the variable is read only (not dynamic), specify --set-vars innodb_lock_wait_timeout=50 to avoid this warning, else manually set the variable and restart MySQL.

*"The current value ..."* 以降を読むと、「innodb_lock_wait_timeoutの現在値は50である。この変数がread only（動的に変更不可）なら、--set-vars innodb_lock_wait_timeout=50を指定してエラーを回避するか、手動で変数を変えてMySQLを再起動してほしい」といったことが書かれてある。

この問題に遭遇した当初、慌ててドキュメントや質問掲示板を読み漁ったりしていたのだが、なんのことは無い、エラー自身が全てを語っていたわけである。
とほほ。

[^1]: http://www.percona.com/doc/percona-toolkit/1.0/pt-online-schema-change.html#description
[^2]: http://dev.mysql.com/doc/refman/5.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout
[^3]: http://dev.mysql.com/doc/refman/5.1/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout
[^4]: http://dev.mysql.com/doc/refman/5.5/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout
