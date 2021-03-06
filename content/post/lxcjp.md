---
title: 第2回 コンテナ型仮想化の情報交換会 感想
date: 2013-10-05
tags: 
- studygroup
- lxc
- mruby
---
[@ten_forward](https://twitter.com/ten_forward)さんの主催する「[第2回 コンテナ型仮想化の情報交換会＠東京 (コンテナ型VMや関連するカーネル等の技術が話題の勉強会)](http://atnd.org/events/40915)」に参加させていただきました。

仮想化技術に関する勉強会・情報交換の場としての集まりで、具体的にはLXC (Linux Containers) やOpenVZ, FreeBSD jail等に関するお話でした。

## ペパボとSqale

[ペパボ](http://www.paperboy.co.jp)からも、[@mizzy](https://twitter.com/gosukenator)さんと[@hiboma](https://twitter.com/hiboma)さんのお二人が発表されました。

* [Sqaleでcgroupsにfork bomb対策を入れた話 at 第2回 コンテナ型仮想化の情報交換会＠東京](https://speakerdeck.com/mizzy/sqaledecgroupsnifork-bombdui-ce-woru-retahua-at-di-2hui-kontenaxing-jia-xiang-hua-falseqing-bao-jiao-huan-hui-dong-jing)
* [PaaSの作り方 Sqaleの場合](http://www.slideshare.net/hiboma/sqale-paas)

[Sqale](http://sqale.jp/)―RubyとPHPのホスティングサービス―の運用中に起こった問題を解決するために[こんなパッチ](https://github.com/paperboy-sqale/sqale-patches)を当てたりしています、などの裏側をドーンとお見せするような内容でした。

実際のソースコードやエラー画面を追いながら、問題に対してどうアプローチをするのかという解決プロセス／思考の一端を見せていただくことが出来た貴重な時間でした。

## リソースコントロールと品質

全体（サーバの品質）を守るために何らなの制限をかけると、それが相手の立場に立った場合、サービスの品質が低下しているように感じてしまうといった難しさに直面することがあります。

制御装置のはたらきがあらぬ方向に解釈され、結果的にストレスを感じさせてしまう…こうした状況を避けたいのは運用上の課題の一つだと思います。

Webサーバ１台が持つ資源の分配効率（何をどう制限すべきか）という課題に対して、[@matsumotory](https://twitter.com/matsumotory)さんが以下の発表をされていました。

<script async class="speakerdeck-embed" data-id="58727f800f260131e5f062820167ad5f" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

mod_mrubyを介してしまうため、1リクエストに対する処理時間にオーバヘッドが若干生じて入るものの、phpやcgi、あるいはftpといった比較的処理時間の長いものに対しては効果的に見えます。

あとは、実際どの処理にどの程度リソースを割り当てれば良いのか、というパラメータ調整にそれなりの経験値が必要そうだとは思いました。
例えばYahoo砲のような、複数IPから同時多量にアクセスがあった場合に有効なロジックには何があるか…考えるだけでワクワクします。

## 余談

実は、[@matsumotoryさんの変化点検出に関する研究](http://blog.matsumoto-r.jp/?p=35)には、大学院の研究でお世話になっていました。
そして今回のイベントでは、懇親会でお話させていただくことが出来て感動しました。

ペパボが普段扱っている技術レイヤとは異なり、よりカーネルに近い分野での集まりでしたが、非常に勉強になりました。

あらためまして、ten_forwardさん、本当にありがとうございました。
第3回のイベントがあれば是非飛んでいきます。
