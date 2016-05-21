---
date: 2016-05-04T17:43:23+09:00
title: hiera-eyaml でデータを暗号化して管理する
tags:
- puppet
- hiera
---
Puppet には [Hiera](https://docs.puppet.com/hiera/3.1/) と呼ばれるキーバリュー型データストアがあります。Chef の Data Bags に近しい機能で、ノード固有のデータを管理するために使います。
しかし、Chef の [Encrypted Data Bags](https://docs.chef.io/data_bags.html#encrypt-a-data-bag-item) のような暗号化・復号機能は提供されておらず、素のままで秘密情報を扱うには向いていません。

そこで登場するのが hiera-eyaml です。

- [TomPoulton/hiera-eyaml: A backend for Hiera that provides per-value asymmetric encryption of sensitive data](https://github.com/TomPoulton/hiera-eyaml)

hiera-eyaml はデータを暗号化・復号するための [Hiera Custom Backend](https://docs.puppet.com/hiera/3.1/custom_backends.html) です。これによって、パスワードなどの秘密情報を Hiera で管理することができます。似たツールに [crayfishx/hiera-gpg](https://github.com/crayfishx/hiera-gpg) もあったのですが、既に開発は終了したようです。他には、[maxlinc/puppet-decrypt](https://github.com/maxlinc/puppet-decrypt) という Puppet モジュールもあるようです。

以下に hiera-eyaml の使い方などについて書いていきます。

- hiera-eyaml の使い方
  - 鍵ペアの生成
    - 使用する鍵ペアの保管
      - CLI として使用する場合
      - Puppet から使用する場合
  - データの暗号化
  - データの復号
  - 暗号化されたデータの編集
  - 暗号化されたデータの再暗号化
- hiera-eyaml-gpg でプロジェクトメンバとデータを共有する
  - Puppet Server で使うときの注意


hiera-eyaml の使い方
---

### 鍵ペアの生成

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

#### 使用する鍵ペアの保管

##### CLI として使用する場合

hiera-eyaml は後述する暗号化や復号の際に `./keys` ディレクトリ以下の鍵ペアを読み込みますが、 `--pkcs7-private-key` `--pkcs7-public-key` オプションでパスを指定することも出来ます。

##### Puppet から使用する場合

Puppet から使用する場合には、 hiera.yaml の `:eyaml:` ハッシュに鍵ペアのパスを指定します。

```yaml
---
:yaml:
    :datadir: '/etc/puppet/hieradata'

:eyaml:
    :datadir: '/etc/puppet/hieradata'
    :pkcs7_private_key: /etc/puppetlabs/keys/private_key.pkcs7.pem
    :pkcs7_public_key:  /etc/puppetlabs/keys/public_key.pkcs7.pem
```

ちなみに、hiera-eyaml の README には鍵の保管場所として `/etc/puppet/secure/keys` か `/var/lib/puppet/keys` を提案されていますが、Puppet 4 と Puppet Server は `/etc/puppetlabs` に設定が集約されているので、 `/etc/puppetlabs/keys` あたりが妥当だと思います。

### データの暗号化

データの暗号化には `encrpyt` サブコマンドを使います。

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

### データの復号

データの復号には `decrpyt` サブコマンドを使います。

```console
$ eyaml decrypt --string 'ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEACt8MtwX5alq01AVWQ1+v6iGIGBQAmFXXNvdumibdc7PQpGIiJ5+dD8DLrKMM/6OpZfDtJViv6I8mkcVEyzjdiOJ+PjeSHt5YlfAhg6hfiT33AsD5EHAu73CXgknYbA44/htNjHKUYMgXCwWXXHLvJ6rPwJmf55hNqlW3vFxfl2HDbp9aqN+IXacAujWR7J7zZv+JVaIja/fBSrQKcNt9J77+Otuu11h88ACyuqsPEIqt5/z3TPEajs7gfaDdfhkSzOvdV4HEV2L9tpdeHb2O2Ly9cS2aGsJ4Iz+f64xKWnJ7VHEEua6j87dhPjwyOCRp64D/pNI0vIXjfLn8S6KNTzA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBH7MEI1No5aOkxSwgYnm30gBBSWtKxG1VT1T80KOC1Zv7y]'
hello world
```

### 暗号化されたデータの編集

`edit` サブコマンドを使うと、データを復号した状態で編集が可能になります。以下の例では、 `DEC(1)::PKCS7[...]` というブロックが暗号化データで、中身が表示されていることがわかります。

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

### 暗号化されたデータの再暗号化

`recrpyt` サブコマンドを使うと、暗号化された eyaml のデータを再度暗号化することが出来ます。

動作は単純で、 `eyaml recrpyt <eyaml file>` と実行すると、一度全ての暗号化データを復号し、生のデータをもう一度暗号化します。後述する [hiera-eyaml-gpg](https://github.com/sihil/hiera-eyaml-gpg) と組み合わせて使うと効力を発揮するものだと思います。

hiera-eyaml-gpg でプロジェクトメンバとデータを共有する
---

hiera-eyaml-gpg は hiera-eyaml プラグインの1つで、GPG を使ってデータを暗号化・復号します。

- [sihil/hiera-eyaml-gpg: GPG encryption backend for the hiera-eyaml module](https://github.com/sihil/hiera-eyaml-gpg)

### Puppet Server で使うときの注意

hiera-eyaml-gpg を使うには [gpgme](https://rubygems.org/gems/gpgme) か [ruby\_gpg](https://rubygems.org/gems/ruby_gpg) のどちらかが必要ですが、Puppet Server (JRuby) では native extension が使えないので、 ruby\_gpg を使います。


```puppet
# Use puppetserver_gem module
# See also: https://github.com/puppetlabs/puppetlabs-puppetserver_gem

package {
  [
    'hiera-eyaml',
    'hiera-eyaml-gpg',
    'ruby_gpg',
  ]:
    ensure   => installed,
    provider => puppetserver_gem,
}
```

### puppet-agent から hiera-eyaml を使う

Puppet 4 からスタンドアロンで hiera-eyaml を利用するためには `/opt/puppetlabs/puppe/bin/gem` からインストールする必要があります。

```sh
/opt/puppetlabs/puppe/bin/gem install hiera-eyaml --no-document
```

参考
---

- [Encrypt Your Data Using Hiera-Eyaml | Puppet](https://puppet.com/blog/encrypt-your-data-using-hiera-eyaml)
- [TomPoulton/hiera-eyaml: A backend for Hiera that provides per-value asymmetric encryption of sensitive data](https://github.com/TomPoulton/hiera-eyaml)

