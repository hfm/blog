---
date: 2014-11-30T21:32:30+09:00
title: はてなスター付けてみた
tags: 
- diary
---
連打するの面白かったので、自分のブログにもはてなスター付けられるようにしてみた。

- [はてなスターをブログに設置するには - Hatena Developer Center](http://developer.hatena.ne.jp/ja/documents/star/misc/hatenastarjs)

上記ドキュメントを読めばやり方はすぐに分かった。
自分のブログの場合は、以下のように設定することによって、タイトル横に表示されるようになったみたい。

```html
<script type="text/javascript" src="http://s.hatena.ne.jp/js/HatenaStar.js"></script>
<script type="text/javascript">
    Hatena.Star.Token = '****************************************';
    Hatena.Star.SiteConfig = {
        entryNodes: {
            'article': {
                uri: 'h1.entry-title a',
                title: 'h1.entry-title',
                container: 'h1.entry-title'
            }
        }
    };
</script>
```

html5っぽい書き方してたから、articleで囲ってる領域を使えば良かった。

【2016/11/13 15:12追記】

はてなスターを解除。 http://s.hatena.ne.jp/js/HatenaStar.js が毎回スピードスコアに引っかかるし、ダウンロードに時間がかかっているので、表示速度を優先させるために泣く泣く外した。
