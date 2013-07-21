---
layout: post
title: うるさい感じに.gitignoreを再読み込みするスクリプトを作った
categories:
- Dev
tags:
- Gist
- Shell script
- Suburi
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: Gist, Development, Shell script, Programming
  _aioseop_description: ".gitignoreの設定がちゃんと反映されない場合に、インデックス削除→再commit&pushすることで解決するんですが、手順が面倒なのでシェルスクリプトで作ってみました。\r\nあと、アスキーアートでうざったい感じにしてみました。"
  _aioseop_title: うるさい感じに.gitignoreを再読み込み（再反映）するスクリプトを作った
---
ただのジョークツールです。シェルスクリプトのヒアドキュメントをやってみたくて…。

<!--more-->

https://gist.github.com/Tacahilo/5583320

.gitignoreを再読み込み（リロード）する部分については、以下のブログのコマンドを用いました。
<blockquote>[git].gitignoreをリロードする
<p style="text-align: right;"><a title="[git].gitignoreをリロードする" href="http://d.hatena.ne.jp/ufssf/20111111/1321022155" target="_blank">http://d.hatena.ne.jp/ufssf/20111111/1321022155</a></p>
</blockquote>
.gitignoreの設定がちゃんと反映されない場合に、インデックス削除→再commit&amp;pushすることで解決するんですが、一個一個実行するのもコピペして実行するのも面倒なのでシェルスクリプトでえーやん、とばかしに作りました。結果的に余計に面倒なことになってる気がしますが…。

ちなみに、アスキーアートは<a title="Text to ASCII Art Generator" href="http://patorjk.com/software/taag/#p=display&amp;h=1&amp;v=1&amp;f=Standard&amp;t=gitignore%0Areloaded...%0A*done*" target="_blank">Text to ASCII Art Generator</a>さんが頑張ってくれました。

実行結果は次のとおりです。

<img class="aligncenter size-large wp-image-4592" alt="ignoring" src="http://blog.hifumi.info/wp-content/uploads/2013/05/ignoring-437x600.png" width="437" height="600" />
