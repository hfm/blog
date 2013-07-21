---
layout: post
title: Sublime Text 2をMacで使う
categories:
- Dev
- Mac
tags:
- Mac
- Sublime Text 2
- vim
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '3064'
  dsq_thread_id: '1224433584'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: sublime text 2,mac,vim,package control, development
  _aioseop_description: MacにSublime Text 2（以下ST2）を入れてから、実際に行った設定などを紹介。
  _aioseop_title: Sublime Text 2をMacで使う
  _oembed_1fcd2d14f2dc3ec5e304db2bc7ceeb31: <iframe allowfullscreen="true" allowtransparency="true"
    frameborder="0" height="438" id="talk_frame_4731" mozallowfullscreen="true" src="//speakerdeck.com/player/50377202080220000206357d"
    style="border:0; padding:0; margin:0; background:transparent;" webkitallowfullscreen="true"
    width="500"></iframe>
---
<p style="text-align: center;"><a href="http://blog.hifumi.info/wp-content/uploads/2012/10/SublimeText2.png"><img class="size-full wp-image-3064 aligncenter" title="Sublime Text 2" alt="Sublime Text 2" src="http://blog.hifumi.info/wp-content/uploads/2012/10/SublimeText2.png" width="600" height="200" /></a></p>
<a title="Sublime Text 2をvim風に操作するには、プラグインすら不要でした。設定の変更のみ。" href="http://ginpen.com/2012/07/15/vim-for-sublime-text/" target="_blank">Vim風コーディングが出来る！</a>ということで、ちまたで噂の<a href="http://www.sublimetext.com/" target="_blank">Sublime Text  2</a>をMacに入れてみました。 <!--more-->
<h1>目次</h1>
<ul style="font-family: monospace;">
	<li><a href="#opportunity">Sublime Text 2を知ったキッカケ</a></li>
	<li><a href="#howtoinstall">Sublime Text 2の入手方法</a></li>
	<li><a href="#init">初期設定</a>
<ul>
	<li><a href="#forvim">Vim風コーディングの設定</a></li>
	<li><a href="#path">環境パスを設定する</a></li>
	<li><a href="#font">フォントとフォントサイズを変更する</a></li>
	<li><a href="#listupsetting">設定一覧</a></li>
</ul>
</li>
	<li><a href="#packagecontrol">Package Control</a>
<ul>
	<li><a href="#usageofcommandpallet">コマンドパレットの使い方</a></li>
	<li><a href="#installpackagecontrol">PackageControlのインストール</a></li>
</ul>
</li>
	<li><a href="#packagelists">導入パッケージリスト（ABC順）</a>
<ul>
	<li><a href="#abacus">Abacus</a> … 複数行コードの整列・整形</li>
	<li><a href="#allautocomplete">All Autocomplete</a> … 自動補完機能の強化</li>
	<li><a href="#autofilename">AutoFileName</a> … ファイルネーム入力の自動補完</li>
	<li><a href="#brackethighlighter">BracketHighlighter</a> … 括弧のハイライト強調</li>
	<li><a href="#csssnippets">CSS Snippets</a> … CSSのSnippets</li>
	<li><a href="#csscomb">CSSComb</a> … CSSコードの整列・整形</li>
	<li><a href="#docblockr">DocBlockr</a> … DocBlock形式のコメント入力支援</li>
	<li><a href="#emmet">Emmet(emmet-sublime)</a> … 次段階のZen-coding用機能追加</li>
	<li><a href="#git">Git</a> … Gitコマンド機能追加</li>
	<li><a href="#gitignore">Gitignore</a> … ".gitignore"の生成</li>
	<li><a href="#jquery">jQuery</a> … jQueryのSnippets</li>
	<li><a href="#latex">LaTeXTools</a> … LaTeX用機能追加</li>
	<li><a href="#less">LESS</a> … LESS形式のハイライト</li>
	<li><a href="#markdown">MarkdownBuild+MarkdownEditing</a> … Markdown用機能追加</li>
	<li><a href="#rtools">R Tools</a> … R言語用機能追加</li>
	<li><a href="#sidebarenhancements">SideBarEnhancements</a> … サイドバーの機能拡張</li>
	<li><a href="#sublimecodeintel">SublimeCodeIntel</a> … 自動補完機能の強化やその他IDE的機能追加</li>
	<li><a href="#sublimelinter">SublimeLinter</a> … コードチェック機能追加</li>
	<li><a href="#interpreter">SublimeREPL</a> … 複数のインタプリタをST2上で操作</li>
	<li><a href="#sublimerope">SublimeRope</a> … Python用統合環境</li>
	<li><a href="#trailingspaces">TrailingSpaces</a> … 不要な空白行をハイライト</li>
	<li><a href="#vintageex">VintageEx</a> … Vintage(Vi)モードの機能拡張</li>
</ul>
</li>
	<li><a href="#buildsystem">ビルドシステムの設定（新規追加）</a></li>
	<li><a href="#impression">雑感（どうでもいい話）</a></li>
</ul>
<h2><a name="opportunity"></a>Sublime Text 2を知ったキッカケ</h2>
ちなみにわたしがSublime Text 2を知ったキッカケはこれ：

https://speakerdeck.com/kentaro/sublime-text-2-for-emacsers

初めは、Emacser向けスライドということもあり、気になったものの使用するには至りませんでした。しかしここ最近のわたしのTwitter TLでちょこちょこ話題になっている様子にだんだん感化され…そしてこれが最も強いキッカケなのですが、先述の通りVim風コーディングも出来るということで、これは一回試してみようかと。
<h2><a name="howtoinstall"></a>Sublime Text 2の入手方法</h2>
<a href="http://www.sublimetext.com/2" target="_blank">Sublime Text 2のダウンロードはこちら</a>から可能です。 現在(2012.11.24)は有料US$59ですが、試用期間があるので取り敢えず試してみることも可能です。

また、<a href="http://www.sublimetext.com/dev" target="_blank">開発版の入手</a>も可能で、安定版と比べて新機能をいち早く使用出来るようです（ただし当然ですが、色々不具合が出る可能性もあります）。
<h1><a name="init"></a>初期設定</h1>
<h2><a name="forvim"></a>▷Vim風コーディングの設定</h2>
メニューバーのSublime Text 2 → Settings - Defaultで設定ファイルを呼び出し、次の一行を変更します。
<pre class="lang:default decode:true" title="Sublime Text 2 → Settings - Default">    // List any packages to ignore here. When removing entries from this list,
    // a restart may be required if the package contains plugins.
-//  "ignored_packages": ["Vintage"]
+    "ignored_packages": []</pre>
上記の一文はファイルの最後の方にあります。ingored_packagesの中身を空っぽにすればOKです。設定ファイルの保存→ST2再起動で、Vim風コーディングスタイルの完成です。
<p style="text-align: right;"><a title="Sublime Text 2をvim風に操作するには、プラグインすら不要でした。設定の変更のみ。" href="http://ginpen.com/2012/07/15/vim-for-sublime-text/" target="_blank">Sublime Text 2をvim風に操作するには、プラグインすら不要でした。設定の変更のみ。</a></p>

<h2><a name="path"></a>▷環境パスを設定する</h2>
RubyやPythonを利用する際に、システムではなくHomebrew等からインストールしたバージョンを使えるようにST2の環境パスを設定します。

<code>Command + ,</code>で設定ファイルを呼び出し、次の文を追記します（シェルからecho $PATHと打てば環境パスが出力されるので、それをコピペするのも可）。
<pre>"build_env":
{
    "PATH": "/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
}</pre>
<h2><a name="font"></a>▷フォントとフォントサイズを変更する</h2>
プログラミング用フォントに<a href="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html" target="_blank">Ricty</a>を使用するため、標準フォントから変更します。

<code>Command + ,</code>で設定ファイルを呼び出し、以下の２行を書き加えます。
<pre>"font_face": "Ricty",
"font_size": 15</pre>
<h2><a name="listupsetting"></a>▷設定一覧</h2>
上２つで環境変数とフォントについて書きましたが、次に私が設定している<code>Command + ,</code>のユーザ設定ファイルを掲載します。

基本スタンスとして二度手間は嫌っています。つまりグローバル（デフォルト）設定に書かれているものはいちいちユーザ設定に起こさず、こちらで変更したい項目だけを列挙する格好になります。
<pre class="lang:default decode:true">{
    "build_env": //環境変数
	{
        "PATH": "/usr/local/bin:/usr/local/sbin:/usr/local/share:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
	},
    "bold_folder_labels":            true,    //サイドバーのフォルダラベルを太字化
    "caret_style":                   "phase", //入力位置を示すカーソルの表示方法。smooth, phase, blink, wide, solidがある。
    "color_scheme":                  "Packages/Color Scheme - Default/Monokai Bright Editted.tmTheme", //テーマの設定
    "disable_formatted_linebreak":   true,    //日本語入力時、確定(Enter)で入力文字が消えるのを防ぐ
    "disable_tab_abbreviations":     true,    //emmet使用時に、tabで勝手にタグが展開されるのを防ぐ
    "draw_minimap_border":           true,    //ミニマップの表示領域に枠線を表示する
    "font_face":                     "Ricty", //フォント名
    "font_size":                     17.0,    //フォントサイズ
    "highlight_line":                true,    //選択行をハイライトする
    "indent_to_bracket":             true,    //改行時に初めの括弧（開放）までスペース追加
    "translate_tabs_to_spaces":      true,    //Tab空白をSpaceに変換
    "vintage_ctrl_keys":             false,   //(Vintage)Ctrlキーを用いたVimキーバインドの無効化
    "vintage_start_in_command_mode": true,    //(Vintage)起動時にコマンドモード
    "word_wrap":                     true     //画面端での折り返し
}</pre>
<p style="text-align: right;"><a href="https://bitbucket.org/dat/sublime-text-2-preferences-japanese/wiki/Preferences%20Japanese" target="_blank">sublime Text 2 Preferences Japanese</a></p>

<h1><a name="packagecontrol"></a>Package Control</h1>
Package ControlはyumとかHomebrewのようなST2用パッケージ管理ツールです。Githubリポジトリを検索して、便利なパッケージを入手してST2を強化できます。
<h2><a name="usageofcommandpallet"></a>コマンドパレットの使い方</h2>
Package Controlの前にコマンドパレット機能の説明だけ。

Command + Shift + Pでコマンドパレットが開きます。コマンドパレットはST2内の様々なファンクションの呼び出しが可能で、ファイルの削除・移動やシンタックスハイライトの設定などほぼすべての操作をコマンド入力可能にしてくれます。

また、コマンドパレットの表示はインクリメンタルサーチなので、一部でも文字が当てはまればリストアップしてくれます。

[caption id="attachment_3283" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/10/Screen-Shot-2012-11-24-at-10.11.14-AM.png"><img class="size-medium wp-image-3283" title="コマンドパレットでFileと打ったところ" alt="コマンドパレットでFileと打ったところ" src="http://blog.hifumi.info/wp-content/uploads/2012/10/Screen-Shot-2012-11-24-at-10.11.14-AM-400x348.png" width="400" height="348" /></a> コマンドパレットでFileと打ったところ[/caption]
<h2><a name="installpackagecontrol"></a>Package Controlのインストール</h2>
<ol>
	<li>コンソールControl + `を呼び出します（メニューバーからでも探せます）。</li>
	<li>コンソールがST2のウィンドウ下部に現れたら、次の長い一行をコピペしてエンター。</li>
</ol>
<pre>import urllib2,os;pf='Package Control.sublime-package';ipp=sublime.installed_packages_path();os.makedirs(ipp) if not os.path.exists(ipp) else None;open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read())</pre>
これでコマンドパレットからPackage Controlが使用可能になりました。Package Control: Install Package を使えばパッケージのインストールが可能です。

[caption id="attachment_3282" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/10/packagecontrol.png"><img class="size-medium wp-image-3282" title="Package Controlの項目一覧" alt="Package Controlの項目一覧" src="http://blog.hifumi.info/wp-content/uploads/2012/10/packagecontrol-400x212.png" width="400" height="212" /></a> Package Controlの項目一覧[/caption]

なお、以下の各パッケージの導入は、一部例外を除いてすべてPackage Control: Install Package 経由です。
<p style="text-align: right;"><a title="Sublime Text 2 のススメ" href="http://blog.agektmr.com/2012/05/sublime-text-2.html" target="_blank">Sublime Text 2 のススメ</a></p>

<h1><a name="packagelists"></a>導入パッケージリスト（ABC順）</h1>
<h2><a name="abacus"></a>▶Abacus</h2>
JSONのデータセットのような、複数行に渡るコードの見た目を美しく整形してくれるパッケージ。

なんとなく自分で動画をとって作ってみたAbacusの具体的な使用イメージはこちらです（720pにしないと文字が潰れちゃってる…）。

[youtube=http://www.youtube.com/watch?v=ZDWUgpEhBVU]
<p style="text-align: right;"><a href="https://github.com/khiltd/Abacus" target="_blank">khiltd / Abacus</a></p>

<h2><a name="allautocomplete"></a>▶All Autocomplete</h2>
標準の自動補完（オートコンプリート）機能を強化し、マッチする文字列があればサジェストしてくれます。

学習機能があり、一度入力した文字列であれば同じファイル中に再度入力しようとすると、途中で文字列を補完してくれるので（ちょっと鬱陶しい時もありますが）同じ文字を何度も打つ苦行を軽減してくれます。
<p style="text-align: right;"><a href="https://github.com/alienhard/SublimeAllAutocomplete" target="_blank">alienhard/SublimeAllAutocomplete</a></p>

<h2>▶<a name="autofilename"></a>AutoFileName</h2>
自動補完系のなかでもファイルネーム入力に特化したパッケージがこちら。自動補完用パッケージを複数入れているせいもあり、どれがどの機能を果たしているのが段々判別つかなくなってきているのですが（笑）サイドバーに表示されているようなファイルの名前をサッと補完してくれるので重宝しています。
<p style="text-align: right;"><a href="https://github.com/BoundInCode/AutoFileName" target="_blank">BoundInCode/AutoFileName</a></p>

<h2>▶<a name="brackethighlighter"></a>BracketHighlighter</h2>
括弧類(),[],{}やクォーテーション""、タグ&lt;&gt;~&lt;/&gt;等をハイライトしてくれるパッケージです。

説明はヒトコトで終わってしまうのですが、一致するハイライトの色付けが分かりやすく、非常に便利です。
<p style="text-align: right;"><a href="https://github.com/facelessuser/BracketHighlighter" target="_blank">facelessuser/BracketHighlighter</a></p>

<h2>▶<a name="csssnippets"></a>CSS Snippets</h2>
CSS3に対応したSnippetsです。ウェブ開発はあんまりしないんですが、念の為に入れてます。
<p style="text-align: right;"><a href="https://github.com/joshnh/CSS-Snippets" target="_blank">joshnh/CSS-Snippets</a></p>

<h2>▶<a name="csscomb"></a>CSSComb</h2>
CSSCombはゴチャゴチャしがちなCSSのプロパティを整理整頓してくれるパッケージです。
<blockquote>SSのプロパティを正しい並び順でソートし直してくれる『CSScomb』

<a href="http://csscomb.com/online/" target="_blank">CSScomb Online</a>はCSSファイル内のプロパティを一定のルールにしたがった正しい並び順でソートしてくれるオンラインツール。…
<p style="text-align: right;"><a href="http://kenz0.s201.xrea.com/weblog/2012/08/csscsscomb.html" target="_blank">http://kenz0.s201.xrea.com/weblog/2012/08/csscsscomb.html</a></p>
</blockquote>
オンライン版も公開されているようですが、ST2上でも利用可能ということで、やはり念の為。
<p style="text-align: right;"><a href="http://t32k.me/mol/log/csscomb/" target="_blank">http://t32k.me/mol/log/csscomb/</a><a href="http://csscomb.com/online/" target="_blank"> Online Sorting | CSSComb</a></p>

<h2>▶<a name="docblockr"></a>DocBlockr</h2>
DocBlock形式（/** hoge */で書くコメント形式）の入力支援パッケージです。

/**まで入力した後、<code>Tab</code>か<code>Enter</code>を入力することによってDocBlock形式のコメントを展開してくれます。
<p style="text-align: right;"><a href="https://github.com/spadgos/sublime-jsdocs" target="_blank">spadgos/sublime-jsdocs</a></p>

<h2>▶<a name="emmet"></a>Emmet(emmet-sublime)</h2>
EmmetはZen Codingの機能拡張版といった位置づけらしく、以下のブログ記事が非常に丁寧に凄さ素晴らしさを解説されています。
<blockquote>…もはやHTMLコーダーで使っていない人はいないであろうZen-CodingがHTML5/CSS3の広まりと共にEmmetという名前に変更し、進化をとげているようです。…
<p style="text-align: right;"><a href="http://log.deconcepter.jp/2012/10/emmet/" target="_blank">知らない人は遅れてる？新Zen-Coding Emmet</a></p>
</blockquote>
Emmetの使用方法は上記を参考していただくとして、導入手順だけ以下に書き残しておきます。
<ol>
	<li>コマンドパレットからAdd Repositoryを選択する</li>
	<li>https://github.com/sergeche/emmet-sublime を入力する</li>
	<li>Install Package からemmet-sublime をインストールする</li>
	<li>ST2を再起動する</li>
</ol>
以上で導入完了です。Control + E でコマンドが展開されるようになります。
<h2><a name="git"></a>▶Git</h2>
その名の通りGitコマンドをST2で使用可能にするパッケージです。

add, commit, push, pullといった基本的な操作から、stashやdiff, brance, blame, init, merge, ...ひと通りのgitコマンドは利用可能です。git-flowもついてる？

でもRebaseが見当たらない…とはいえ、ST2で操作する分には十二分だと思います。
<p style="text-align: right;"><a href="https://github.com/kemayo/sublime-text-2-git" target="_blank">kemayo/sublime-text-2-git</a></p>

<h2><a name="gitignore"></a>▶Gitignore</h2>
<a href="https://github.com/github/gitignore" target="_blank">GitHub/gitignore</a>から.gitignoreを引いてきて、簡単にディレクトリに.gitignoreを作成してくれるパッケージです。いちいち検索してきたりコピペしてくるよりも素早く機能できる点が気に入っています。
<p style="text-align: right;"><a href="https://github.com/theadamlt/Sublime-Gitignore" target="_blank">theadamlt/Sublime-Gitignore</a></p>

<h2><a name="jquery"></a>▶jQuery</h2>
jQuery関連の関数機能(Snippets)がまるごとパッケージ化されています。ウェブ開発はあんまりしないんですが、念の為に入れてます。
<p style="text-align: right;"><a href="https://github.com/mrmartineau/Jquery" target="_blank">mrmartineau/jQuery</a></p>

<h2><a name="latex"></a>▶LaTeXTools</h2>
<a href="http://www.tug.org/mactex/" target="_blank">MacTeX</a>という大変素晴らしいプロダクトはあるものの、論文もこれで書ければいいなーと思ったので、LaTeX環境も揃えてみました。

ただし、<a href="http://www.tug.org/texlive/" target="_blank">TeXLive</a>がインストールされていなければならないので、結局のところ<strong><a href="http://www.tug.org/mactex/" target="_blank">MacTeX</a>をインストールしていることが前提条件</strong>となっていますのでご注意を。

設定作業は次の通り。参考は<a href="http://wiki.livedoor.jp/fuhmi/d/TeX%A4%CB%B4%D8%A4%B9%A4%EB%B3%D0%A4%A8%BD%F1%A4%AD#content_16" target="_blank">こちら</a>。
<ol>
	<li>Install PackageからLaTeXToolsをインストール</li>
	<li>pLaTeX用に設定ファイルの一部を書き換え（リンク先参照）</li>
	<li>dvipdfmx用に一部スクリプトを書き換え（リンク先参照）</li>
</ol>
<code>これで⌘-Bによる</code>LaTeXコンパイルが可能になります。
<p style="text-align: right;"><a title="Sublime Text2 で(p)LaTeX文書を扱う" href="http://wiki.livedoor.jp/fuhmi/d/TeX%A4%CB%B4%D8%A4%B9%A4%EB%B3%D0%A4%A8%BD%F1%A4%AD#content_16" target="_blank">Sublime Text2 で(p)LaTeX文書を扱う</a></p>

<h2><a name="less"></a>▶LESS</h2>
LESSは<a href="http://lesscss.org/" target="_blank">less.js</a>と組み合わせて使う拡張CSSです。CSSの痒いところに手が届く、便利関数や機能をまるごとパッケージ化した孫の手ツールです。
<blockquote>CSSの記述が3倍速くなる「LESS」の使い方

…「LESS」や「Sass」のようなCSS拡張メタ言語は、こうしたフレームワークとは異なり、CSSの言語自体を拡張し、CSSには存在しない機能を追加するものです…
<p style="text-align: right;"><a href="http://ascii.jp/elem/000/000/668/668205/" target="_blank">http://ascii.jp/elem/000/000/668/668205/</a></p>
</blockquote>
そのLESS形式のSyntaxパッケージが、このLESS-sublimeです。
<p style="text-align: right;"><a href="https://github.com/danro/LESS-sublime" target="_blank">danro/LESS-sublime</a></p>

<h2><a name="markdown"></a>▶MarkdownBuild+MarkdownEditing</h2>
作業記録を残すのに<a href="http://ja.wikipedia.org/wiki/Markdown" target="_blank">Markdown記法</a>を愛用しています（以前は<strong><a href="http://mouapp.com/" target="_blank">Mou</a></strong>というリアルタイムプレビュー機能が特徴のMarkdownエディタが重宝していました）。

MarkdownBuildは、MarkdownファイルをCommand+Bでビルドし、プレビューするプラグインです。ビルド結果はデフォルトブラウザに表示されます。

また、Markdown記法の便利化ツールとしてMarkdownEditingも併用します。MarkdownEditingはコマンドでリンク挿入したり余計な空白を削除したり、Markdownで書く際の機能追加パッケージなんですが、いかんせんST2自体の日本語の弱さと相まって、若干使いにくい部分があるので多少修正して使っています。

Packages/MarkdownEditing/Default (OSX).sublime-keymap を次のように修正します。
<pre class="lang:default decode:true" title="$SUBLIME_HOME/Packages/MarkdownEditing/Default (OSX).sublime-keymap">- { "keys": ["enter"], "command": "insert_snippet", "args": {"contents": " ${TM_CURRENT_LINE/(#+?)[^#].*$/$1\n/}"}, "context":
+ { "keys": ["shift+enter"], "command": "insert_snippet", "args": {"contents": " ${TM_CURRENT_LINE/(#+?)[^#].*$/$1\n/}"}, "context":
    [
        { "key": "selector", "operator": "equal", "operand": "text.html.markdown", "match_all": true },
        { "key": "preceding_text", "operator": "regex_contains", "operand": "^#+\\s+[^#]", "match_all": true },
        { "key": "preceding_text", "operator": "not_regex_contains", "operand": "#+$", "match_all": true },
        { "key": "following_text", "operator": "regex_contains", "operand": "^\\s*$", "match_all": true }
    ]
},
// Extend lists
- { "keys": ["enter"], "command": "insert_snippet", "args": {"contents": "${TM_CURRENT_LINE/^(\\s*([*\\-]|\\d\\.)(\\s+)).*/\n$2$3/}"}, "context":
+ { "keys": ["shift+enter"], "command": "insert_snippet", "args": {"contents": "${TM_CURRENT_LINE/^(\\s*([*\\-]|\\d\\.)(\\s+)).*/\n$2$3/}"}, "context":
    [
        { "key": "selector", "operator": "equal", "operand": "text.html.markdown", "match_all": true },
        { "key": "preceding_text", "operator": "regex_contains", "operand": "^(\\s*([*\\-]|\\d\\.)\\s+)\\S.*", "match_all": true }
        // { "key": "following_text", "operator": "regex_contains", "operand": "^\\s*$", "match_all": true }
    ]
},</pre>
これでリスト展開時やSnippetを追加する際のみ、Shift+Enterと打つことで機能利用が可能となります（手間は増えているのですが、このほうがストレスが少ないので…）。<del style="font-family: Georgia, 'Times New Roman', 'Bitstream Charter', Times, serif; font-size: 13px; line-height: 19px;">そもそもストレスかかえてまでST2を使うというｒｙ</del>
<p style="text-align: right;"><a href="https://github.com/erinata/SublimeMarkdownBuild" target="_blank">jfoshee/MarkdownBuild
</a><a style="font-size: x-small;" href="https://github.com/ttscoff/MarkdownEditing" target="_blank">ttscoff/MarkdownEditing</a></p>

<h2><a name="rtools"></a>▶R Tools</h2>
R言語をST2で使うためのパッケージ。ビルドやrdocの作成など、便利機能が使用可能になります。

ただしこれだけを入れても、MacにR言語がインストールされていなければ何も出来ないので、Homebrewからインストールします。
<pre>$ brew install r</pre>
これでST2で書いたR言語のコードをCommand + Bでビルド出来るようになります。
<p style="text-align: right;"><a href="https://github.com/karthikram/Rtools" target="_blank">karthikram/Rtools</a></p>

<h2><a name="sidebarenhancements"></a>▶SideBarEnhancements</h2>
サイドバーでのファイルやフォルダ操作を拡張してくれるパッケージです。

ファイルの削除や移動、リネームなど様々な機能が右クリックあるいはコマンドパレットから利用可能になります。
<p style="text-align: right;"><a href="https://github.com/titoBouzout/SideBarEnhancements" target="_blank">titoBouzout/SideBarEnhancements</a></p>

<h2><a name="sublimecodeintel"></a>▶SublimeCodeIntel</h2>
<a href="https://github.com/Kronuz/SublimeCodeIntel#sublimecodeintel" target="_blank">公式</a>によると、PHP, Python, RHTML, JavaScript, Smarty, Mason, Node.js, XBL, Tcl, HTML, HTML5, TemplateToolkit, XUL, Django, Perl, Ruby, Python3の自動補完やジャンプ機能などが利用可能になるパッケージです。

開発をする上では必須といっても良いパッケージだと思います。
<p style="text-align: right;"><a href="https://github.com/Kronuz/SublimeCodeIntel" target="_blank">Kronuz/SublimeCodeIntel</a></p>

<h2><a name="sublimelinter"></a>▶SublimeLinter</h2>
コンパイル前にコードを厳密にチェックしてくれるパッケージです。

コードのどの部分がどのようにおかしいのか、作業中にリアルタイムで指摘してくれるので、細かなミスを減らすにはもってこいの開発必須ツールです。
<p style="text-align: right;"><a href="https://github.com/SublimeLinter/SublimeLinter" target="_blank">SublimeLinter/SublimeLinter</a></p>

<h2><a name="interpreter"></a>▶SublimeREPL</h2>
大学の研究でRに触れる機会があり、SublimeREPLというST2上にインタプリタを実現するパッケージを導入することに。

これはR言語やPythonやnode.jpといった数々の言語をST2上に展開したインタプリタで実行できるようにするものです。いちいちターミナルを開き直すこと無く、ST2から離れずに操作できるので重宝しています。
<p style="text-align: right;"><a title="https://github.com/wuub/SublimeREPL" href="https://github.com/wuub/SublimeREPL" target="_blank">https://github.com/wuub/SublimeREPL</a></p>

<h2><a name="sublimerope"></a>▶SublimeRope</h2>
Python用のIDE的パッケージです。Pythonライブラリの強力な自動補完、定義ジャンプ、プロジェクト生成などPythonに特化していますが、Python使いであればまず入れておくべきパッケージだと思います。

ただしその強力すぎるが故の欠点なのですが、たとえば<code>import numpy as np</code>したあとに、<code>np.</code>まで打つと、numpyのありとあらゆる関数をロードして自動補完しようとするので、数秒固まるなどのめんどくさい事例も…。

学習機能というか、しばらく使っていくと段々とキャッシュが溜まっていってくれるので、それなりに素早い動作になっていくのですが、ちょっと初期コスト高めなのでなんとかならないかなーと思っています。でもこれがないとPythonでの開発は出来ないです。
<p style="text-align: right;"><a href="https://github.com/JulianEberius/SublimeRope" target="_blank">JulianEberius/SublimeRope</a></p>

<h2><a name="trailingspaces"></a>▶TrailingSpaces</h2>
行末の余分なスペースをハイライトする機能です。

ユーザ設定で「保存時に余計なスペースを削除する」という機能はあるのですが、MarkdownやPythonを書いてると邪魔になることも多いので、オフにする代わりにこのパッケージを利用しています。
<p style="text-align: right;"><a href="https://github.com/SublimeText/TrailingSpaces" target="_blank">SublimeText/TrailingSpaces</a></p>

<h2><a name="vintageex"></a>▶VintageEx</h2>
VintageExはViモードを強化してくれるプラグインです。

具体的な使い方というのは特に無いのですが、<strong>コロン:</strong>を押すと、通常のVintageモード（Vi互換モード）ではコマンドパレットが開くのに対して、VintageExでは次の図のようにViのコマンドモードが使用可能になります。また、Tabによるコマンドの自動保管も可能です。

[caption id="attachment_3080" align="aligncenter" width="600"]<a href="http://blog.hifumi.info/wp-content/uploads/2012/10/vintageex.png"><img class="size-large wp-image-3080" title="VintageExでコマンドモードが楽に" alt="VintageExでコマンドモードが楽に" src="http://blog.hifumi.info/wp-content/uploads/2012/10/vintageex-600x429.png" width="600" height="429" /></a> VintageExでコマンドモードが楽に[/caption]
<p style="text-align: right;"><a href="https://github.com/SublimeText/VintageEx" target="_blank">https://github.com/SublimeText/VintageEx</a></p>

<h1><a name="buildsystem"></a>ビルドシステムの設定（新規追加）</h1>
ST2ではなぜかRubyやPythonはあるのにPerlのビルドシステムが設定されておらず、調べてみると、Command+Bからそのままプログラムをビルドするためには、<code>*.sublime-build</code>というJSONファイルが必要なようでした。

Perlを例にすると、まず<code>Perl.sublime-build</code>というファイルを<code>Packages/Perl</code>ディレクトリ中に作成します（ST2→Preferences→Browse Packages...）。中身は次のようにします。
<pre>{
    "cmd": ["perl", "-w", "$file"],
    "file_regex": ".* at (.*) line ([0-9]*)",
    "selector": "source.perl"
}</pre>
最後に保存すると、Command+BでPerlプログラムがビルドできるようになります。
<p style="text-align: right;"><a href="http://www.perlmonks.org/?node_id=935014" target="_blank">Perl Build System File for sublime text editor</a></p>

<h1><a name="impression"></a>雑感（どうでもいい話）</h1>
ST2はWindows/Mac/Linuxで利用可能という、テキストエディタ界には実は数少ないクロスプラットフォームなソフトウェアです。Vim/Emacsの２大巨頭はクロスプラットフォームなエディタとしてまず思い浮かびますが、その他に有力なものが思いつかなかったりします（情弱なだけかも…）

そもそも、色んなジャンルを見渡しても、クロスプラットフォームって意外と少ないかもしれませんね。そういう意味でも、このSublime Text 2というのは結構異色のエディタなのかなあと思います。

どうも普通のテキストエディタとしても使えるし、その気になればIDE化させることも出来るということで、拡張性の高い多機能さも売りの１つのようです。ちなみに起動した瞬間の第１印象は、「茶色い時代のUbuntu」でした。単にデフォルト背景のこげ茶色といい、色合いのこなれた感じといい、わたしの勝手なUbuntu象に重なったというか…。

あと、設定変更するのがダイアログ表示じゃなくてJSONファイルを開いて書き込ませるという方式も、好きな人は好きそうです。玄人好み、といった感じ。

まだまだ使い始めて間もないのでハッキリと「これはいい！」みたいな太鼓判は押せませんが、Vim風コーディングもEmacs風コーディングも可能ということで、古くからのPCユーザへの配慮もあり、色々こだわっているところが多いので、期待できるエディタです。
<h1>参考</h1>
<ul>
	<li><a title="Sublime Text 2 のススメ : Tender Surrender" href="http://blog.agektmr.com/2012/05/sublime-text-2.html" target="_blank">Sublime Text 2 のススメ</a></li>
	<li><a title="Sublime Text 2 for Emacsers : Speaker Deck" href="http://speakerdeck.com/u/kentaro/p/sublime-text-2-for-emacsers" target="_blank">Sublime Text 2 for Emacsers</a></li>
	<li><a title="Sublime Text2 で(p)LaTeX文書を扱う : パイ生地みたいにふくらんで。" href="http://wiki.livedoor.jp/fuhmi/d/TeX%A4%CB%B4%D8%A4%B9%A4%EB%B3%D0%A4%A8%BD%F1%A4%AD#content_16" target="_blank">Sublime Text2 で(p)LaTeX文書を扱う</a></li>
	<li><a title="知らない人は遅れてる？新Zen-Coding Emmet : DECONCEPTER" href="http://log.deconcepter.jp/2012/10/emmet/" target="_blank">知らない人は遅れてる？新Zen-Coding Emmet</a></li>
	<li><a title="Font Settings - Sublime Text 2 Documentation" href="http://www.sublimetext.com/docs/2/font.html  " target="_blank">Font Settings - Sublime Text 2 Documentation</a></li>
	<li><a title="SublimeText/VintageEx" href="https://github.com/SublimeText/VintageEx" target="_blank">SublimeText/VintageEx - GitHub</a></li>
	<li><a title="wuub/SublimeREPL - GitHub" href="https://github.com/wuub/SublimeREPL" target="_blank">wuub/SublimeREPL - GitHub</a></li>
	<li><a title="The Greatest tool for sorting CSS properties in specific order " href="http://csscomb.com/" target="_blank">The Greatest tool for sorting CSS properties in specific order</a></li>
	<li><a title="CSSComb | MOL" href="http://t32k.me/mol/log/csscomb/" target="_blank">CSScomb - MOL</a></li>
	<li><a href="http://codedehitokoto.blogspot.jp/2012/04/sublimetext2markdown.html" target="_blank">SublimeText2でMarkdownをプレビューするプラグイン</a></li>
</ul>
