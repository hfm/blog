---
layout: post
title: '#hbstudy 45 に参加してきました。'
categories:
- Dev
- Review
tags:
- Diary
- Pepabo
- serverspec
- study meeting
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: ペパボ, 日記, Pepabo, paperboy&co., serverspec, hbstudy, ruby
  _aioseop_description: "インフラエンジニアの勉強会であるhbstudyの第45回に参加した時の備忘録です。\r\nスピーカーはpaperboy&co.のテクニカルマネージャーの宮下剛輔さんで、テーマは「serverspecが拓いたサーバテストの世界」です。"
  _aioseop_title: '#hbstudy 45 に参加してきました。'
  _oembed_841a919f48887a8d41e5cc60da981b1f: <blockquote class="twitter-tweet" width="500"><p><a
    href="https://twitter.com/studio3104">@studio3104</a> まさにそれです。system rubyを考慮。</p>&mdash;
    Gosuke Miyashita (@gosukenator) <a href="https://twitter.com/gosukenator/statuses/348273825525415938">June
    22, 2013</a></blockquote><script async src="//platform.twitter.com/widgets.js"
    charset="utf-8"></script>
---
遅ばせながら備忘録になります。既にserverspecを知っている方にとっては当たり前すぎることしか書けてないです。すみません。
<h1>hbstudy</h1>
hbstudyは、<a title="株式会社ハートビーツ" href="http://heartbeats.jp" target="_blank">株式会社ハートビーツ</a>が主催するインフラエンジニアリングの勉強会です。

<!--more-->
<blockquote>インフラエンジニア勉強会hbstudy | 株式会社ハートビーツ
<p style="text-align: right;"><a href="http://heartbeats.jp/hbstudy/" target="_blank">http://heartbeats.jp/hbstudy/</a></p>
</blockquote>
2013年6月21日(金)に開催された第45回のテーマは「serverspecが拓いたサーバテストの世界」 でした。スピーカーは、ペパボのテクニカルマネージャーであり、私が今受けているペパボエンジニア研修でもお世話になっているmizzyさん（宮下剛輔さん）です。

[slideshare id=23291087&amp;doc=serverspec-hbstudy45-130621125223-phpapp01&amp;w=514&amp;h=422]

<a href="http://mizzy.org/" target="_blank">http://mizzy.org/</a>
<a href="https://github.com/mizzy/" target="_blank">https://github.com/mizzy/</a>
<h1>serverspec</h1>
serverspecとは、mizzyさんが中心となって開発されているサーバのテストを行うRuby製のツールです。
<pre class="lang:default decode:true">gem install serverspec</pre>
<ul>
	<li>「Webサーバはちゃんと動いているだろうか？」</li>
	<li>「そもそもちゃんとインストール成功してるだろうか？」</li>
	<li>「listenポート80番はちゃんと開いてるだろうか？」</li>
</ul>
サーバ構築におけるチェック項目を、RSpecに倣った読みやすい（わかりやすい）記法でシンプルに書けます。ローカル環境でのテストとSSH経由でのリモート環境でのテストが可能です。
{% highlight ruby %}
serverspec_sample_spec.rb
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port('80') do
  it { should be_listening }
end
{% endhighlight %}
Webサーバに限らず、userの情報やファイル・ディレクトリの有無なども細かくチェックすることが可能です。より詳しい動作に関しては、上記の発表資料や公式Webサイト、GitHubリポジトリをご覧ください。

<a href="http://serverspec.org/" target="_blank">http://serverspec.org/
</a><a href="https://github.com/mizzy/serverspec" target="_blank">https://github.com/mizzy/serverspec</a>/

ちなみにserverspecはruby 1.8.7 (MacやFreeBSD等の標準バージョン等) でも動くようです。

https://twitter.com/gosukenator/status/348273825525415938
<h1>simple design</h1>
mizzyさんの説明のなかでも特に印象に残ったのは「既存のツールでは機能が多すぎる」というところでした。

serverspecはとにかくシンプルな設計になっていて、ソースコードを覗くとすごくスッキリした内部構成になっていることが分かります。

僕なんかはここ１ヶ月のうちにようやくテストコードを書きだした未熟者なのですが、そんな人間でもサッと理解できるほど、serverspecのテストコードもまたシンプルです。

資料p.34-46でそのような哲学的な部分を述べられていて、僕はこの説明をされている時が深く印象に残りました。

serverspecにcontributeしていったら、そうしたmizzyさんの哲学の一端に触れられるのかもしれません…と思い、目下FreeBSDのserverspecを書き書きしています。

<a href="https://github.com/serverspec/serverspec/pull/161" target="_blank">https://github.com/mizzy/serverspec/pull/161</a>

まだテストが全然書けていないし、FreeBSDをDetectしただけでFreeBSD特有のコマンドに対応したわけでもないので、地道に続けていきます。
