---
layout: post
title: Objective-C(Xcode)触ってて出くわしたエラーとその対処
categories:
- Dev
- Mac
tags:
- Debug
- Mac
- Xcode
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _wp_old_slug: objective-cxcode%e8%a7%a6%e3%81%a3%e3%81%a6%e3%81%a6%e5%87%ba%e3%81%8f%e3%82%8f%e3%81%97%e3%81%9f%e3%82%a8%e3%83%a9%e3%83%bc%e3%81%a8%e3%81%9d%e3%81%ae%e5%af%be%e5%87%a6
  _thumbnail_id: '3231'
  _aioseop_keywords: Mac,Xcode,Development,Debug,Error,エラー,デバッグ,開発
  _aioseop_description: 初歩的なものが多いのですが、初歩的なものほどちゃんとメモしておかないと、同じ事を繰り返すはめになりかねないので、Objective-C(Xcode)のエラーとその解決法をメモ。
  _aioseop_title: Objective-C(Xcode)触ってて出くわしたエラーとその対処
  dsq_thread_id: '1225764969'
---
Objective-C(Xcode)を触っていてバッタリ出会った細かなエラーとその解決策についてメモメモ。同じ事を繰り返さないためにも、初歩的なものほどちゃんとメモ。別名・情弱メモ。

非定期的に増えていく予定です。
<!--more-->
<h1>QuartsCore</h1>
<pre>ARC Semantic Issue
Receiver type 'CALayer' for instance message is a forward declaration
No known instance method for selector 'setCornerRadius:'</pre>
<img class="alignright" title="QuartzCoreフレームワーク" alt="QuartzCoreフレームワーク" src="http://i.minus.com/iEg3XBZl0t0EL.png" width="236" height="270" />UIView.layerから<code>setCornerRadius:</code>を呼びだそうとした時に生じたエラー。

解決策はStackOverflowの<a href="http://stackoverflow.com/questions/7813379/what-does-receiver-type-calayer-for-instance-message-is-a-forward-declaration" target="_blank">What does “Receiver type 'CALayer' for instance message is a forward declaration” mean here? </a>から見つけました。
<h2>直し方</h2>
<ol>
	<li>QuartzCore.frameworkをLink Binary With Libraryから追加する</li>
	<li>エラーの出た対象クラスファイルにQuartsCoreをimportするために、次の一行を追記する</li>
</ol>
<pre class="lang:default decode:true">#import &lt;QuartzCore/QuartzCore.h&gt;</pre>
<h1>NSLayoutConstraint</h1>
<pre>Terminating app due to uncaught exception 'NSInvalidUnarchiveOperationException',
reason: 'Could not instantiate class named NSLayoutConstraint'</pre>
このエラーが生じる原因は単純で、<del>主に地図</del>なんらかの理由でiOS6にしていない場合、新たに追加されたUse Autolayoutという機能がiOS5以前には対応していないため起こるのだそう。
<h2>直し方</h2>
<ol>
	<li>XIBあるいはStoryboardを開く</li>
	<li>Utilitiesパネル中の"Show the File Inspector"を開く</li>
	<li><a href="http://i.minus.com/ip9YeJmmpGjRA.png" target="_blank">Use Autolayoutのチェックを外す</a></li>
</ol>
<h1>respondsToSelector</h1>
<pre>No known instance method for selector 'respondsToSelector:'</pre>
次のようなヘッダファイルで、delegateから<code>respondsToSelector:</code>でメソッドを呼びだそうとすると起きたエラー。
<pre class="lang:default decode:true">@protocol hogeDelegate;

@interface hogeView : UIView
@property(nonatomic) id &lt;hogeDelegate&gt; delegate;
@end

@protocol hogeDelegate
-(void)hogeMethod:(hogeView*)view;
@end</pre>
<h2>直し方</h2>
原因は単純で、次のようにprotocolの表記を変えればいいそうです。
<pre class="lang:default decode:true">- @protocol hogeDelegate
+ @protocol hogeDelegate &lt;NSObject&gt;</pre>
idオブジェクトでは<code>respondsToSelector:</code>を使えないので、NSObjectを継承してくれというエラーだったらしい。
<p style="text-align: right;"><a href="http://stackoverflow.com/questions/7941051/cannot-use-respondstoselector-using-arc-on-mac" target="_blank">http://stackoverflow.com/questions/7941051/cannot-use-respondstoselector-using-arc-on-mac</a></p>

<h1>Instance variable 'variants' accessed in class method</h1>
インスタンス変数はインスタンスメソッドの中だけ可能で、クラスメソッド内でインスタンスメソッドを使うなよ、というエラー。

次のようなコードでエラーが起こります（しかしなんてひどいコードだ）。
<pre class="lang:default decode:true  crayon-selected">@interface hogehogeMogemoge
@property (nonatomic, strong) NSString *str;
@end

+ (NSString*)returnStr {
    _str = @"Hello World!"; // ERROR!!!!!! &lt;(^o^)&gt;┌┛’,;’;≡三
    return _str;
}</pre>
<code>+hoge</code>な関数にはインスタンス変数なんてものは無いんだから、アクセスできるはず無いですよねそりゃそうですよね…。OOPが理解できていない恥ずかしいエラーでした……。
<h2>直し方</h2>
<code>+hoge</code>じゃなくて<code>-hoge</code>にするとか、ちゃんとクラスオブジェクトを生成するとか。
<p style="text-align: right;"><a href="http://stackoverflow.com/questions/8016904/instance-variable-variable-accessed-in-class-method-error" target="_blank">http://stackoverflow.com/questions/8016904/instance-variable-variable-accessed-in-class-method-error</a></p>
&nbsp;
<h1>Comparison between pointer and integer ('****' and '****')</h1>
読んで字の如くポインタとinteger型を比較しようとすると起こる警告。
<h2>直し方</h2>
BOOLとNSStringとか、比較する変数を正しくキャストして型を合わせればokです。
