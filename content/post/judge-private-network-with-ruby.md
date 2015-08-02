---
title: Rubyでプライベートネットワーク(RFC 1918)を判定する
date: 2014-08-15T04:47:25+09:00
tags:
- ruby
- rubygems
- network
---

## モチベーション

- IPアドレスがプライベートネットワークかどうかをRubyで判断したい．
- プライベートネットワークはRFC1918[^1]への準拠を前提としている．

※RPC1918「3. Private Address Space」で，プライベートネットワークのアドレス空間は次のように予約されている．

```
10.0.0.0       -    10.255.255.255  (10.0.0.0/8)
172.16.0.0     -    172.31.255.255  (172.16.0.0/12)
192.168.0.0    -    192.168.255.255 (192.168.0.0/16)
```

## 検討

### その1: RubyGems ipaddress

調べると，`ipaddress`というgem[^2][^3]を使うと簡単にできることが分かった．
`IPAddress#private?`を使えば，IPアドレスがプライベートネットワークに属しているか否かを二値で判定してくれる．

```irb
irb(main):001:0> require 'ipaddress'
=> true
irb(main):002:0> ipaddr = IPAddress '192.168.100.1'
=> #<IPAddress::IPv4:0x007fc5441821d8 @address="192.168.100.1", @prefix=32, @octets=[192, 168, 100, 1], @u32=3232261121>
irb(main):003:0> ipaddr.private?
=> true
irb(main):004:0> ipaddr = IPAddress '192.169.100.1'
=> #<IPAddress::IPv4:0x007fc544152370 @address="192.169.100.1", @prefix=32, @octets=[192, 169, 100, 1], @u32=3232326657>
irb(main):005:0> ipaddr.private?
=> false
```

### その2: IPAddr

プライベートネットワークを判別したいだけなので，より依存の少ない方法は無いか考えた．
Rubyのstdlibには`IPAddr`がある[^4]ので，出来ればこれだけで完結させたい．
`IPAddr#include?`を使えば，「与えられたIPアドレスが，そのアドレス空間に存在するか」を二値判定出来る．

そこで，`ipaddress#private?`の実装を参考に，`IPAddr#include?`を使ったプライベートネットワークの判別メソッドを書いてみた（既に誰か書いてると思うけど...）．

```rb
# private?でも悪くないけど，public/protected/privateとの区別をつけたいのでprivate_network?にした
# ref: https://github.com/bluemonk/ipaddress/blob/master/lib/ipaddress/ipv4.rb#L566-570
def private_network?(ipaddr)
  [
    IPAddr.new('10.0.0.0/8'),
    IPAddr.new('172.16.0.0/12'),
    IPAddr.new('192.168.0.0/16')
  ].any? {|i| i.include? ipaddr }
end
```

このメソッドを使うと，以下のようにIPアドレスのプライベートネットワーク判別が出来る．

```irb
irb(main):001:0> require 'ipaddr'
=> true
irb(main):002:0> def private_network?(ipaddr)
irb(main):003:1>   [
irb(main):004:2*     IPAddr.new('10.0.0.0/8'),
irb(main):005:2*     IPAddr.new('172.16.0.0/12'),
irb(main):006:2*     IPAddr.new('192.168.0.0/16')
irb(main):007:2>   ].any? {|i| i.include? ipaddr }
irb(main):008:1> end
=> :private_network?
irb(main):009:0> private_network? '192.168.100.0'
=> true
irb(main):010:0> private_network? '193.168.100.0'
=> false
```




## 結論

- `ipaddress`というgemを使えば`#private?`でOK
- stdlibの`IPAddr`でも可能

`ipaddress`は便利だけど，今回の用途にはやや多機能なので，標準機能だけで解決出来る後者が好みかな．

[^1]: [RFC 1918 - Address Allocation for Private Internets](http://tools.ietf.org/html/rfc1918)
[^2]: [ipaddress | RubyGems.org | your community gem host](http://rubygems.org/gems/ipaddress)
[^3]: https://github.com/bluemonk/ipaddress 
[^4]: http://ruby-doc.org/stdlib-2.1.2/libdoc/ipaddr/rdoc/IPAddr.html
