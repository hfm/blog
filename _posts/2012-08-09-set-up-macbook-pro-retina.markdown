---
layout: post
title: MacBook Pro Retinaを購入した際に最低限やったことの覚書
categories:
- Just Memo
- Mac
tags:
- Mac
- MacBook Pro Retina
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: FontforgeとRictyの話を追記しました。 "MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD"
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/NptyyD
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/mac/set-up-macbook-pro-retina/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:9:{i:0;s:160:"【ブログ更新】 MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD
    - MacBook Pro RetinaをApple ローン（学";i:1;s:148:"【ブログ編集】 MacBook Pro Retinaを購入した際に最低限やったことの覚書
    http://bit.ly/NptyyD - MacBook Pro RetinaをApple ロ";i:2;s:202:"【ブログ追記】 MacBook
    Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD - MacBook Pro RetinaをApple ローン（学割）で購入してしまいました…";i:3;s:220:"【ブログまたちょっと追記】
    MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD - MacBook Pro RetinaをApple
    ローン（学割）で購入してしまいました…";i:4;s:226:"【ブログまたまたちょっと追記】 MacBook Pro Retinaを購入した際に最低限やったことの覚書
    http://bit.ly/NptyyD - MacBook Pro RetinaをApple ローン（学割）で購入してしまいました…";i:5;s:148:"【ブログ編集】
    MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD - MacBook Pro RetinaをApple
    ロ";i:6;s:115:"【ブログ更新】 MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD";i:7;s:115:"【ブログ追記】
    MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD";i:8;s:143:"FontforgeとRictyの話を追記しました。
    "MacBook Pro Retinaを購入した際に最低限やったことの覚書 http://bit.ly/NptyyD"";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '2367'
  _aioseop_keywords: Mac,MacBook Pro Retina
  _aioseop_description: MacBook Pro Retinaの初期状態からのセットアップのいろいろ。
  _aioseop_title: MacBook Pro Retinaを購入した際に最低限やったことの覚書
  dsq_thread_id: '1225032391'
---
[caption id="attachment_2367" align="aligncenter" width="500"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/retinatop.png"><img class="size-large wp-image-2367" title="retinatop" alt="" src="http://blog.hifumi.info/wp-content/uploads/2012/08/retinatop-500x312.png" width="500" height="312" /></a> スクリーンショットの解像度が半端ないです。[/caption]

MacBook Pro RetinaをApple ローン（学割）で購入してしまいました<sup><a title="Apple 学生ローンでMacBook Pro Retinaを注文した時の流れ" href="#ast1">※1</a>
</sup>

スペックは低めのやつで、メモリだけ16GMに変更しています。以下スペック詳細。
<table border="0"><caption>購入したMacBook Pro詳細</caption>
<tbody>
<tr>
<td>15インチMacBook Pro Retina</td>
<td>￥174,991（学割）</td>
</tr>
<tr>
<td>CPU</td>
<td>2.3GHzクアッドコアIntel Core i7
Turbo Boost使用時最大3.3GHz</td>
</tr>
<tr>
<td>メモリ</td>
<td>16GB 1,600MHz DDR3L SDRAM</td>
</tr>
<tr>
<td>ストレージ</td>
<td>256GBのフラッシュストレージ</td>
</tr>
<tr>
<td>オプション</td>
<td>バックライトキーボード (JIS) + 製品マニュアル
アクセサリキット</td>
</tr>
</tbody>
</table>
一点失態をあげると、僕は普段USキーボード+Dvorak配列であるにも関わらず、JISキーで注文してしまったこと…まあ、HHKでも購入してなんとかします。

さて、せっかく買ったMacですが、素のまま使うと開発にしろキーボード配列にしろ、色々使い勝手がよろしくありませんので、色々セットアップしていきましょう。

<!--more-->

目次
<ul>
	<li><a href="#init_setup">初期セットアップ</a></li>
	<li><a href="#modify_system">『システム環境設定』を変更する</a></li>
	<li><a href="#finder">Finder</a></li>
	<li><a href="#javax11">JavaとX11</a></li>
	<li><a href="#install_apps">アプリインストール</a></li>
	<li><a href="#safari">Safariの設定</a></li>
	<li><a href="#chrome">Chromeの設定</a></li>
	<li><a href="#migrate_itunes">iTunesを移行する</a></li>
	<li><a href="#migrate_iphoto">iPhotoを移行する</a></li>
	<li><a href="#xcode">Xcode</a></li>
	<li><a href="#homebrew">Homebrewの導入</a></li>
	<li><a href="#gcc">GCCの導入</a></li>
	<li><a href="#ruby19">Ruby 1.9.xの導入</a></li>
	<li><a href="#ricty">Rictyの導入</a></li>
</ul>
<h1><a name="init_setup"></a>初期セットアップ</h1>
<ol>
	<li>スイッチを入れる</li>
	<li>＼ｼﾞｬｰﾝ／</li>
	<li>Language→英語環境</li>
	<li>所在国→日本を選ぶ</li>
	<li>キーボード選択→Dvorak</li>
	<li>Wi-Fiネットワークでインターネットに接続する</li>
	<li>別のMacからの情報転送→Not Now</li>
	<li>位置情報サービスの利用→チェックを入れる</li>
	<li>Apple IDを入れる</li>
	<li>"Terms and Conditions"をAgreeする→もっかい聞かれるのでAgreeする</li>
	<li>iCloudの設定項目にチェックを入れる（入ってる）→Continueする</li>
	<li>Find My Macのサービスにチェックを入れる（入ってる）→Allowする</li>
	<li>アカウント作成画面へ</li>
	<li>タイムゾーン選択→"Tokyo - Japan"を選ぶ</li>
	<li>Registerボタンを押す</li>
	<li>Thank You → Start using your Mac</li>
</ol>
<h1><a name="modify_system"></a>『システム環境設定』を変更する</h1>
<h2>一般</h2>
<ul>
	<li><strong>「</strong>強調表示色<strong>」</strong>をゴールドにする（豪奢な色がすきなので・・・）</li>
</ul>
<h2>Dock</h2>
<ul>
	<li>「画面上の位置」を左にする（ワイドスクリーンなので縦幅は欲しい）</li>
	<li>「ウインドウのタイトルバーをダブルクリックしてウインドウをしまう」にチェックを入れる（Command-HやCommand-Mでもいいんですが・・・）</li>
	<li>「ウインドウをアプリケーションアイコンにしまう」にチェックを入れる（Dockの表示アイコン数は少ないほうが好き）</li>
	<li>「Dock を自動的に隠す／表示」にチェックを入れる（普段は引っ込んでてほしい）</li>
</ul>
<h2>Mission Control</h2>
<ul>
	<li>「Dashboard を操作スペースとして表示」のチェックを外す（Dashboardを使わないため）</li>
</ul>
<h2>言語とテキスト</h2>
<ul>
	<li>《入力ソースタブ》の以下２つにチェックを入れる
<ul>
	<li>Google 日本語入力のひらがな（ネットから取ってくる）</li>
	<li>Dvorak</li>
</ul>
</li>
</ul>
<h2>セキュリティとプライバシー</h2>
<ul>
	<li>《一般》タブ
<ul>
	<li>「スリープ解除／スクリーンセーバ解除にパスワードを要求」のチェックを外す</li>
</ul>
</li>
	<li>《ファイアウォール》
<ul>
	<li>Firewallをオンにする</li>
</ul>
</li>
</ul>
<h2>Spotlight</h2>
<ul>
	<li>《検索結果》タブ
<ul>
	<li>「Spotlight メニューのキーボードショートカット」のチェックを外す（あとでAlfredを入れるので）</li>
</ul>
</li>
</ul>
<h2>通知</h2>
<ul>
	<li>「通知センターに共有ボタンを表示」にチェックを入れる（通知センターからツイートできるようにする）</li>
	<li>余計なアプリからの通知を向こうにする
<ul>
	<li>Twitter（夜フクロウが通知センターに対応しているため不要になった）</li>
	<li>Xcode（ビルド成功時に通知されるだけでなんの意味もなく不要になった）</li>
</ul>
</li>
</ul>
[caption id="attachment_3448" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/modify_notification_center.png"><img class="size-medium wp-image-3448" alt="通知センターの修正" src="http://blog.hifumi.info/wp-content/uploads/2012/08/modify_notification_center-400x302.png" width="400" height="302" /></a> 通知センターの修正[/caption]
<h2>ディスプレイ</h2>
<ul>
	<li>《ディスプレイ》タブ
<ul>
	<li>解像度にて、「スペースを拡大」に設定する（「Retina ディスプレイに最適」はテキストが半端なく読みやすいんだけど、画像が汚い）</li>
</ul>
</li>
</ul>
<h2>キーボード</h2>
<ul>
	<li>《キーボード》タブ
<ul>
	<li>「キーのリピート」を「速い」にする</li>
	<li>「リピート認識までの時間」を「短い」にする（この２項は、どうせ後でKeyRemap4MacBookで変えてしまいますが・・・）</li>
	<li>「F1、F2 などのすべてのキーを標準のファンクションキーとして使用」にチェックを入れる（特殊機能はトラックパッドの操作で十分）</li>
	<li>「修飾キー」ボタンを押す→Caps Lock (⇧)キーをCommand (⌘) キーにする。（Caps Lock消滅）</li>
</ul>
</li>
	<li>《キーボードショートカット》タブ
<ul>
	<li>フルキーボードアクセスを「すべてのコントロール」に切り替える（タブキーで全部選択できるようにする）</li>
</ul>
</li>
</ul>
<h2>トラックパッド</h2>
次の項目にチェックを入れる（既に入ってるのもある）
<ul>
	<li>《ポイントとクリック》タブ
<ul>
	<li>タップでクリック</li>
	<li>副ボタンのクリック（2 本指でクリックまたはタップ）</li>
	<li>調べる</li>
</ul>
</li>
	<li>《スクロールとズーム》タブ
<ul>
	<li>スクロールの方向：ナチュラル</li>
	<li>拡大／縮小</li>
	<li>スマートズーム</li>
	<li>回転</li>
</ul>
</li>
	<li>その他のジェスチャ
<ul>
	<li>ページ間をスワイプ（2 本指で左右にスクロール）</li>
	<li>フルスクリーンアプリケーション間をスワイプ（4 本指で左右にスワイプ）</li>
	<li>通知センター</li>
	<li>Mission Control（4 本指で下にスワイプ）</li>
	<li>アプリケーション Exposé（4 本指で下にスワイプ）</li>
	<li>Launchpad</li>
	<li>デスクトップ表示</li>
</ul>
</li>
</ul>
<h2>iCloud</h2>
<ul>
	<li>Contact以外すべてチェック入れる（連絡帳はGmail使ってるので）</li>
</ul>
<h2>メール/連絡先/カレンダー</h2>
<ul>
	<li>GmailアカウントとTwitterアカウントを追加する</li>
</ul>
<h2>ユーザとグループ</h2>
<ul>
	<li>《ゲストユーザ》
<ul>
	<li>「ゲストにこのコンピュータへのログインを許可」のチェックを外す</li>
</ul>
</li>
	<li>《ログインオプション》
<ul>
	<li>「自動ログイン」を自アカウントに設定する</li>
	<li>「ログインウインドウに入力メニューを表示」にチェックを入れる</li>
	<li>「パスワードのヒントを表示」にチェックを入れる</li>
</ul>
</li>
</ul>
<h2>日付と時刻</h2>
<ul>
	<li>《時間帯》タブ
<ul>
	<li>「現在の位置情報に基づいて、時間帯を自動的に設定」にチェックを入れる</li>
</ul>
</li>
</ul>
<h2>ソフトウェアアップデート</h2>
「今すぐ確認」を押す→App Store起動→アップデートする→再起動
<h1><a name="finder"></a>Finder</h1>
<ul>
	<li>サイドバーにホームディレクトリ、自デバイスを表示するように設定する</li>
	<li>拡張子を表示させる</li>
</ul>
<h1><a name="javax11"></a>JavaとX11</h1>
[caption id="attachment_2368" align="alignleft" width="150"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/java-e1344534586268.png"><img class="size-thumbnail wp-image-2368" alt="Javaインストール画面" src="http://blog.hifumi.info/wp-content/uploads/2012/08/java-150x150.png" width="150" height="150" /></a> Javaインストール画面[/caption]
<h2>Java</h2>
Mountain Lionの初期状態にはJAVAとX11が入っていないのでインストールします。
<p class="clearfix">JAVAはインストールボタンを押せば完了。</p>


[caption id="attachment_3556" align="alignleft" width="200"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/xquartz.png"><img class="size-thumbnail wp-image-3556" alt="XQuartzのインストール" src="http://blog.hifumi.info/wp-content/uploads/2012/08/xquartz-200x200.png" width="200" height="200" /></a> XQuartzのインストール[/caption]
<h2>X11 (XQuartz)</h2>
<p class="clearfix">Mountain LionはX11の代わりにXQuartzを使用。<a href="http://xquartz.macosforge.org/landing/" target="_blank">こちらのダウンロードページ</a>からXQuartz-***.dmgを入手してインストール。</p>

<h1><a name="install_apps"></a>アプリインストール</h1>
<h2>App Storeから</h2>
<table border="0">
<tbody>
<tr>
<th colspan="5" align="center" valign="middle"><strong>App Storeから</strong></th>
</tr>
<tr>
<td>Xcode</td>
<td>Evernote</td>
<td>MPlayerX</td>
<td>The Unarchiver</td>
<td>Day One</td>
</tr>
<tr>
<td>iAntivirus</td>
<td>CheatSheet</td>
<td>Coda</td>
<td>Caffeinated</td>
<td>Classic Color Meter</td>
</tr>
<tr>
<td>Source Tree</td>
<td>Pixelmator</td>
<td>Minutes</td>
<td>GeekTool</td>
<td>Skitch</td>
</tr>
<tr>
<td>Caffeine</td>
<td>Opera</td>
<td>iDraw</td>
<td>Alfred</td>
<td>WinArchiver Lite</td>
</tr>
<tr>
<th colspan="5" align="center" valign="middle">その他ネットから落としてきたアプリ</th>
</tr>
<tr>
<td>YoruFukurou</td>
<td>Flash Player</td>
<td>Chrome</td>
<td>FireFox</td>
<td>Opera</td>
</tr>
<tr>
<td>Homebrew</td>
<td>Google IME beta</td>
<td>Text Expander</td>
<td>MacTeX</td>
<td>CotEditor</td>
</tr>
<tr>
<td>Sublime Text 2</td>
<td>Onyx</td>
<td>Xmarks for Safari</td>
<td>Better Touch Tool</td>
<td>TotalFinder</td>
</tr>
<tr>
<td>TotalTerminal</td>
<td>Flip4Mac</td>
<td>VirtualBox</td>
<td>SkyDrive</td>
<td></td>
</tr>
<tr>
<th colspan="5" align="center" valign="middle">ディスクインストールしたもの</th>
</tr>
<tr>
<td>iWorks</td>
<td>Microsoft Office</td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>
[caption id="" align="alignright" width="160"]<a href="http://www.amazon.co.jp/gp/product/B008DFO6KE/ref=as_li_ss_il?ie=UTF8&amp;camp=247&amp;creative=7399&amp;creativeASIN=B008DFO6KE&amp;linkCode=as2&amp;tag=hifumiass-22"><img style="border: 0px;" title="Apple USB Super Drive" alt="Apple USB Super Drive" src="http://ws.assoc-amazon.jp/widgets/q?_encoding=UTF8&amp;ASIN=B008DFO6KE&amp;Format=_SL160_&amp;ID=AsinImage&amp;MarketPlace=JP&amp;ServiceVersion=20070822&amp;WS=1&amp;tag=hifumiass-22" width="160" height="160" border="0" /></a> <img style="border: none !important; margin: 0px !important; padding: 0px !important;" alt="" src="http://www.assoc-amazon.jp/e/ir?t=hifumiass-22&amp;l=as2&amp;o=9&amp;a=B008DFO6KE" width="1" height="1" border="0" />Apple USB Super Drive<br />アップ[/caption]

なお、MacBook Pro Retinaでは光学ドライブが廃止されたため、Apple USB Super Drive経由でインストール。

8000円近くするので、純正じゃなくても動くものはおそらくあると思いますので、Amazonのレビュー等を参考に。
<h1><a name="safari"></a>Safariの設定</h1>
基本は<a title="Safari 6に入れてる拡張機能" href="http://blog.hifumi.info/non-classified/safari-extensions/">ここの拡張機能</a>つっこんで、あとLastpass入れてる関係でSafariの自動入力をオフにした。
<h1><a name="chrome"></a>Chromeの設定</h1>
基本は<a title="Google Chromeに入れてる拡張機能" href="http://blog.hifumi.info/non-classified/chrome-extensiens/">ここの拡張機能</a>つっこんで、あとはChromeのシンク機能を使った。XmarksとLastpassの関係で自動入力、パスワード、ブクマの共有だけ解除。
<h1><a name="migrate_itunes"></a>iTunesを移行する</h1>
とは言ったものの、実はぼくのiTunes及びiPhoto環境というのは、AirMac ExtremeにポータブルHDDをつないでNAS的な扱いにしており、早い話がネットワーク上に共有ライブラリを置いているので、移行せずともMacBook Pro RetinaのiTunesのライブラリ先を指定しなおせばいい。

option⌥キーを押しながらiTunesを起動する。

[caption id="attachment_3447" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/choose_itunes_library.png"><img class="size-medium wp-image-3447" alt="option⌥キーを押したままiTunesを起動する" src="http://blog.hifumi.info/wp-content/uploads/2012/08/choose_itunes_library-400x120.png" width="400" height="120" /></a> option⌥キーを押したままiTunesを起動する[/caption]

ここで<em>Choose Library...</em>をクリックし、ネットワーク上に用意されてあるiTunesライブラリを指定すれば移行完了。あらかじめ外部HDDにライブラリを移しておくことで、iPhoneなどのモバイル機器の設定や音楽、映画などの情報も綺麗に移行できる。
<p style="text-align: left;">[amazon asin=B0057D4OQG,B001HAMNSY&amp;template=wishlist&amp;chan=default]</p>

<h1><a name="migrate_iphoto"></a>iPhotoを移行する</h1>
iTunesと同じ状況だったので、
<ol>
	<li>optionキーを押しながらiPhotoを起動</li>
	<li>Other Library...を押す</li>
	<li>ネットワーク上のiPhoto Libraryを選択</li>
</ol>
で移行完了。

[caption id="attachment_3446" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/switch_iPhoto_library.png"><img class="size-medium wp-image-3446" alt="option⌥キーを押しながらiPhotoを起動する" src="http://blog.hifumi.info/wp-content/uploads/2012/08/switch_iPhoto_library-400x262.png" width="400" height="262" /></a> option⌥キーを押しながらiPhotoを起動する[/caption]

iPhotoに関しては、Retinaディスプレイの影響もあり、iPhoto上のサムネイル画像をアップデートする必要があった。

[caption id="attachment_2387" align="aligncenter" width="600"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/Screen-Shot-2012-08-10-at-10.21.55-AM.png"><img class="size-large wp-image-2387" title="Retina用のサムネイル画像を生成する" alt="" src="http://blog.hifumi.info/wp-content/uploads/2012/08/Screen-Shot-2012-08-10-at-10.21.55-AM-600x294.png" width="600" height="294" /></a> Retina用のサムネイル画像を生成する[/caption]

OKを押すと、iPhotoが起動して、そのままサムネイル更新に入る。しばらく待つ。
<h1><a name="xcode"></a>Xcode</h1>
Xcodeの設定からCommand Line Toolsをインストールする。

[caption id="attachment_3437" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2011/10/commandlinetools_in_xcode.png"><img class="size-medium wp-image-3437" alt="Xcodeの設定画面からCommand Line Toolsのインストールを行う" src="http://blog.hifumi.info/wp-content/uploads/2011/10/commandlinetools_in_xcode-400x292.png" width="400" height="292" /></a> Xcodeの設定画面からCommand Line Toolsのインストールを行う[/caption]

次にFonts &amp; Colorsへ。エディタの背景は黒いほうが好みなので、Midnightに変更し、かつフォントを<a href="#ricty">Ricty</a>に変更します（Rictyの入手に関しては後述）。

[caption id="attachment_3442" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/set_xcode_font.png"><img class="size-medium wp-image-3442" alt="⌘Aで全選択してフォントを一括設定すると楽です" src="http://blog.hifumi.info/wp-content/uploads/2012/08/set_xcode_font-400x292.png" width="400" height="292" /></a> ⌘Aで全選択してフォントを一括設定すると楽です[/caption]

あとキーバインドの中から自動補完（Show Completions）のキーを変更します。自動補完の標準コマンドは^Spaceですが、Dvorakキー配列では使いにくいのでControl + , (カンマ)に変更しています。

[caption id="attachment_3443" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/08/set_xcode_keybind.png"><img class="size-medium wp-image-3443" alt="自動補完はControl-Spaceがデフォですが、Dvorakでは使いにくいのでControl+, (カンマ)に変更しています" src="http://blog.hifumi.info/wp-content/uploads/2012/08/set_xcode_keybind-400x292.png" width="400" height="292" /></a> 自動補完はControl-Spaceがデフォですが、Dvorakでは使いにくいのでControl+,に変更しています[/caption]

&nbsp;
<h1><a name="homebrew"></a>Homebrewの導入</h1>
詳しい用法は稚拙ながら『<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/">Mac デ Homebrew ノススメ</a>』をご参照。インストール自体は以下のコマンドをターミナルに打つだけ。
<pre class="lang:default decode:true">$ ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"</pre>
インストールコマンド自体がバージョンアップされることもあるので、うまくいかなかったら<a title="Homebrew" href="http://mxcl.github.com/homebrew/" target="_blank">Homebrew公式ウェブサイト</a>をチェック。
<h1><a name="gcc"></a>GCCの導入</h1>
Lion（正確にはXcode4以降）のMacには、かつては入っていたGCCがなくなり、それに代わって、ある程度互換性のあるllvm-gccとclangだけに。とはいえ稀に野良ビルドすることもあり、その時にgccじゃないと動かないものがあったりするので、念の為にgccをインストールしておく。
<h2>GCCのインストール</h2>
Homebrewにgcc4.x(2012.9.6現在では4.7)があるので、そちらから入れればok。
<pre>$ brew install gcc</pre>
ただし、ターミナルからls -l /usr/bin/gccとかls -l /usr/bin/c++とかすると分かるが、clangとかllvm-gccにシンボリックリンクが貼られているので、このままだと使いにくいので、ちょっぴりアグレッシブにシンボリックリンクの貼替えをしてしまう。
<h2>システムのCコンパイラとの置き換え</h2>
ちなみにXcode4以降のgccやらc++やらのシンボリックリンクは以下の様な状況。
<pre class="lang:default decode:true">lrwxr-xr-x root wheel 12B /usr/bin/gcc -&gt; llvm-gcc-4.2
lrwxr-xr-x root wheel 12B /usr/bin/g++ -&gt; llvm-g++-4.2
lrwxr-xr-x root wheel  5B /usr/bin/cc  -&gt; clang
lrwxr-xr-x root wheel  7B /usr/bin/c++ -&gt; clang++</pre>
ものの見事にllvmとclangに置き換わっている。これをHomebrewから導入したgccに置き換えるには、以下のようにシンボリックリンクを貼り直す（怖い人は使わないほうがいい）。
<pre>$ sudo ln -sf /usr/local/bin/gcc-4.7 /usr/bin/gcc
$ sudo ln -sf /usr/local/bin/g++-4.7 /usr/bin/g++ 
$ sudo ln -sf /usr/local/bin/g++-4.7 /usr/bin/c++
$ sudo ln -sf /usr/local/bin/g++-4.7 /usr/bin/cc</pre>
なお、こんなことをして置き換えなくてもg++-4.7という、標準のコンパイラと衝突しないように配慮された状態でインストールされるため、無理してlnで置き換える必要もないかもしれない。
<h1><a name="ruby19"></a>Ruby 1.9.xの導入</h1>
Homebrewからrbenvとruby-buildを入れて、既存の1.8系と併存させます。
<pre class="lang:default decode:true">$ brew install ruby-build rbenv
$ rbenv-install 1.9.3-p374
$ rbenv rehash
$ rbenv global 1.9.3-p374</pre>
私はZshを利用しているので、Zsh × rbenv用の設定を.zshrcに書きます。
<pre class="lang:default decode:true">$ vi .zshrc
# rbenv(Rubyのバージョン管理)の環境変数
export PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims

# rbenv初期化用スクリプト
if which rbenv &gt; /dev/null; then
    eval "$(rbenv init - zsh)"
    source `brew --prefix rbenv`/completions/rbenv.zsh;
fi</pre>
これでruby 1.8系と1.9系を両方使えるようになります。
<h1><a name="ricty"></a>Rictyの導入</h1>
プログラミング用フォントとしてRictyを愛用。Rictyについては<a title="プログラミング用フォント Ricty" href="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html" target="_blank">プログラミング用フォント Ricty</a>を参照。
<h2>FontForgeのインストール</h2>
Xcode4.4のディレクトリ構成変更の影響でfontforgeがインストール出来ない問題がありましたが、調べたところ、以下の様な解決方法を発見。
<blockquote>brew install fontforge error
<p style="text-align: right;"><a href="https://github.com/mxcl/homebrew/issues/14252" target="_blank">https://github.com/mxcl/homebrew/issues/14252</a></p>
</blockquote>
まずローカルのフォーミュラに入っているfontforge.rbを削除して、HomebrewのHEADからfontforge.rbをとってくる。
<pre class="lang:default decode:true" title="Xcode4.4以降のFontforgeのインストールエラー対処方法">$ rm /usr/local/Library/Formula/fontforge.rb
$ brew install https://raw.github.com/codeman38/homebrew/fontforge-20120731/Library/Formula/fontforge.rb</pre>
当面はこれで何とか。
<h2>Rictyに必要なフォントの用意</h2>
fontforgeをインストールしたら、あとは<a href="http://levien.com/type/myfonts/inconsolata.html" target="_blank">InconsolataのOpenType file</a>と<a href="http://mix-mplus-ipa.sourceforge.jp/" target="_blank">M+ と IPA の合成フォントのMigu 1M</a>をインストールして、Ricty generatorをダウンロード。
<pre class="lang:default decode:true" title="GithubからRictyをクローンして、該当タグからチェックアウトする">$ git clone https://github.com/yascentur/Ricty.git
$ git checkout 3.2.0</pre>
<h2>Rictyフォントの生成</h2>
先述の２つのフォントをインストールしていれば、あとはRictyのあるディレクトリで、
<pre class="lang:default decode:true" title="Rictyの生成方法">$ cd hogehoge/Ricty
$ sh ricty_generator.sh auto</pre>
このようにシェルを実行すれば生成完了です。Rictyフォントをインストールして、Xcodeなどのデフォルトフォントにします。
<h1>参考</h1>
<ul>
	<li><sup><a name="ast1"></a>※1</sup><a title="Apple 学生ローンでMacBook Pro Retinaを注文した時の流れ" href="http://blog.hifumi.info/non-classified/apple-loan-for-education/">Apple 学生ローンでMacBook Pro Retinaを注文した時の流れ</a></li>
	<li><a title="sstephenson / rbenv - GitHub" href="https://github.com/sstephenson/rbenv" target="_blank">sstephenson / rbenv - GitHub</a></li>
	<li><a title="Rbenv Ruby-build Rbenv-gemsetのセットアップ - ksauzz weblog" href="http://ksauzz.github.com/blog/2012/03/23/rbenv-ruby-build-rbenv-gemset/" target="_blank">Rbenv Ruby-build Rbenv-gemsetのセットアップ - ksauzz weblog</a></li>
</ul>
