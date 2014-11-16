---
layout: post
date: 2014-11-16 23:13:30 +0900
title: Puppetでラムダとかイテレーションとか
tags:
- puppet
---
気づかなかったけど，どうやらPuppetがラムダやイテレーションをサポートするらしい．

- https://docs.puppetlabs.com/puppet/latest/reference/experiments_lambdas.html

まだ実験段階の機能らしく，Puppet 3系のfuture parserとしてこっそり搭載されている（3系の最初の頃からずっといるが．4系で正式搭載されるのだろうか）

puppet applyコマンドでそういった実験的機能を使いたい場合は，`--parser future`を付けてやると良い．

## each

rubyのeachみたいなもので，arrayやhashに対してのiterationを実行出来る．

```puppet
$array = [1, 2, 3, 5, 8]
each($array) |$i, $v| { notice("[${i}] => ${v}") }
```

上記プログラムの実行結果．

```console
$ puppet apply --parser future lambda.pp
Notice: Scope(Class[main]): [0] => 1
Notice: Scope(Class[main]): [1] => 2
Notice: Scope(Class[main]): [2] => 3
Notice: Scope(Class[main]): [3] => 5
Notice: Scope(Class[main]): [4] => 8
Notice: Compiled catalog for giant.local in environment production in 0.49 seconds
Notice: Finished catalog run in 0.01 seconds
```

## map

いわゆるmapで，arrayを返す．入力はarrayもhashも受け付ける．

```puppet
# input: array
$array = [1, 2, 3, 5, 8]
map($array) |$v| { notice($v * 2) }

# input: hash
$hash = { 'key' => 'value' }
map($hash) |$v| { notice($v) }
map($hash) |$i, $v| { notice("${i} has ${v}") }
```

上記プログラムの実行結果．

```console
$ puppet apply --parser future lambda.pp
Notice: Scope(Class[main]): 2
Notice: Scope(Class[main]): 4
Notice: Scope(Class[main]): 6
Notice: Scope(Class[main]): 10
Notice: Scope(Class[main]): 16
Notice: Scope(Class[main]): [key, value]
Notice: Scope(Class[main]): key has value
Notice: Compiled catalog for giant.local in environment production in 0.40 seconds
Notice: Finished catalog run in 0.01 seconds
```

## filter

条件にマッチしたものだけをまとめて返す．array, hash共に可．

```puppet
$array = [1, 2, 3, 4, 5]
$filtered = filter($array) |$v| { ($v % 2) == 0 }
$filtered.each |$v| { notice $v }
```

上記プログラムの実行結果．

```console
$ puppet apply --parser future lambda.pp
Notice: Scope(Class[main]): 2
Notice: Scope(Class[main]): 4
Notice: Compiled catalog for giant.local in environment production in 0.39 seconds
Notice: Finished catalog run in 0.01 seconds
```

## reduce

array, hashをラムダで計算して1個にまとめて返す．

```puppet
$array = Integer[1, 10] # 1〜10の配列を作る
$result = reduce($array) |$result, $value| {$result + $value}
notice($result)
```

上記プログラムの実行結果．

```console
$ puppet apply --parser future lambda.pp
Notice: Scope(Class[main]): 55
Notice: Compiled catalog for giant.local in environment production in 0.50 seconds
Notice: Finished catalog run in 0.01 seconds
```

## slice


```puppet
$array = [
  'bob',
  '100円',
  'alice',
  '10,000円',
  'eve',
  '1,000,000円',
]
slice($array, 2) |$name, $value| { notice "$name has $value" }
```

上記プログラムの実行結果．

```console
$ puppet apply --parser future lambda.pp
Notice: Scope(Class[main]): bob has 100円
Notice: Scope(Class[main]): alice has 10,000円
Notice: Scope(Class[main]): eve has 1,000,000円
Notice: Compiled catalog for giant.local in environment production in 0.41 seconds
Notice: Finished catalog run in 0.01 seconds
```

### 補足

他にも，ちょっとRubyっぽく

```puppet
[1, 2].reduce |$r, $v| { $r + $v }
```

みたいに書けたり（微妙に違うけど），関数をチェインさせて，

```puppet
Integer[1, 10].filter |$v| { $v < 5 }.reduce |$r, $v| { $r + $v }
```

みたいに書くことも出来るみたい．
しかしこういう技が増えれば増える程，内部DSLはこういう拡張に時間を割く必要がなくて便利だと思った．

## 終わりに

数値計算ばっかり例に出したけど，filterとかは結構便利だと思う．
特定の正規表現にマッチしないものをリストからガガッと削る，みたいなので使えるし．

ただ，Puppetでやることが増えれば増えるほど，選択肢が豊かになればなるほど，迷いが生じるリスクも同時に生まれるため，「これPuppetでやるべき？」みたいな議論を今から構えておかなければいけないかもしれない．
