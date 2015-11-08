---
date: 2014-11-30T01:14:25+09:00
title: instagram-ruby-gemを使ってみた
tags: 
- photo
- ruby
---
Instagram gemを使ってみた。
これを使えばInstagram APIを使ってアレコレ操作できるようになる。

- [Instagram/instagram-ruby-gem](https://github.com/Instagram/instagram-ruby-gem/tree/master/lib/instagram/client)

## アクセストークンの取得

ただし、使い始めるために http://instagram.com/developer/ からそこそこ面倒くさい開発者登録とアクセストークンの発行が必要になる。

アクセストークンの発行は http://instagram.com/developer/authentication/ を読めばちゃんと手順が書いてあるんだけど、結構めんどくさい。
(2011年くらいのブログ記事の手順と、微妙に変わっているところがあるみたいで、そこもハマった。)
日本語の手順は以下が分かりやすいと思う。

- [instagram api 事始め access\_tokenを取得する - Qiita](http://qiita.com/zurg/items/4c423b93b6a7f1ac737d)

## クライアントの生成

`Instagram.client`にアクセストークンを突っ込めば、簡単にクライアントを作成出来る。

```rb
require 'instagram'
client = Instagram.client(:access_token => "***********************************************")
```

認証が通ると、clientを使って以下のように自分の情報を取得出来るようになったりする。

```rb
client.user
=> #<Hashie::Mash bio="Fujifilm X100T" counts=#<Hashie::Mash followed_by=427 follows=121 media=388> full_name="Takahiro Okumura" id="131211" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_131211_75sq_1367148541.jpg" username="hfm" website="http://blog.hifumi.info/">
```

## メソッドいくつか

これでInstagram gemを利用可能になったのだけど、どんなメソッドが使えるのか、いまいちドキュメントが不足している気がする。

[instagram-ruby-gem/lib/instagram/client](https://github.com/Instagram/instagram-ruby-gem/tree/master/lib/instagram/client)の辺りに色々メソッドがあるみたいなので、コードを読みながらいくつか試してみた。
ザッと見た限りだと、[Instagram API Endpoints](http://instagram.com/developer/endpoints/)と対応してるように思う。
幸いなことに、コメントアウトに説明がちゃんと書いてあるし、メソッド名も分かりやすいので使うには困らないと思う。

以下はあくまで素朴な使い方程度で、コードを読む限り細かくオプションで制御できるみたいなので、時間のある人はコードとドキュメントを参考にして欲しい。

### oembed

一番の目当てがこれだった。
Instagramのshort urlを入力として、oEmbedフォーマット[^1]な情報を返してくれる。

```rb
client.oembed('instagram.com/p/vD3eXckvOI')
=> #<Hashie::Mash author_id=131211 author_name="hfm" author_url="http://instagram.com/hfm" height=640 media_id="847765134193652616_131211" provider_name="Instagram" provider_url="http://instagram.com/" title="#mizzy_sushi 本当にご馳走様でした。" type="photo" url="http://photos-g.ak.instagram.com/hphotos-ak-xpa1/10375862_1548238215390734_813559919_n.jpg" version="1.0" width=640>
```

### user

（上の例でも使っているが、）ユーザ情報を出力する。
引数無しの場合は、アクセストークンの発行者、つまりは自分の情報を出力する。
（ちなみに`'self'`という文字列を与えても自分の情報を入手できるみたいだ[^2]）

引数として数字を突っ込めば、該当IDのユーザ情報を出力する。
ちなみにInstagramのユーザの1番目と2番目は不在らしく、いずれもエラーが返ってくる。
3番目になってようやくユーザ情報が取得できるが、それはInstagramのCEO兼共同設立社のKevin Systromらしい。

```rb
client.user 3
=> #<Hashie::Mash bio="CEO & Co-founder of Instagram" counts=#<Hashie::Mash followed_by=1143140 follows=591 media=1375> full_name="Kevin Systrom" id="3" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_3_75sq_1325536697.jpg" username="kevin" website="">
```

### tag\_recent\_media

入力したタグを含む最近の投稿をまとめて取得する。
どの程度の量が取得出来るのかは正直分からない。

```rb
client.tag_recent_media('pepabo')
=> [#<Hashie::Mash attribution=nil caption=#<Hashie::Mash created_time="1409398414" from=#<Hashie::Mash full_name="Takahiro Okumura" id="131211" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_131211_75sq_1367148541.jpg" username="hfm"> id="798414225122980181" text="#yapcasia #pepabo"> comments=#<Hashie::Mash count=0 data=[]> created_time="1409398414" filter="Inkwell" id="798414224569331729_131211" images=#<Hashie::Mash low_resolution=#<Hashie::Mash height=306 url="http://scontent-a.cdninstagram.com/hphotos-xaf1/t51.2885-15/10632283_924828147532659_489465752_a.jpg" width=306> standard_resolution=#<Hashie::Mash height=640 url="http://scontent-a.cdninstagram.com/hphotos-xaf1/t51.2885-15/10632283_924828147532659_489465752_n.jpg" width=640> thumbnail=#<Hashie::Mash height=150 url="http://scontent-a.cdninstagram.com/hphotos-xaf1/t51.2885-15/10632283_924828147532659_489465752_s.jpg" width=150>> likes=#<Hashie::Mash count=11 data=[#<Hashie::Mash full_name="uxul" id="195575" profile_picture="https://igcdn-photos-a-a.akamaihd.net/hphotos-ak-xpa1/10467997_260450844156688_2135080677_a.jpg" username="uxul">, #<Hashie::Mash full_name="Shidahara Kazuya" id="301683" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_301683_75sq_1333280557.jpg" username="elek1tel">, #<Hashie::Mash full_name="Higuchi Kenji" id="215900" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_215900_75sq_1287793857.jpg" username="higuchama">, #<Hashie::Mash full_name="atani" id="1311439" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_1311439_75sq_1358180523.jpg" username="atani">]> link="http://instagram.com/p/sUiYHPEvAR/" location=#<Hashie::Mash id=249122552 latitude=35.552585204 longitude=139.647294255 name="HUB　慶応日吉店"> tags=["yapcasia", "pepabo"] type="image" user=#<Hashie::Mash bio="" full_name="Takahiro Okumura" id="131211" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_131211_75sq_1367148541.jpg" username="hfm" website=""> user_has_liked=false users_in_photo=[#<Hashie::Mash position=#<Hashie::Mash x=0.30625 y=0.340625> user=#<Hashie::Mash full_name="Keisuke Kita" id="20804929" profile_picture="https://instagramimages-a.akamaihd.net/profiles/profile_20804929_75sq_1333510808.jpg" username="kitak2501">>]>, ... 
```

### tag\_search

入力した文字列に一致、あるいは文字列から始まるタグのリストを返す...みたいなんだけど、どうも精度がよく分からない。
以下のように、`x100`という文字列だと一個しか返ってこないのに、`x100t`を入れるとやたら見つかる。

```rb
client.tag_search('x100')
=> [#<Hashie::Mash media_count=63689 name="x100">]
client.tag_search('x100t')
=> [#<Hashie::Mash media_count=1928 name="x100t">, #<Hashie::Mash media_count=3 name="x100tblack">, #<Hashie::Mash media_count=3 name="x100trillion">, #<Hashie::Mash media_count=2 name="x100times">, #<Hashie::Mash media_count=2 name="x100tcl">, #<Hashie::Mash media_count=2 name="x100tb">, #<Hashie::Mash media_count=2 name="x100to">, #<Hashie::Mash media_count=1 name="x100them">, #<Hashie::Mash media_count=1 name="x100tickets">, #<Hashie::Mash media_count=1 name="x100time">, #<Hashie::Mash media_count=1 name="x100tirin">, #<Hashie::Mash media_count=1 name="x100together">, #<Hashie::Mash media_count=1 name="x100tomorrow">, #<Hashie::Mash media_count=1 name="x100typ">, #<Hashie::Mash media_count=1 name="x100teacups">, #<Hashie::Mash media_count=1 name="x100tealentare">, #<Hashie::Mash media_count=1 name="x100teamo">, #<Hashie::Mash media_count=1 name="x100tech">, #<Hashie::Mash media_count=1 name="x100terecordare">, #<Hashie::Mash media_count=1 name="x100thailand">]
```

## 終わりに

Jekyllのプラグインとしてinstagramを扱おうと思って、あれこれ触った内容をメモしてきた。
oembedデータさえあれば、僕にとって欲しい情報は得られることが分かったので、概ね満足。
ただやはり、アクセストークンの取得が結構めんどくさいと思う。

[^1]: http://oembed.com/
[^2]: https://github.com/Instagram/instagram-ruby-gem/blob/master/lib/instagram/client/users.rb#L20
