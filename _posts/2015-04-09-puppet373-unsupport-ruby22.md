---
layout: post
date: 2015-04-09 19:30:49 +0900
title: Puppet 3.7.3 - 3.7.5 はRuby 2.2だと動かない
tags:
- puppet
- ruby
---
ペパボで何人かハマってしまった人がいたので記事にしておく。

PuppetLabsのチケットにも登録されているが、Puppet 3.7.x (x >= 3) はRuby 2.2だとエラーになってしまう。

- [[PUP-3796] Puppet 3.7.3 is not supported on Ruby 2.2 - Puppet Labs Tickets](https://tickets.puppetlabs.com/browse/PUP-3796)

```console
$ puppet --version
/Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/defaults.rb:488: warning: duplicated key at line 489 ignored: :queue_type
/Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/vendor/safe_yaml/lib/safe_yaml/syck_node_monkeypatch.rb:42:in `<top (required)>': uninitialized constant Syck (NameError)
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/vendor/safe_yaml/lib/safe_yaml.rb:197:in `<module:YAML>'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/vendor/safe_yaml/lib/safe_yaml.rb:132:in `<top (required)>'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/vendor/require_vendored.rb:4:in `<top (required)>'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/vendor.rb:40:in `require_libs'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/vendor.rb:53:in `load_vendored'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet.rb:172:in `<module:Puppet>'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet.rb:29:in `<top (required)>'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/lib/puppet/util/command_line.rb:12:in `<top (required)>'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
	from /Users/hfm/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/puppet-3.7.5/bin/puppet:7:in `<top (required)>'
	from /Users/hfm/.rbenv/versions/2.2.1/bin/puppet:23:in `load'
	from /Users/hfm/.rbenv/versions/2.2.1/bin/puppet:23:in `<main>'
```

※ちなみに1行目のエラーはwarningなので（良くはないけど）エラーとは無関係

どうやらSyckに関わるエラーらしく、どうしてもRuby 2.2で動かしたい場合は、`syck_node_monkeypatch.rb`というファイルに更なるモンキーパッチを当てるという闇の道を歩まねばならない。

---

追記:

柴田さんから補足ツイートをもらったので引用。
safe\_yamlに問題があるとのこと。つらい...

{% tweet https://twitter.com/hsbt/status/586115798185320449 %}

---

```diff
--- lib/puppet/vendor/safe_yaml/lib/safe_yaml/syck_node_monkeypatch.rb
+++ lib/puppet/vendor/safe_yaml/lib/safe_yaml/syck_node_monkeypatch.rb
@@ -39,5 +39,6 @@
 if defined?(YAML::Syck::Node)
   YAML::Syck.module_eval monkeypatch
 else
+  require 'syck' if RUBY_VERSION >= '2.2'
   Syck.module_eval monkeypatch
 end
```

これじゃあまりにも辛いので、Puppet 3.7系を使う場合はおとなしくRuby 2.1系を選択するのが良さそう。

ちなみにこの問題はPuppet 4.x系では解決するらしい。
そしてPuppet 3.x系はRuby 2.2へのサポートに消極的なので、4.xが出るまで待とう。

> **[Kylo Ginsberg added a comment - 2015/03/25 3:06 PM](https://tickets.puppetlabs.com/browse/PUP-3796?focusedCommentId=154371)**
>
> ... *We're not planning to backport 2.2 fixes to 3.x.*
> It turns out that PR was necessary but not sufficient b/c the 3.x code base has more dependencies with 2.2 entanglements than does the 4.x code base.
>
> ※b/c は because の略
