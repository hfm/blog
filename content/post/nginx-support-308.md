---
date: 2017-04-20T20:49:42+09:00
title: nginx の 308 Permanent Redirect サポート
tags:
- nginx
---
今日(2017/04/20)時点ではまだリリースされていないが、[nginx: be5cfa918bfc](http://hg.nginx.org/nginx/rev/be5cfa918bfc)で、HTTP ステータスコード 308 Permanent Redirect[^1] がサポートされた。おそらく nginx 1.13.0 で利用可能になるだろう。

308 については、GIGAZINE の記事『[新たなHTTPステータスコード「308」とは？](http://gigazine.net/news/20140220-http-308/)』が分かりやすかった。301 Moved Permanently はリダイレクト時にリクエストメソッドをGETに変えてしまう可能性があり、例えばPOSTメソッドのリクエストボディが失われる懸念があった。それに対し、308 Permanent Redirect はリクエストメソッドの不変を保証する。

幅広い用途があるとは思えないが、以下の[kazuho](https://twitter.com/kazuho/)さんのブコメにあるように、エンドポイントの変更などに対しては有用だろう。

<blockquote class="hatena-bookmark-comment"><a class="comment-info" href="http://b.hatena.ne.jp/entry/183159750/comment/kazuhooku" data-user-id="kazuhooku" data-entry-url="http://b.hatena.ne.jp/entry/gigazine.net/news/20140220-http-308/" data-original-href="http://gigazine.net/news/20140220-http-308/" data-entry-favicon="http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Fgigazine.net%2Fnews%2F20140220-http-308%2F" data-user-icon="/users/ka/kazuhooku/profile.gif">新たなHTTPステータスコード「308」とは？ - GIGAZINE</a><br><p style="clear: left">用途としては、blogをpostするAPIのエンドポイントが変わったときとかかしら</p><a class="datetime" href="http://b.hatena.ne.jp/kazuhooku/20140220#bookmark-183159750"><span class="datetime-body">2014/02/20 13:07</span></a></blockquote><script src="https://b.st-hatena.com/js/comment-widget.js" charset="utf-8" async></script>

[MDN の 308 の Browser compatibility](https://developer.mozilla.org/ja/docs/Web/HTTP/Status/308) をみると、策定から2年経った今では、ほとんどのブラウザでサポートされたようだ。自分の使っているブラウザの対応状況は http://webdbg.com/test/308/ で確認すると良いだろう。

[^1]: https://tools.ietf.org/html/rfc7538
