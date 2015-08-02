---
title: Facter 2.xにちょっと苦しめられた
date: 2014-05-30
tags:
- ruby
- facter
- puppet
---
仕事でPuppetを使っているのですが、あるサービスの`puppet version`が2.6.x系と古いままだったので、今現在の最新版である3.6.1へアップデートをしました。

Puppetのバージョンアップによる変更点はいくつかありますが、今回は周辺ツールであるFacter 1.6 ( or 1.7) 系から2.x系への変更でハマったことを書き留めておきます。

## Facter.factでFactsを取れなくなった

- 昔は`Facter.fact_name`でも値を取れていたのがremovedになった
- 今後は`Facter.value(:fact_name)`のみをサポート
 - ちなみに`value`メソッドは昔からある

[Facter 2.0: Release Notes#breaking-changes](http://docs.puppetlabs.com/facter/2.0/release_notes.html#breaking-changes)にある通り、APIに変更があり、Factsは`Facter.value`メソッドを通じてのみ取得可能となったようです。

> * Fact values can now only be accessed using the Facter.value method. See [Using other facts](http://docs.puppetlabs.com/facter/2.0/custom_facts.html#using-other-facts) in the Custom Facts Walkthrough for more information and examples. Facts that refer to other facts with the deprecated Facter.fact_name notation will have to be updated.

```rb
# Facter 2.xからはこうなる
Facter.kernel # => NoMethodErrorで死んじゃう
Facter.value(:kernel) # => Linux
```

[Custom Facts](http://docs.puppetlabs.com/guides/custom_facts.html)を利用してFactsを取得している場合は注意が必要です。

### `Facter.unknown`は`NoMethodError`、`Facter.value(:unknown)`は`nil`

前者の、存在しないメソッドを呼びだそうとしても`NoMethodError`になるのは当たり前ですが、実はこの`NoMethodError`を前提としたコードがあったせいで少しハマってしまいました。

### 前提

- `Facter.unknown_fact`は`NoMethodError`
- `Facter.value(:unknown_fact)`は`nil`

> #### Using other facts
> You can write a fact which uses other facts by accessing `Facter.value(:somefact)`. If the named fact is unresolved, `Facter.value` will return `nil`, but if the fact can’t be found at all, it will throw an error.

```rb
Facter.unknown_fact         # => NoMethodError
Facter.value(:unknown_fact) # => nil
```


### 背景

- Facter 1.xの頃、サービスの中で`Facter.fact`で値を取っているコードがあった
- 「あるFactが存在する場合はfoo、存在しなければbarを行う」という記述を`begin`で書かれていた

```rb
# Old Facter
# Case: some_fact is unknown fact
begin
  Facter.some_fact # => NoMethodError
  foo_code
rescue => e
  warn e.message
  bar_code
end

# => undefined method `some_fact' for Facter:Module
#    bar_code
```

### 課題

- Facter 2.xにバージョンアップしたら、`begin`を使っても同じ動きにならない

```rb
# Facter 2.x
# Case: some_fact is unknown fact
begin
  Facter.value(:some_fact) # => nil
  foo_code
rescue => e
  warn e.message
  bar_code
end

# => foo_code
```

### 解決

- 2.xからは`if`を使う

```rb
if Facter.value(:some_facts)
  foo_code
else
  bar_code
end
```

大して難しい話でも無いですが、`:some_facts`が存在すれば`true`、存在しなければ`nil`と評価されるため、今までと同じ結果が期待できます。
コード量も少し減り、見通しも良くなったかな。

他にもFactsの取得方法などに細かな変更があるようですが、それらについては機会があれば書くことにします。

## 参考

- [Custom Facts — Documentation — Puppet Labs](http://docs.puppetlabs.com/guides/custom_facts.html)
- [puppetlabs/facter](https://github.com/puppetlabs/facter/)
