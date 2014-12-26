---
layout: post
date: 2014-12-20 19:19:00 +0900
title: PuppetのCustom Providerを作る
tags:
- puppet
---
以下のドキュメントを読んで，

- https://docs.puppetlabs.com/puppet/latest/reference/modules_fundamentals.html
- https://docs.puppetlabs.com/guides/provider_development.html

puppet 3.7.3です．

hieraはpuppet周辺ツールの1つで，yamlやjson形式で蓄えられたkey/valueなconfigデータを検索・抽出するためのツールです．

## Base Provider

Providerを自作するときは，Base Providerを継承して作ります．
Package Providerの場合は，以下のように`Puppet::Provider::Package`を親クラスとします．

```rb
Puppet::Type.type(:package).provide(:cpanm, :parent => Puppet::Provider::Package) do
end
```

```rb
Puppet::Type.type(:package).provide(:cpanm, :parent => Puppet::Provider::Package) do
  def self.instances
    []
  end

  def query
  end

  def install
  end
end
```

### self.instances
https://github.com/puppetlabs/puppet/blob/3.7.3/lib/puppet/provider/package.rb#L1-L9
```rb
# lib/puppet/provider/package.rb#L1-L9

class Puppet::Provider::Package < Puppet::Provider
  # Prefetch our package list, yo.
  def self.prefetch(packages)
    instances.each do |prov|
      if pkg = packages[prov.name]
        pkg.provider = prov
      end
    end
  end
...
```

### query

```rb
# lib/puppet/provider/package.rb#L17-L23

# Look up the current status.
def properties
  if @property_hash.empty?
    @property_hash = query || {:ensure => :absent}
    @property_hash[:ensure] = :absent if @property_hash.empty?
  end
  @property_hash.dup
end
```

### install
