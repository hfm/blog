---
layout: post
title: お名前.comのWhois情報公開代行は設定しておきましょう
categories:
- Just Memo
- Non-classified
tags:
- Linux
- Privacy
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/KV541I
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/non-classified/onamaecom-whois/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:2:{i:0;s:115:"【ブログ更新】 お名前.comのWhois情報公開代行は設定しておきましょう http://bit.ly/KV541I";i:1;s:115:"【ブログ編集】
    お名前.comのWhois情報公開代行は設定しておきましょう http://bit.ly/KV541I";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _thumbnail_id: '1102'
  _revision-control: a:1:{i:0;s:5:"never";}
  _syntaxhighlighter_encoded: '1'
  _yoast_wpseo_metadesc: お名前.comのWhois情報公開代行を設定して、whoisコマンドで中身を覗かれないようにしましょう、という話です
  _yoast_wpseo_metakeywords: Linux,Mac
  _yoast_wpseo_title: お名前.comのWhois情報公開代行は設定しておきましょう
  _aioseop_keywords: whois,お名前ドットコム,お名前.com,Privacy,プライバシー,linux,個人情報
  _aioseop_description: お名前.comでは契約者の個人情報を保護するために、Whois情報公開代行というサービスがあります。このサービスはWHOISコマンドから引き出されるドメイン情報を、個人のものからお名前.comの運営母体であるGMOインターネット株式会社のものに置き換えてくれます。
  _aioseop_title: お名前.comのWhois情報公開代行は設定しておきましょう
  dsq_thread_id: '1225078473'
---
[caption id="attachment_1102" align="aligncenter" width="300"]<a title="Screen Shot 2012-05-14 at 17.37.45" href="http://blog.hifumi.info/wp-content/uploads/2012/05/Screen-Shot-2012-05-14-at-17.37.45-.png"><img class="size-medium wp-image-1102 " title="Screen Shot 2012-05-14 at 17.37.45" alt="" src="http://blog.hifumi.info/wp-content/uploads/2012/05/Screen-Shot-2012-05-14-at-17.37.45--300x271.png" width="300" height="271" /></a> whois host...[/caption]
<p style="text-align: justify;">わたしは"FreeBSDサーバ"（VPS）を『<a title="さくらVPS" href="http://vps.sakura.ad.jp/" target="_blank">さくらVPS</a>』から、"hifumi.info"というドメインを『<a title="お名前.com" href="https://www.onamae.com/" target="_blank">お名前.com</a>』からそれぞれレンタル契約しています。このブログのblog.hifumi.infoというアドレスもお名前.comからのサブドメインです。</p>
<p style="text-align: justify;">今回のお話はこのドメインに関するものになります。</p>
<p style="text-align: justify;"><!--more--></p>

<h1 style="background-color: #fcd9f0; text-align: justify; padding: 5px; margin: 0px;">WHOISコマンド</h1>
<p style="text-align: justify;">お名前.comからドメインをレンタルする際には、当然のことですが契約として個人情報を登録します。自分の電話番号や自宅の住所、名前など、漏れたらマズそうなものばかりです。</p>
<p style="text-align: justify;">ここでひとつ（大学のゼミでようやく意味を知ったコマンドなんですが…）<strong>WHOIS</strong>というコマンドを紹介します。MacやLinux/Unixには標準で付いているであろうコマンドです。WikiPediaから参照するに、</p>

<blockquote>
<p style="text-align: justify;"><strong>WHOIS</strong>（フーイズ）とは、インターネット上でのドメイン名・IPアドレス・Autonomous System (AS) 番号の所有者を検索するためのプロトコルである。データベース検索を用い、TCPベースでクエリ（質問）・レスポンス（応答）を行う。</p>
<p style="text-align: right;"><a title="WHOIS" href="http://ja.wikipedia.org/wiki/WHOIS" target="_blank">WikiPedia - WHOIS</a></p>
</blockquote>
<p style="text-align: justify;">とあります。どういうことかというと、先ほど申した個人等の情報を覗き見るコマンドです。こう書くと非常にいやらしい感じがしますが、誰が運営してるか分からないウェブサイトとか怖いですから、ドメインからドメイン所有者の情報を引き出すこのコマンドは必要な機能であります。</p>
<p style="text-align: justify;">試しにgoogle.co.jpにWHOISコマンドを使用してみると、</p>

<pre class="lang:default decode:true" title="whois google.co.jp">$ whois google.co.jp
[ JPRS database provides information on network administration. Its use is ]
[ restricted to network administration purposes. For further information, ]
[ use 'whois -h whois.jprs.jp help'. To suppress Japanese output, add'/e' ]
[ at the end of command, e.g. 'whois -h whois.jprs.jp xxx/e'. ]

Domain Information: [ドメイン情報]
a. [ドメイン名] GOOGLE.CO.JP
e. [そしきめい] ぐーぐるかぶしきかいしゃ
f. [組織名] グーグル株式会社
g. [Organization] Google Japan
k. [組織種別] 株式会社
l. [Organization Type] corporation
m. [登録担当者] DL152JP
n. [技術連絡担当者] TW184JP
p. [ネームサーバ] ns1.google.com
p. [ネームサーバ] ns2.google.com
p. [ネームサーバ] ns3.google.com
p. [ネームサーバ] ns4.google.com
s. [署名鍵]
[状態] Connected (2013/03/31)
[登録年月日] 2001/03/22
[接続年月日] 2001/03/22
[最終更新] 2012/04/01 01:20:39 (JST)</pre>
<p style="text-align: justify;">このような結果が出てきます。ちゃんと組織名として「ぐーぐるかぶしきがいしゃ」と日本語で出てきます。ネームサーバや登録担当者、組織種別などいろいろな情報が出てきます。</p>

<h1 style="background-color: #fcd9f0; text-align: justify; padding: 5px; margin: 0px;">Whois情報公開代行</h1>
<p style="text-align: justify;">さてここからが本題です。</p>
<p style="text-align: justify;">お名前.comからドメイン契約した時点では、実はこのWHOISから引き出される<strong>ドメイン情報＝ドメイン契約時の契約（個人）情報</strong>です。つまり、契約の際に登録した<span style="text-decoration: underline;"><strong>自分の住所、氏名、電話番号など、重要な個人情報が全て引き出せる</strong></span>ことになります。企業や組織ならまだしも、個人利用を目的として契約した場合、自分に関する情報がだだ漏れ状態になるのは非常にリスキーです。</p>
<p style="text-align: justify;">お名前.comではこうした個人契約者の個人情報を保護するために、<strong>Whois情報公開代行</strong>というサービスがあります。このサービスはWHOISコマンドから引き出されるドメイン情報を、個人のものからお名前.comの運営母体であるGMOインターネット株式会社のものに置き換えてくれます。</p>
<p style="text-align: justify;">やりかたは以下のとおり。</p>
<p style="text-align: justify;">まずお名前.com（ドメインNavi）へログインして、上部メニューバーより「ドメイン設定」のページへ遷移します。</p>


[caption id="attachment_1101" align="aligncenter" width="300"]<a title="whois" href="http://blog.hifumi.info/wp-content/uploads/2012/05/whois.png"><img class=" wp-image-1101" title="whois" alt="" src="http://blog.hifumi.info/wp-content/uploads/2012/05/whois-300x178.png" width="300" height="178" /></a> Whois情報公開代行[/caption]
<p style="text-align: justify;">上記の画像にたどり着いたら、黄色の線で囲まれている『<strong>Whois情報公開代行</strong>』を押して、あとは画面の指示に従って次ドメインを選択した後、『確認画面へ進む』と指示に順番に従っていきましょう。</p>
<p style="text-align: justify;">必要な作業は以上です。お名前.comからメールが届いた後、しばらくすればWhois情報公開代行が有効になります。</p>
<p style="text-align: justify;">実際に私の所持しているhifumi.infoにWHOISコマンドを試すと、</p>

<pre class="lang:default decode:true crayon-selected" title="whois hifumi.info">Access to INFO WHOIS information is provided to assist persons in
determining the contents of a domain name registration record in the
Afilias registry database. The data in this record is provided by
Afilias Limited for informational purposes only, and Afilias does not
guarantee its accuracy. This service is intended only for query-based
access. You agree that you will use this data only for lawful purposes
and that, under no circumstances will you use this data to: (a) allow,
enable, or otherwise support the transmission by e-mail, telephone, or
facsimile of mass unsolicited, commercial advertising or solicitations
to entities other than the data recipient's own existing customers; or
(b) enable high volume, automated, electronic processes that send
queries or data to the systems of Registry Operator, a Registrar, or
Afilias except as reasonably necessary to register domain names or
modify existing registrations. All rights reserved. Afilias reserves
the right to modify these terms at any time. By submitting this query,
you agree to abide by this policy.

Domain ID:D36786141-LRMS
Domain Name:HIFUMI.INFO
Created On:15-Feb-201101:50:15 UTC
Last Updated On:10-May-2012 19:14:44 UTC
Expiration Date:15-Feb-2013 01:50:15 UTC
Sponsoring Registrar:GMO Internet, Inc. d/b/a Onamae.com (R110-LRMS)
Status:OK
Registrant ID:12E2702BA3F
Registrant Name:Whois Privacy Protection Service by onamae.com
Registrant Organization:Whois Privacy Protection Service by onamae.com
Registrant Street1:26-1 Sakuragaoka-cho
Registrant Street2:Cerulean Tower 11F
Registrant Street3:
Registrant City:Shibuya-ku
Registrant State/Province:Tokyo
Registrant Postal Code:150-8512
Registrant Country:JP
Registrant Phone:+81.0303648727
Registrant Phone Ext.:
Registrant FAX:
Registrant FAX Ext.:
Registrant Email:proxy@whoisprotectservice.com
...</pre>
このように表示されます。全部英語ですが、ちゃんとGMO Internet, incの情報が表示されていると思います。

作業としてはお名前.comのWhois情報公開代行サービスを利用するという単純なものでしたが、あわや自分の個人情報がダダ漏れになっていたかと思うとゾッとしますね…。
