---
date: 2016-05-24T01:46:05+09:00
title: hiera-eyaml でデータを暗号化して管理する
tags:
- puppet
- hiera
---
Puppet には [Hiera](https://docs.puppet.com/hiera/3.1/) と呼ばれるキーバリュー型データストアがあります。Chef の Data Bags に近しい機能で、主にノード固有のデータを管理するために使います。しかし、Chef の [Encrypted Data Bags](https://docs.chef.io/data_bags.html#encrypt-a-data-bag-item) のような暗号化・復号機能は提供されておらず、秘密情報を扱うには難があります。

そこで登場するのが **hiera-eyaml** です。

- [**TomPoulton/hiera-eyaml**: A backend for Hiera that provides per-value asymmetric encryption of sensitive data](https://github.com/TomPoulton/hiera-eyaml)

hiera-eyaml はデータを暗号化・復号するための [Hiera Custom Backend](https://docs.puppet.com/hiera/3.1/custom_backends.html) です。これによって、パスワードなどの秘密情報を Hiera で管理することができます。似たツールに [crayfishx/hiera-gpg](https://github.com/crayfishx/hiera-gpg) もあったのですが、既に開発は終了したようです。

今回は hiera-eyaml の使い方を紹介します（[README](https://github.com/TomPoulton/hiera-eyaml/blob/master/README.md) に書いてあることをかい摘んだような内容ですが。）なお、検証したバージョンは [2.1.0](https://github.com/TomPoulton/hiera-eyaml/tree/v2.1.0) です。

- [鍵ペアの生成](#鍵ペアの生成)
- [データの暗号化、復号、編集 (サブコマンド)](#データの暗号化-復号-編集-サブコマンド)
  - [encrypt](#encrypt)
  - [decrypt](#decrypt)
  - [edit](#edit)
- [鍵の設置場所](#鍵の設置場所)
  - [CLI として使用する場合](#cli-として使用する場合)
  - [puppet-agent や Puppet Server から使用する場合](#puppet-agent-や-puppet-server-から使用する場合)
- [暗号化されたデータの再暗号化](#暗号化されたデータの再暗号化)

鍵ペアの生成
---

新規に鍵ペアを作成するには `createkeys` サブコマンドを使います。実行すると、カレントディレクトリに `./keys` ディレクトリを作成し、その中に鍵ペアが生成されます。

```console
$ eyaml createkeys
[hiera-eyaml-core] Created key directory: ./keys
[hiera-eyaml-core] Keys created OK

$ ls -l keys/
total 16
-rw-------  1 hfm  staff  1675  5  4 17:41 private_key.pkcs7.pem
-rw-rw-r--  1 hfm  staff  1050  5  4 17:41 public_key.pkcs7.pem
```

データの暗号化、復号、編集 (サブコマンド)
---

### encrypt

作成した鍵ペアを使って、データの暗号化や復号、編集操作が行なえます。

データの暗号化には `encrypt` サブコマンドを使います。 `--label, -l` オプションと `--string, -s` オプションでキーバリューを決定します。

```console
$ eyaml encrypt --label 'message' --string 'hello world'
message: ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEArcBM1qm7e540lGkF4MnrMVCJ0hlWZVbHy39ojG9iiQgb9y4E5yz8fJ8y3OtQthtrWbjD/xvicK1E+Lahkxh7KRD0M6xYaNKtrjN5ccUCfepThhV7JMES6r7tqb7mkU38l7BU3Ite3ZeDW0Dree1iZ1+r1z4MvudaRQYJ6/4TsFZaY+DymuYXl5XzRBlHua+cMencNC1rYl5AmHUK7+izd+nTeCwFAVNlVNzvVcoj1xQA4skAUPb70YIosBz8fQ8bdb0JonRpHMnCNzK3q15iVB0x+QZtHlvKgN/7+59CrHnZgdYFVPo7Oo2AJayc8FlFCOdbJ5oCpZpAr/BCu9OeKjA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCTU8lH9K8Qd4TEJwRoEYzCgBBZR+jTPfcCeIU0c5dA3NzR]

OR

message: >
    ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEArcBM1qm7e540lGkF4MnrMVCJ0hlWZVbHy39o
    jG9iiQgb9y4E5yz8fJ8y3OtQthtrWbjD/xvicK1E+Lahkxh7KRD0M6xYaNKt
    rjN5ccUCfepThhV7JMES6r7tqb7mkU38l7BU3Ite3ZeDW0Dree1iZ1+r1z4M
    vudaRQYJ6/4TsFZaY+DymuYXl5XzRBlHua+cMencNC1rYl5AmHUK7+izd+nT
    eCwFAVNlVNzvVcoj1xQA4skAUPb70YIosBz8fQ8bdb0JonRpHMnCNzK3q15i
    VB0x+QZtHlvKgN/7+59CrHnZgdYFVPo7Oo2AJayc8FlFCOdbJ5oCpZpAr/BC
    u9OeKjA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCTU8lH9K8Qd4TEJwRo
    EYzCgBBZR+jTPfcCeIU0c5dA3NzR]
```

`--output, -o` オプションを指定しない場合、1行表示と複数行にわたるブロック表示の両方を表示する examples というフォーマットで出力されますが、 `-o string` や `-o block` と指定することで、出力フォーマットを指定することが出来ます。

### decrypt

データの復号には `decrpyt` サブコマンドを使います。

```console
$ eyaml decrypt --string 'ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEACt8MtwX5alq01AVWQ1+v6iGIGBQAmFXXNvdumibdc7PQpGIiJ5+dD8DLrKMM/6OpZfDtJViv6I8mkcVEyzjdiOJ+PjeSHt5YlfAhg6hfiT33AsD5EHAu73CXgknYbA44/htNjHKUYMgXCwWXXHLvJ6rPwJmf55hNqlW3vFxfl2HDbp9aqN+IXacAujWR7J7zZv+JVaIja/fBSrQKcNt9J77+Otuu11h88ACyuqsPEIqt5/z3TPEajs7gfaDdfhkSzOvdV4HEV2L9tpdeHb2O2Ly9cS2aGsJ4Iz+f64xKWnJ7VHEEua6j87dhPjwyOCRp64D/pNI0vIXjfLn8S6KNTzA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBH7MEI1No5aOkxSwgYnm30gBBSWtKxG1VT1T80KOC1Zv7y]'
hello world
```

これらのコマンドは、 `-f, --file` オプションによるファイル指定や `-e, --eyaml` オプションによる eyaml ファイルの指定、 `--stdin` オプションを使った標準入力からの利用が可能です。

### edit

`edit` サブコマンドを使うと、eyaml ファイルの編集が出来ます。以下に例を示します。 `DEC(1)::PKCS7[...]` というブロックが暗号化されているデータです。

```yaml
#| This is eyaml edit mode. This text (lines starting with #| at the top of the
#| file) will be removed when you save and exit.
#|  - To edit encrypted values, change the content of the DEC(<num>)::PKCS7[]!
#|    block.
#|    WARNING: DO NOT change the number in the parentheses.
#|  - To add a new encrypted value copy and paste a new block from the
#|    appropriate example below. Note that:
#|     * the text to encrypt goes in the square brackets
#|     * ensure you include the exclamation mark when you copy and paste
#|     * you must not include a number when adding a new block
#|    e.g. DEC::PKCS7[]!
message: >
    DEC(1)::PKCS7[hello world]!
```

鍵の設置場所
---

### CLI として使用する場合

CLI として使用する場合、鍵ペアはデフォルトで `./keys/(public|private)_key.pkcs7.pem` が用いられます。

また、 `--pkcs7-private-key` `--pkcs7-public-key` オプションか、 config.yaml でパスを指定出来ます。

```yaml
# /etc/eyaml/config.yaml or ~/.eyaml/config.yaml
---
pkcs7_private_key: '/path/to/project/.keys/hiera_private_key'
pkcs7_public_key:  '/path/to/project/.keys/hiera_public_key'
```

この config.yaml の位置は環境変数 `EYAML_CONFIG` で変更できるので、direnv などを利用してプロジェクトごとに用意することも可能です。

### puppet-agent や Puppet Server から使用する場合

[puppet-agent](https://docs.puppet.com/puppet/4.5/reference/about_agent.html) から hiera-eyaml をスタンドアロンで利用するためには、 `/opt/puppetlabs/puppet/bin/gem` からインストールする必要があります (おそらくOSXも同様の操作が可能ですが、Windows版と共に未検証です)。

```sh
/opt/puppetlabs/puppet/bin/gem install hiera-eyaml --no-document
```

また、[Puppet Server](https://docs.puppet.com/puppetserver/latest/services_master_puppetserver.html) から利用する場合は、 `/opt/puppetlabs/bin/puppetserver gem` コマンドを使います。

```sh
/opt/puppetlabs/puppetserver gem install hiera-eyaml --no-document
```

上記の操作に加えて、 hiera.yaml の設定も変更します。

```yaml
---
:backends:
  - yaml
  - eyaml # :backends: へ追加することで有効になる

:yaml:
  :datadir: "/etc/puppetlabs/code/environments/%{::environments}/hieradata"

:eyaml:   # :yaml: と同じ :datadir: と 鍵ペアのファイルパスを指定する
  :datadir: "/etc/puppetlabs/code/environments/%{::environments}/hieradata"
  :pkcs7_private_key: /etc/puppetlabs/keys/hiera_private_key
  :pkcs7_public_key:  /etc/puppetlabs/keys/hiera_public_key
```

ちなみに、hiera-eyaml の README には /etc/puppet/secure/keys か /var/lib/puppet/keys が鍵の保管場所として提案されています。しかしこの情報は古い Puppet 3 の頃の設定です。

Puppet 4 (puppet-agent) や Puppet Server からの設定ファイルは /etc/puppetlabs に集約されており、 `/etc/puppetlabs/keys` あたりに設置するのが妥当ではないかと思います。

暗号化されたデータの再暗号化
---

`recrpyt` サブコマンドを使うと、eyaml ファイルのデータを再暗号化することが出来ます。プロジェクトの規模が大きい場合、GPGを使った複数鍵での暗号化・復号を可能にする [hiera-eyaml-gpg](https://github.com/sihil/hiera-eyaml-gpg) との併用で効果を発揮しそうです。

- [sihil/hiera-eyaml-gpg: GPG encryption backend for the hiera-eyaml module](https://github.com/sihil/hiera-eyaml-gpg)

hiera-eyaml-gpg を使った運用方法も書くと長くなってしまうので、今回はPKCS#7ファイルによる使用法に留めます。

冒頭にも書いたとおり、hiera-eyaml の[README](https://github.com/TomPoulton/hiera-eyaml/blob/master/README.md) をかい摘んだような内容になりましたが、なんとなくの使い方はご理解いただけたでしょうか。モチベーションがあれば hiera-eyaml-gpg を使った管理方法について書こうと思います。

参考
---

- [Encrypt Your Data Using Hiera-Eyaml | Puppet](https://puppet.com/blog/encrypt-your-data-using-hiera-eyaml)
- [TomPoulton/hiera-eyaml: A backend for Hiera that provides per-value asymmetric encryption of sensitive data](https://github.com/TomPoulton/hiera-eyaml)
