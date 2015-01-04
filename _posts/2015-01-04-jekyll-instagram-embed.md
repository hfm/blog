---
layout: post
date: 2015-01-04 14:07:26 +0900
title: JekyllにInstagramのembedコードを埋め込むプラグインを作成した
tags: 
- ruby
- jekyll
---
Instagramの[embed](http://instagram.com/developer/embedding/)機能をJekyll Tagとして実装しました．

- https://github.com/tacahilo/jekyll-instagram-embed

以下のように利用可能です．

```
# {}と%の間の空白は削除
# URLが http://instagram.com/p/abcdefghij であれば，hashは abcdefghij です．
{ % instagram hash % }
```

## instagram-ruby-gemが便利だった

以下のようにめっちゃ簡単に実装出来ました．

```rb
require 'instagram'

module Jekyll
  class InstagramEmbedTag < Liquid::Tag
    def initialize(tag_name, hash, token)
      super
      @hash             = hash.strip
      access_token_file = File.expand_path('.instagram/access_token', File.dirname(__FILE__))
      @access_token     = File.open(access_token_file).gets.strip
    end

    def render(context)
      embed_code
    end

    def embed_code
      oembed.html
    end

    def oembed
      client.oembed("instagram.com/p/#{@hash}")
    end

    def client
      Instagram.client(access_token: @access_token)
    end
  end
end

Liquid::Template.register_tag("instagram", Jekyll::InstagramEmbedTag)
```

Instagram APIの[oembed](http://instagram.com/developer/embedding/#oembed)に含まれる`html`キーの中身が埋め込み用HTMLタグになっているみたいでした．便利．

Instagram-ruby-gemの使い方は以下をご参照ください．

- [instagram-ruby-gemを使ってみた](/2014/11/30/instagram-ruby-gem/)
- https://github.com/Instagram/instagram-ruby-gem
