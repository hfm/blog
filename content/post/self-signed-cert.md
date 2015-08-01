---
title: そこそこ楽にオレオレ証明書を発行する
date: 2014-03-06
tags:
- openssl
---
ペパボ社内でちらっと書いた内容なんですが、そこそこ便利だと思うのでブログにも投下。

そこそこ短い工数でオレオレ証明書を発行するコマンドです。

```sh
COMMON_NAME=domain.iretene.com
openssl req -new -newkey rsa:2048 -nodes -out $COMMON_NAME.csr -keyout $COMMON_NAME.key -subj "/C=/ST=/L=/O=/OU=/CN=$COMMON_NAME"
openssl x509 -days 12000 -req -signkey $COMMON_NAME.key -in $COMMON_NAME.csr -out $COMMON_NAME.crt
```

`COMMON_NAME=`にお好きなドメインを入れていただければ、秘密鍵、csr、crtファイルをまるまるっと吐き出すます。

`man req`と`man x509`で理解した限りの内容を書くと、以下のような内訳のようです。

 * `openssl req`
   * `-new` ... 新規作成
   * `-newkey` rsa:2048 ... 2048bitで鍵作成
   * `-nodes` ... パスフレーズ不要（暗号化なし）
   * `-out` ... 出力するの名前（今回は証明書署名要求）
   * `-keyout` ... 出力する秘密鍵
   * `-subj` ... 証明書作成時に住所や組織を一個一個聞かれるのを省ける
     * C=国（JPとか）
     * ST=週（日本だとTokyoとか）
     * L=住所（Shibuya-kuとか）
     * O=組織（株式会社なんちゃらとか）
     * OU=組織部門（会社のどっかの部署名とか）
     * CN=COMMON NAME（FQDNや個人名）
 * `openssl x509`
   * `-days` ... 証明書の有効期間
   * `-req` ... inputに証明書署名要求を選択する
   * `-signkey` ... 証明書に使う秘密鍵
   * `-in` ... 証明書署名要求
   * `-out` ... 出力される証明書

「ここの説明おかしいぞ！」という箇所がありましたら、[@hfm](https://twitter.com/hfm)まで投斧ください。

## おや、opensslの様子が…？

…と、公開したコマンドはここまでだったんですが、もうちょっとmanualを読んでいると、証明書署名要求を飛ばして自己証明書を発行できそうなコマンドを発見。

```sh
openssl req -x509 \
            -days 36500 \
            -newkey rsa:2048 \
            -nodes \
            -out $COMMON_NAME.crt \
            -keyout $COMMON_NAME.key \
            -subj "/C=/ST=/L=/O=/OU=/CN=$COMMON_NAME"
```

実行結果はご覧のとおりです。

```console
$ COMMON_NAME=hifumi.info
$ openssl req -x509 -days 36500 -newkey rsa:2048 -nodes -out $COMMON_NAME.crt -keyout $COMMON_NAME.key -subj "/C=/ST=/L=/O=/OU=/CN=$COMMON_NAME"
Generating a 2048 bit RSA private key
....................+++
..............+++
writing new private key to 'hifumi.info.key'
-----
No value provided for Subject Attribute C, skipped
No value provided for Subject Attribute ST, skipped
No value provided for Subject Attribute L, skipped
No value provided for Subject Attribute O, skipped
No value provided for Subject Attribute OU, skipped
```

これで100年有効な証明書の作成が完了しました。
念の為に確認すると…、

```console
$ openssl x509 -text -noout -in hifumi.info.crt | grep -B1 -A2 Validity
        Issuer: CN=hifumi.info
        Validity
            Not Before: Mar  6 14:51:51 2014 GMT
            Not After : Feb 10 14:51:51 2114 GMT
```

良かったできてる。
`-x509`というオプションを使えば、`-out`にcertを期待出来るようです。

というわけで、OpenSSLゴルフ的な遊びでした。
