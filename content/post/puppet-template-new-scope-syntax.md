---
date: 2014-12-09T14:44:11+09:00
title: Puppet 3のTemplatesで使えるscope新記法
tags: 
- puppet
---
PuppetのTemplatesを使うとき，スコープ外の変数を参照するためには`scope.lookupvar`を使っていたが，どうやらPuppet 3から新しい記法が使えるようになっていた．

> Puppet 3 introduces an easier syntax: you can use the square bracket operator ([]) on the scope object as though it were a hash.  
> _https://docs.puppetlabs.com/guides/templating.html#out-of-scope-variables_

今までは`scope.lookupvar('lookup::var')`のようにメソッドっぽかったが，新しい記法ではハッシュのように取り出せるようになった．

```erb
<%= scope['lookup::var'] %>
```

例えばerbやinline_templateで以下のように使うことができる．

```puppet
# 古い記法
notice inline_template('Lookup OS: <%= scope.lookupvar("::operatingsystem") %>')

# 新しい記法
notice inline_template('Lookup OS: <%= scope["::operatingsystem"] %>')
```

ワンライナで書くと以下のようになる．エスケープ文字でやや見づらいが，Facterの値を取得出来ていることが分かる．

```console
$ puppet apply -e "notice inline_template('Lookup OS: <%= scope[\\'::operatingsystem\\'] %>')"
Notice: Scope(Class[main]): Lookup OS: Darwin
Notice: Compiled catalog for okkun.local in environment production in 0.05 seconds
Notice: Finished catalog run in 0.03 seconds
```

タイプ数を減らせるし，見た目もマシになっているので，今後は`scope['lookup::var']`な書き方にしてするのが良さそうだ．
