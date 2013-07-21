---
layout: post
title: Rails 4とbundlerを使ってWebアプリを作る手順の最初のほうの覚書
categories:
- Dev
tags:
- Ruby
- Ruby on Rails
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_title: Rails 4とbundlerを使ってWebアプリを作る手順の最初のほうの覚書
---
ペパボのエンジニア研修では、Ruby 2.0.0-p195 x Rails 4.0.0の環境の中、<a title="Learn Web Development with the Ruby on Rails Tutorial" href="http://ruby.railstutorial.org/ruby-on-rails-tutorial-book?version=4.0" target="_blank">Rails Tutorial</a>に励む日々を送っていました。

RubyやRailsのお作法もよく分かっていないままで、「さて、なんかRailsでアプリつくってみるかー」となった時に何から始めていいやら分からなくなってしまうので、自分のために覚書を残します。

それなりに調べはしたものの、これがベストなのかどうかよく分かっておりません（そもそもベストなんてものがあるのか…）。ツッコミよろしくお願いします。

bundle init

何はともあれGemfileを作ります。bundlerはversion 1.3.5です。
<pre class="lang:default decode:true" title="Gemfileを作る">$ mkdir sample_app
$ cd sample_app
$ bundle init
Writing new Gemfile to /PATH/TO/sample_app/Gemfile</pre>
bundle initコマンドで出力されるGemfileは次のようになりました。
<pre class="lang:default decode:true" title="Gemfileの中身">$ cat Gemfile
# A sample Gemfile
source "https://rubygems.org"

# gem "rails"</pre>
gem "rails"のコメントアウトを外します。
<pre class="lang:diff decode:true" title="Gemfile.diff"># A sample Gemfile
source "https://rubygems.org"

--- # gem "rails"
+++ gem "rails"</pre>
&nbsp;
