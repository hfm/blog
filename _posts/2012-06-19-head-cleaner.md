---
layout: post
title: 'Head Cleaner : WordPress Plugin'
categories:
- Dev
- Just Memo
- Review
tags:
- Plugin
- Wordpress
status: publish
type: post
published: true
meta:
  _jd_tweet_this: ''
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/MmTlKq
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/dev/head-cleaner/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: 'a:1:{i:0;s:137:"【ブログ編集】 Head Cleaner : WordPress Plugin http://bit.ly/MmTlKq
    - WordPressに入れているプラグインリストより。";}'
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '1309'
  _aioseop_keywords: Wordpress,Plugin,Memo,プラグイン,
  _aioseop_description: Head Cleaner はブログページにおける HTML / CSS / JavaScript コードの無駄を削減し、コードを最適化してくれるプラグインです。
  _aioseop_title: 'Head Cleaner : WordPress Plugin'
  dsq_thread_id: '1227213817'
---
<h3><a title="WordPressに入れているプラグインリスト" href="http://blog.hifumi.info/plugin-for-wordpress/">WordPressに入れているプラグインリスト</a>より。</h3>
[caption id="attachment_1309" align="aligncenter" width="300"]<a title="pluginSettingPanel" href="http://blog.hifumi.info/wp-content/uploads/2012/06/pluginSettingPanel.png"><img class="size-medium wp-image-1309" title="pluginSettingPanel" src="http://blog.hifumi.info/wp-content/uploads/2012/06/pluginSettingPanel-300x126.png" alt="" width="300" height="126" /></a> プラグイン設定画面[/caption]

Head Cleaner はブログページにおける HTML / CSS / JavaScript コードの無駄を削減し、コードを最適化してくれるプラグインです。

なお、このブログではHead Cleanerの<strong>パラノイアモード</strong>を用いているので、ソースコードを見てもらうと一目瞭然ですが、空白や改行が削減されたゴッチャゴチャのコードになってるはずです。ただし、それはあくまで表示には影響しない範囲での削減なので、ウェブページの見た目に影響はありません。つまりは、このブログのソースコードが示すようなことも含めた、数種のスリム化を一手に担うプラグインです。

<!--more-->

具体的には以下の様な設定項目があります。
<h2>CSS と JavaScript を、サーバ上にキャッシュする</h2>
サーバ上に生成されるCSSとJavaScriptをキャッシュしておくことで、負荷を減らします。
<h2>CSS, JS を動的生成する</h2>
これ、何のことがはじめは分からなかったんですが、どうやら<a title="WordPressが早くなるプラグイン Head Cleaner" href="http://bit.ly/Nq1uOv" target="_blank">ここ</a>によるとHead Cleanerがサーバ上にキャッシュしたCSS, JavaScriptをgzip圧縮して、かつ有効期限を設定することでファイルサイズの縮減を図るもののようです。おそらく。
<h2>CSS に適用するデフォルト media 属性</h2>
CSSを圧縮したり動的生成したりすると、CSS記法の影響でレイアウトが崩れてしまうことがあるのですが、このmedia属性に適切な名前を入れることでレイアウト崩れを阻止するようです。

通常はいじらなくてもデフォルト値を使えば大丈夫でしょう。
<h2>複数の CSS を結合する</h2>
CSSファイルが大量にあると読み込みに時間が掛かるので、出来る限り一つのファイルにまとめて管理することで、読み込み時間の短縮を図ります。
<h2>CSS を最適化する</h2>
<a title="jquery.min.js" href="http://code.jquery.com/jquery-1.7.2.min.js" target="_blank">jquery.min.js</a>的な、余計な空白や改行を一切省いたコンパクトモードなCSSを生成します。
<h2>CSS に含まれる画像の URL を、データスキーマ URI に変換する</h2>
データURIスキームについては<a title="データURIスキーム | MOL" href="http://t32k.me/mol/log/data-uri-scheme/" target="_blank">こちら</a>をどうぞ。

要は、データURIスキームで長大化する代わりにテキスト化させて、そこにgzip圧縮を加えることで結果的に容量の削減を狙う、的なことでしょうか。よくわからないまま使っています。
<h2>複数の JavaScript を結合する</h2>
「複数のCSSを結合する」をJavaScriptでも実現します。
<h2>JavaScript を小さくする</h2>
<a title="jquery.min.js" href="http://code.jquery.com/jquery-1.7.2.min.js" target="_blank">jquery.min.js</a>的な、余計な空白や改行を一切省いたコンパクトモードなJavaScriptを生成します。「CSS を最適化する」とほぼ同じ挙動です。
<h2>フッタ領域の JavaScript も対象にする</h2>
プラグインによってはフッタ領域にJavaScriptを書いていたりするので、Head Cleanerの対象範囲をフッタにまで広げます。
<h2>&lt;head&gt; 内の JavaScript を、フッタ領域に移動</h2>
ウェブページというのは上から順に読み込んでいくので、HTMLファイル上部にJavaScriptが書いてあると、JavaScriptの読み込みからスタートします。ものによっては重くなることがあるので、余計なものをフッタ領域に移動してしまうことで、ウェブページの表示速度を向上させます。
<h2>Google Ajax Libraries を利用する</h2>
Contents Delivery Network(CDN)として、一部のライブラリにGoogle Ajax Librariesを使用します。
<blockquote>
<p style="text-align: left;">コンテンツデリバリネットワーク(Contents Delivery Network, CDN)とは、Webコンテンツをインターネット経由で配信するために最適化されたネットワークのことである。コンテンツ配信網とも。</p>
<p style="text-align: right;"><a title="コンテンツデリバリネットワーク" href="http://bit.ly/LEnbYO" target="_blank">WikiPedia : コンテンツデリバリネットワーク</a>より</p>
</blockquote>
他の場所から引っ張ってくるよりも、GAJから引っ張ってくるようが高速DLが可能で汎用性高いんじゃない？というスタンスということでしょうか。Googleが遅いと道連れですが、このあたりの速度差はよくわかっていません。おそらく速いのだとも思います。
<h2>XML宣言を付与</h2>
メタタグとしてXML宣言を正しく付与して検索対象に引っかかるようにしてくれるらしいですが、テーマ編集から直接書き込めば済む話でもあるので、知っているならチェックする必要はないでしょう。テーマ編集とかしたことない方はチェックするといいかも。
<h2>メタタグ "canonical" を追加</h2>
canonicalについては<a title="rel=&quot;canonical&quot; 属性について - ウェブマスター ツール ヘルプ" href="http://support.google.com/webmasters/bin/answer.py?hl=ja&amp;answer=139394" target="_blank">Googleサポートにあるこちら</a>が詳しいです。動画は以下のとおり。

http://www.youtube.com/watch?v=Cm9onOGTgeM

要するに「俺がこのページの主役アドレスだ！」と主張させるメタタグです。

http://blog.hifumi.info/ も http://blog.hifumi.info/index.html も同じページを示しますが、canonical に http://blog.hifumi.info/ を設定しておくと、重複した場合の優先順位を指定できます。SEO対策です。
<h2>OGP(Open Graph Protocol) 対応のメタタグを追加</h2>
Facebook OGP対策として、OPGメタタグを自動で追加してくれます。これがあればほかのFacebook OGPプラグインが不要になるので、一石二鳥です。
<h2>OGP にセットするデフォルト画像 (URLを指定)</h2>
OGPに表示される画像のアドレスらしいんですが、特に何も設定しなくても問題ありません。ブログやサイトのロゴがあるなら、そのアドレスを入力すればOKかと。
<h2>og:locale</h2>
Facebook OGPのロケール設定えす。<strong> ja_JP</strong>と書けばいいと思います。
<h2>fb:admins / fb:app_id</h2>
Facebook OGP対策のひとつで、admins / app_idを突っ込みます。これを入れておくと<a title="Insights doc page" href="https://developers.facebook.com/docs/insights/" target="_blank">Facebook Insights</a><span style="font-size: 10px;">（何回「いいね！」を押されたかがわかるFacebookのいいね！アクセス解析）</span>が有効に働きます。
<h2>メタタグ "generator" を削除</h2>
通常、Wordpressはgeneratorというメタタグを生成して、「このサイトはWordpress製ですよ」というアピールをします。ハッキリ言って余計なタグなので、削除してしまうに越したことはありません。
<h2>リンクタグ "RSD" を削除</h2>
いまいちこのRSDというリンクタグが分かっていなかったのですが、ぐぐったところ、外部編集用のアドレス指定だとかどうとか…まあ、基本的にWordpress上で更新するので不要かな？
<h2>リンクタグ "wlwmanifest" を削除.</h2>
何のマニフェストかと思ったら、wlwとはWindows Live Writerの略称だそうで、まあ要らない（笑）のでチェックしておくといいと思います。
<h2>IEコンディショナルタグを削除</h2>
特定のIEバージョンにのみ反映されるコメントタグというものがあるのですが、IEと無縁な方にとっては、表示されないくせにコードの中に埋まっている邪魔者でしかないので、サクッと消してしまいます。
<h2>メタタグ "Last Modified" を追加</h2>
最終更新日を示すメタタグを追加します。ブログなら毎回更新していれば特に要らない気もしますが、SEO最適化としては必要？（僕は使ってません）
<h2>"パラノイアモード" を有効にする。</h2>
ソースコードから中のHTML/CSS/JavaScriptから余計な部分を削減します。

通常、プラグラムはプラグラマ自身が理解できるように、インデントや空白をコードの多所に用います。インタプリタとかコンパイルとか言い出すとアレですのでここは割愛。しかしこれはウェブページを表示する際には全く無駄な部分であり、しかしユーザはそんな無駄な空白文字すらもとりあえずは読み込んでしまいます。塵も積もればなんとやら、意外とこのゴミ部分を読み込むことはササヤカではありますが遅延に繋がる、と考えることもできます。

例えばかの有名な<a title="jQuery" href="http://jquery.com/" target="_blank">jQuery</a>は実運用のPRODUCTIONバージョンとデベロッパ向けのDEVELOPMENTバージョンとを用意しています。両者のファイルサイズは10倍とまではいかないにしても、桁が変わるほどファイルサイズが変わっています。（ブログ執筆当時で32KBと247KBの差です）

参考
<ul>
	<li><a title="Head Cleaner" href="http://wordpress.org/extend/plugins/head-cleaner/" target="_blank">Head Cleaner</a></li>
</ul>
