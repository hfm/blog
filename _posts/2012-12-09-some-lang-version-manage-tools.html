---
layout: post
title: プログラミング言語のバージョン管理ツールまとめ
categories:
- Dev
- Mac
tags:
- node
- perl
- php
- Python
- Ruby
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _thumbnail_id: '3548'
  dsq_thread_id: '1224951268'
  _ogp__open_graph_pro: a:3:{s:8:"use_page";s:0:"";s:4:"type";s:7:"article";s:9:"fb_admins";s:0:"";}
  _aioseop_keywords: ruby,perl,python,node,php,バージョン管理,perlbrew,rbenv,pythonbrew,phpenv,nodebrew
  _aioseop_description: Perl, Ruby, Python, PHP, Node.jsのプログラミング言語バージョン管理ツールであるperlbrew,
    rbenv, pythonbrew, phpenv, nodebrewの紹介です。
  _aioseop_title: プログラミング言語のバージョン管理ツールまとめ
---
<h1>"clear to find"な
LL言語バージョン管理を目指して</h1>
<h2>プログラミング言語のバージョン互換性問題</h2>
MacやLinux/Unixを使用していると、<a title="P言語 - Wikipedia" href="http://ja.wikipedia.org/wiki/P%E8%A8%80%E8%AA%9E" target="_blank">P言語</a>やRubyといったLL言語のバージョンに悩まされることがしばしばあります。特にMacでは最新のものよりちょっと古いバージョンが多いので困ります。OS X Mountain Lionの時点でRubyはなんと1.8.7-p.358、Pythonは2.7.2です。古い…。

システム標準以外のバージョンを使いたい、しかしそのような別バージョンが必要となる場合、次のような心配があります。
<h3>懸念</h3>
<ul>
	<li><span class="lang:default decode:true  crayon-inline ">/bin</span> 等のシステムへの直接変更はなるべく避けたい<span style="font-size: x-small;">（OS標準のものをアプデするとか悲鳴モノ…）</span></li>
	<li><span class="crayon-inline">/usr/local</span>や<span class="crayon-inline">/opt</span>以下に<span class="crayon-inline">/bin</span>や<span class="crayon-inline">/lib</span>を二次展開したい<span style="font-size: x-small;">（インストールにsudoとか正直勘弁）</span></li>
	<li><span class="crayon-inline">$HOME</span>以下への展開も悪くはない</li>
</ul>
<h2>複数のLL言語バージョンを一括管理する</h2>
こういう時に便利なのが<strong>バージョン（インストール）管理ツール</strong>です。

バージョン管理ツールは、yumやapt-get等に代表される<a href="http://ja.wikipedia.org/wiki/%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0">パッケージ管理システム</a>の各プログラミング言語に特化したツールです。各プログラミング言語が持つ複数バージョンの導入と削除、そしてcpanやrubygem等のライブラリ管理ツールの依存関係の管理を一手に任せられる便利なツールです。

今回はPerl, Ruby, Python, PHP, Node.jsのバージョン管理ツールを列挙し、インストールや簡単な使い方についてまとめてみました。また、愛用するテキストエディタSublime Text 2との連携についても、一部のツールに関しては言及しています。
<h2>想定する開発環境</h2>
<ul>
	<li>OS X (Lion | Mountain Lion)<sup>※</sup></li>
	<li>Homebrew (一部で使用する)</li>
</ul>
Homebrewを一部で利用します。<a title="Mac デ Homebrew ノススメ" href="http://blog.hifumi.info/mac/mac-%e3%83%87-homebrew-%e3%83%8e%e3%82%b9%e3%82%b9%e3%83%a1/" target="_blank">以前このブログで書いたHomebrewのMacへの導入記事</a>などを参考に、前もってHomebrewをインストールしてください。

<sup>※</sup>Linux/Unixにおいても手順に若干の差はありますがインストールは可能だと思います。

<!--more-->
<h1>目次</h1>
<ul>
	<li><a href="#perlbrew">perlbrew</a>
<ul>
	<li><a href="#install_perlbrew">導入</a></li>
	<li><a href="#howto_perlbrew">perlbrewの用法用量</a></li>
</ul>
</li>
	<li><a href="#rbenv">rbenv</a>
<ul>
	<li><a href="#install_rbenv">導入</a></li>
	<li><a href="#howto_rbenv">rbenvの用法用量</a></li>
	<li><a href="#rbenv_mountainlion">Mountain Lionと1.8系</a></li>
	<li><a href="#rbenv_sublimetext2">rbenv×Sublime Text 2</a></li>
	<li><a href="#rbenv_freebsd">（おまけ）FreeBSDでrbenv</a></li>
</ul>
</li>
	<li><a href="#pythonbrew">pythonbrew</a>
<ul>
	<li><a href="#install_pythonbrew">導入</a></li>
	<li><a href="#howto_pythonbrew">pythonbrewの用法用量</a></li>
	<li><a href="#pythonbrew_sublimetext2">pythonbrew×Sublime Text 2</a></li>
</ul>
</li>
	<li><a href="#phpenv">phpenv</a>
<ul>
	<li><a href="#install_phpenv">導入</a></li>
	<li><a href="#howto_phpenv">phpenvの用法用量</a></li>
</ul>
</li>
	<li><a href="#nodebrew">nodebrew</a>
<ul>
	<li><a href="#install_nodebrew">導入</a></li>
	<li><a href="#howto_nodebrew">nodebrewの用法用量</a></li>
	<li><a href="#nodebrew_sublimetext2">nodebrew×Sublime Text 2</a></li>
</ul>
</li>
</ul>
<h1><a name="perlbrew"></a>perlbrew (Perl)</h1>
<a href="http://blog.hifumi.info/wp-content/uploads/2012/12/54496.png"><img class="alignleft size-thumbnail wp-image-3549" alt="perlbrew" src="http://blog.hifumi.info/wp-content/uploads/2012/12/54496-200x200.png" width="200" height="200" /></a>perlbrewはperlのインストール管理ツールです。perlのバージョンインストールの他、インストールしたバージョンごとにcpan(m)などの管理をすることが出来ます。
<p class="clearfix">インストールディレクトリは$HOME/perl5/ で、perlbrewを通して入手したcpanmやその他パッケージも同様のディレクトリ以下で管理されます。</p>

<h2><a name="install_perlbrew"></a>導入</h2>
次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">curl -kL http://install.perlbrew.pl | bash
perlbrew init</pre>
<h3>環境設定（bash/zsh同様）</h3>
<span class="lang:default decode:true crayon-inline">$HOME/.bash_profile</span>あるいは<span class="lang:default decode:true crayon-inline">$HOME/.zshrc</span>に以下を追記します。
<pre class="toolbar:2 lang:default decode:true"># perlbrew
if which perlbrew &gt; /dev/null; then
    source "$HOME/perl5/perlbrew/etc/bashrc"
fi</pre>
<h2><a name="howto_perlbrew"></a>perlbrewの用法用量</h2>
perlbrewには次のようなコマンドがあります。
<pre class="lang:default decode:true" title="perlbrewのコマンド例"># 指定バージョンのPerlをインストールする
perlbrew install 5.17.6

# 利用可能なPerlのバージョン一覧を表示する
perlbrew available
i perl-5.17.6
  perl-5.16.2
  perl-5.14.3
  ...

# 標準で使うPerlのバージョンを指定する
perlbrew switch 5.17.6

# 現在のシェルでのみPerlのバージョンを切り替える
perlbrew use 5.17.6

# インストール済のPerlバージョン一覧（使用中のバージョンを強調表示）
perlbrew list
  perl-5.16.1
* perl-5.17.6

# 現在のシェルでのみPerlbrewの一時無効化
perlbrew off

# インストール済のPerlバージョンを削除する
perlbrew uninstall 5.17.6

# その他
perlbrew install-cpanm
perlbrew install-ack</pre>
<h2>参考URL</h2>
<ul>
	<li><a href="http://perlbrew.pl/">http://perlbrew.pl/</a></li>
	<li><a href="http://d.hatena.ne.jp/pasela/20110703/perlbrew">http://d.hatena.ne.jp/pasela/20110703/perlbrew</a></li>
</ul>
<h1><a name="rbenv"></a>rbenv (Ruby)</h1>
<a href="http://blog.hifumi.info/wp-content/uploads/2012/12/54494.png"><img class="alignleft size-thumbnail wp-image-3551" alt="rbenv" src="http://blog.hifumi.info/wp-content/uploads/2012/12/54494-200x200.png" width="200" height="200" /></a>rbenvはalternative <a href="https://rvm.io/">rvm</a>なRubyバージョン管理ツールです。導入した複数のRubyバージョンを管理し、コマンドによって切り替えるというシンプルな機能を提供しています。

rbenvそれそのものはRubyの管理・切替機能であり、特定バージョンのインストール（コンパイル）にはruby-buildを使います。
<p class="clearfix">MacではHomebrewを使うため、インストールディレクトリは<span class="lang:default decode:true crayon-inline">/usr/local/Cellar/rbenv</span>で、rbenvを通じて入手したRubyバージョンやgem、その他パッケージは<span class="lang:default decode:true crayon-inline">$HOME/.rbenv/</span>以下で管理されます。</p>

<h2><a name="install_rbenv"></a>導入</h2>
次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">brew install rbenv ruby-build</pre>
※ruby-buildのdepsにrbenvが指定されているので、ruby-buildだけをインストール指定しても問題ありません。
<h3>環境設定（bashの場合）</h3>
<span class="lang:default decode:true crayon-inline">.bash_profile</span>に以下を追記します。
<pre class="lang:default decode:true" title="$HOME/.bash_profile"># initialize for rbenv at bash
if which rbenv &gt; /dev/null;
    then eval "$(rbenv init -)";
    source brew --prefix rbenv&lt;/code&gt;/completions/rbenv.bash;
fi</pre>
<h3>環境設定（zshの場合）</h3>
<span class="lang:default decode:true crayon-inline">.zshrc</span>に以下を追記します。
<pre class="lang:default decode:true" title="$HOME/.zshrc"># initialize for rbenv at zsh
if which rbenv &gt; /dev/null; then
    eval "$(rbenv init - zsh)"
    source brew --prefix rbenv&lt;/code&gt;/completions/rbenv.zsh;
fi</pre>
<h2><a name="howto_rbenv"></a>rbenvの用法用量</h2>
rbenvには次のようなコマンドがあります。
<pre class="lang:default decode:true" title="rbenvのコマンド例"># 指定バージョンのRubyをインストールする
rbenv install 1.9.3-p327
rbenv install 2.0.0-dev

# 利用可能なRubyのバージョン一覧を表示する
rbenv install -l
Available versions:
  1.8.6-p383
  1.8.6-p420
  1.8.7-p249
  ...

# 標準で使うRubyのバージョンを指定する
rbenv global 1.9.3-p327

# 指定後はrehashして設定を更新しなければならない
rbenv rehash

# インストール済のRubyバージョン一覧（使用中のバージョンを強調表示）
rbenv versions
* 1.9.3-p327 (set by /Users/hoge/.rbenv/version)
  2.0.0-dev

# インストール済のRubyバージョンを削除する
rbenv uninstall 2.0.0-dev
rbenv: remove /Users/hoge/.rbenv/versions/2.0.0-dev? [y/n]</pre>
<h2><a name="rbenv_mountainlion"></a>Mountain Lionと1.8系</h2>
Mac OS X 10.8系にruby1.8系を導入しようとすると、次のようなエラーが出ます。
<pre class="toolbar:2 lang:default decode:true">/usr/include/tk.h:78:23: fatal error: X11/Xlib.h: No such file or directory
compilation terminated.</pre>
これはMountain LionからXQuartzがオプションインストールに降格し、ディレクトリパスが変更されたことによって起きるエラーのようです。これを解決するには、まず<a href="http://xquartz.macosforge.org/landing/" target="_blank">XQuartzをインストール</a>し、rbenvからruby1.8系のインストール前に、シェル上で次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">export CPPFLAGS=-I/opt/X11/include</pre>
上記の一文は、次のコマンドを実行して<code>.zprofile</code>に追記しておいてもいいと思います。
<pre class="toolbar:2 lang:default decode:true">echo 'export CPPFLAGS=-I/opt/X11/include' &gt;&gt; .zprofile</pre>
<h2><a name="rbenv_sublimetext2"></a>rbenv × Sublime Text 2</h2>
<code>Ruby.sublime-build</code>というファイルが<code>Packages/Ruby/</code>中にあります（ST2→Preferences→Browse Packages...）ので、その中身を次のように修正してください。
<pre class="lang:default decode:true" title="$SUBLIME_HOME/Packages/Ruby/Ruby.sublime-build">{
//    "cmd": ["ruby", "$file"],
    "cmd": ["/Users/USERNAME/.rbenv/shims/ruby", "$file"],
    "file_regex": "^(...*?):([0-9]*):?([0-9]*)",
    "selector": "source.ruby"
}</pre>
<h2><a name="rbenv_freebsd"></a>（おまけ）FreeBSDでrbenv</h2>
FreeBSDでrbenvとruby-buildを入れるためにはPorts Collectionを使います。
<pre class="lang:default decode:true" title="FreeBSDでrbenvをインストールする">cd /usr/ports/devel/rbenv/
sudo make install clean #ruby-buildも一緒に入る
rehash</pre>
これでrbenvの導入は完了です。次にZshを利用している場合において、rbenvの補完機能を有効化します。
<pre class="lang:sh decode:true" title="Zshでrbenvの補完を有効化">mkdir -p ~/.rbenv/completions/
ln -s /usr/local/share/rbenv/completions/rbenv.zsh ~/.rbenv/completions/rbenv.zsh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' &gt; ~/.zshrc
echo 'source $HOME/.rbenv/completions/rbenv.zsh' &gt; ~/.zshrc
source ~/.zshrc</pre>
これによって、rbenvの補完機能が有効化されます。<span class="crayon-inline">rbenv install [tab]</span>でインストール可能なバージョンの補完が働いたり、<span class="crayon-inline crayon-selected">rbenv global [tab]</span>でインストール済みのバージョンが補完されたりするようになります。
<h2>参考URL</h2>
<ul>
	<li><a href="https://github.com/sstephenson/rbenv">sstephenson / rbenv</a></li>
	<li><a href="https://gist.github.com/3186304">Installing Ruby 1.8.7-p358 with rbenv on Mountain Lion</a></li>
	<li><a href="http://kiwidev.wordpress.com/2012/05/29/sublime-text-2-rbenv-osx-and-the-build-command/">Sublime Text 2, rbenv, osx and the build command</a></li>
</ul>
<h1><a name="pythonbrew"></a>pythonbrew (Python)</h1>
<a href="http://blog.hifumi.info/wp-content/uploads/2012/12/54497.png"><img class="alignleft size-thumbnail wp-image-3550" alt="pythonbrew" src="http://blog.hifumi.info/wp-content/uploads/2012/12/54497-200x200.png" width="200" height="200" /></a>pythonbrewはPythonを自動ビルドし、インストール、管理するためのプログラムです。p<a href="https://github.com/utahta/pythonbrew#overview">erlbrewとrbenvに影響を受けているとのこと</a>です。
<p class="clearfix">インストールディレクトリは<code>$HOME/.pythonbrew</code>で、pythonbrewを通じて入手したpipやその他パッケージも同様のディレクトリ以下で管理されます。</p>

<h2><a name="install_pythonbrew"></a>導入</h2>
次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">brew install python
pip install pythonbrew
/usr/local/share/python/pythonbrew_install</pre>
あるいは次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">curl -kL http://xrl.us/pythonbrewinstall | bash</pre>
<h2><a name="howto_pythonbrew"></a>pythonbrewの用法用量</h2>
pythonbrewには次のようなコマンドがあります。
<pre class="lang:default decode:true" title="pythonbrewのコマンド例"># 指定バージョンのPythonをインストールする
pythonbrew install 3.2.3

# 利用可能なPythonのバージョン一覧を表示する
pythonbrew list -k
# Pythons
Python-1.5.2
Python-1.6.1
Python-2.0.1
...

# 標準利用するPythonのバージョンを切り替える
pythonbrew switch 3.2.3

# 現在のシェルでのみPythonのバージョンを切り替える
pythonbrew use 3.2.3

#  インストール済のPythonバージョン一覧（使用中のバージョンを強調表示）
pythonbrew list
# pythonbrew pythons
  Python-2.7.3 (*)
  Python-3.2.3

# Pythonbrewの一時無効化
pythonbrew off

# インストール済のPythonバージョンを削除する
pythonbrew uninstall 3.2.3</pre>
<h2><a name="pythonbrew_virtualenv"></a>pythonbrew venvを使う(virtualenv)</h2>
pythonbrewにはvirtuarenvを扱える<code>pythonbrew venv</code>というコマンドが用意されています。

virtualenvはPythonの仮想環境を作成し、プロジェクト毎にライブラリ等を管理出来るツールです。普通はpipやeasy_installからインストール剃る必要がありますが、pythonbrewを導入しておけば同時に利用することができます。
<pre class="lang:default decode:true" title="pythonbrew venvのコマンド例"># 初期化
pythonbrew venv init

# プロジェクトの作成
pythonbrew venv create hogeproj

# プロジェクトの一覧表示
pythonbrew venv list
# virtualenv for Python-2.7.3 (found in /Users/USER/.pythonbrew/venvs/Python-2.7.3)
hogeproj

# プロジェクトの仮想環境に入る
pythonbrew venv use proj

# 仮想環境から出る
deactivate</pre>
pythonbrew venvによって管理されるプロジェクトのディレクトリツリーは次のようになります。
<pre class="toolbar:2 lang:default decode:true">$HOME/.pythonbrew/venvs/
├── Python-2.7.3
│   ├── fuga
│   │   ├── bin
│   │   ├── include
│   │   └── lib
│   └── hoge
│       ├── bin
│       ├── include
│       └── lib
└── Python-3.2.3
    ├── fuga3
    │   ├── bin
    │   ├── include
    │   └── lib
    └── hoge3
        ├── bin
        ├── include
        └── lib</pre>
バージョン毎にプロジェクトディレクトリが生成されていくのでとても分かりやすいです。
<h2><a name="pythonbrew_sublimetext2"></a>pythonbrew × Sublime Text 2</h2>
<h3>$HOME/.rbenv/shimsのようなシンボリックリンクを生成させる</h3>
<a href="https://twitter.com/ogomr">@ogomr</a>さんが<a href="http://qiita.com/">Qiita</a>で公開されている<a href="http://qiita.com/items/ad35087fc86fd1efa486" target="_blank">Sublime Text で pythonbrew</a>がとても参考になりました。

$HOME/.pythonbrew/scripts/pythonbrew/commands/switch.py とuse.py を次のように置き換えます（元々のコードに、<a href="http://qiita.com/items/ad35087fc86fd1efa486" target="_blank">先のリンク</a>の指示に従って追記したものです）。
<pre class="lang:python decode:true" title="switch.py">import os
import sys
from pythonbrew.basecommand import Command
from pythonbrew.define import PATH_PYTHONS
from pythonbrew.util import Package, set_current_path, is_installed
from pythonbrew.log import logger

class SwitchCommand(Command):
    name = "switch"
    usage = "%prog VERSION"
    summary = "Permanently use the specified python as default"

    def run_command(self, options, args):
        if not args:
            self.parser.print_help()
            sys.exit(1)

        pkg = Package(args[0])
        pkgname = pkg.name
        if not is_installed(pkgname):
            logger.error("<code>%s</code> is not installed." % pkgname)
            sys.exit(1)
        pkgbin = os.path.join(PATH_PYTHONS,pkgname,'bin')
        pkglib = os.path.join(PATH_PYTHONS,pkgname,'lib')

        set_current_path(pkgbin, pkglib)

        logger.info("Switched to %s" % pkgname)

        path = os.path.abspath(os.path.join(PATH_PYTHONS, '..', 'current'))
        if os.path.isdir(path):
            os.unlink(path)
        os.symlink(os.path.abspath(os.path.join(PATH_PYTHONS, pkgname)), path)

SwitchCommand()</pre>
<pre class="lang:python decode:true" title="use.py">import os
import sys
from pythonbrew.basecommand import Command
from pythonbrew.define import PATH_PYTHONS, PATH_HOME_ETC_TEMP
from pythonbrew.util import Package
from pythonbrew.log import logger

class UseCommand(Command):
    name = "use"
    usage = "%prog VERSION"
    summary = "Use the specified python in current shell"

    def run_command(self, options, args):
        if not args:
            self.parser.print_help()
            sys.exit(1)

        pkg = Package(args[0])
        pkgname = pkg.name
        pkgdir = os.path.join(PATH_PYTHONS, pkgname)
        if not os.path.isdir(pkgdir):
            logger.error("<code>%s</code> is not installed." % pkgname)
            sys.exit(1)
        pkgbin = os.path.join(pkgdir,'bin')
        pkglib = os.path.join(pkgdir,'lib')

        self._set_temp(pkgbin, pkglib)

        path = os.path.abspath(os.path.join(PATH_PYTHONS, '..', 'current'))
        if os.path.isdir(path):
            os.unlink(path)
        os.symlink(os.path.abspath(os.path.join(PATH_PYTHONS, pkgname)), path)

        logger.info("Using <code>%s</code>" % pkgname)

    def _set_temp(self, bin_path, lib_path):
        fp = open(PATH_HOME_ETC_TEMP, 'w')
        fp.write('deactivate &amp;&gt; /dev/nullnPATH_PYTHONBREW_TEMP="%s"nPATH_PYTHONBREW_TEMP_LIB="%s"n' % (bin_path, lib_path))
        fp.close()

UseCommand()</pre>
これで<code>pythonbrew switch | use</code>コマンドからcurrentというシンボリックリンクが生成されるようになります。

次はST2のPythonのビルド環境変数をcurrentに変更します。<code>Packages/Python/Python.sublime-build</code>を次のように置き換えます。
<pre class="lang:default decode:true" title="$SUBLIME_HOME/Packages/Python/Python.sublime-build">{
    "cmd": ["python", "-u", "$file"],
    "file_regex": "^[ ]*File "(...*?)", line ([0-9]*)",
    "selector": "source.python"
    "path": "/Users/USERNAME/.pythonbrew/current/bin:/usr/bin:/bin:/usr/sbin:/sbin"
}</pre>
これでST2で使用されるPythonがpythonbrewによって管理されているバージョンへと変更されるようになりました。
<h3>virtualenv × Sublime CodeIntel</h3>
<a href="http://matthewphiong.com/sublime-codeintel-configuration-for-virtualenv">Sublime CodeIntel Configuration for virtualenv</a>によると、Sublime CodeIntelを使用していて、かつvirtualenvを使用したい場合にはSublime CodeIntelのconfigファイル（$HOME/.codeintel/config あるいは$PROJECT_ROOT/.codeintel/config ）に次のような文を追記しなければならないようです。

https://gist.github.com/matthewphiong/1361735
<h2>参考URL</h2>
<ul>
	<li><a href="https://github.com/utahta/pythonbrew">utahta / pythonbrew</a></li>
	<li><a href="http://www.ninxit.com/blog/2010/10/04/python%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%82%92%E7%AE%A1%E7%90%86%E3%81%99%E3%82%8B%E3%83%84%E3%83%BC%E3%83%AB%E3%80%81pythonbrew%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%A6%E3%81%BF/">Pythonのバージョンを管理するツール、pythonbrewを作ってみた</a></li>
	<li><a href="http://matthewphiong.com/sublime-codeintel-configuration-for-virtualenv">Sublime CodeIntel Configuration for virtualenv</a></li>
</ul>
<h1><a name="phpenv"></a>phpenv</h1>
<a href="http://blog.hifumi.info/wp-content/uploads/2012/12/54500.png"><img class="alignleft size-thumbnail wp-image-3552" alt="phpenv" src="http://blog.hifumi.info/wp-content/uploads/2012/12/54500-200x200.png" width="200" height="200" /></a>phpenvはrbenvを流用したPHPのバージョン管理ツールです。rbenvと全く同じコマンドです（ただし、十分に整備されているとは言いがたいですが…）。rbenv同様にphpenvはPHPの管理・切替機能であり、特定バージョンのインストール（コンパイル）にはphp-buildを使います。

ただしphpenv + php-buildの組み合わせにはrbenv installに相当するものが用意されていません。そこで、後述の有志の方によるphpenv-installスクリプトを導入してphpenv install出来るように設定しましょう。
<p class="clearfix">インストールディレクトリは<span class="lang:default decode:true crayon-inline">$HOME/.phpenv</span>でphpenvを通じて入手したPyrusやその他パッケージも同様のディレクトリ以下で管理されます。</p>

<h2><a name="install_phpenv"></a>導入</h2>
次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">brew tap josegonzalez/php
brew install --HEAD phpenv
brew install php-build</pre>
<h3>環境設定</h3>
<h4>rbenvを利用している場合</h4>
<blockquote>For rbenv users: Make sure that ~/.rbenv/bin takes precedence in the PATH over ~/.phpenv/bin by placing it before, so rbenv gets used from ~/.rbenv.
<p style="text-align: right;"><a href="https://github.com/CHH/phpenv">https://github.com/CHH/phpenv</a></p>
</blockquote>
rbenvの利用者は、rbenvのパスをphpenvのパスよりも先に設定しなければなりません。まず次のコマンドを実行します（Zshの場合）。
<pre class="toolbar:2 lang:default decode:true">echo 'export PATH=$HOME/.phpenv/bin:$HOME/.rbenv/bin:$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH' &gt;&gt; .zprofile</pre>
そして<span class="lang:default decode:true crayon-inline">.zshrc</span>に次の文を追記します。
<pre class="lang:default decode:true" title="$HOME/.zshrc"># phpenv
if which phpenv &gt; /dev/null; then
    eval "$(phpenv init - zsh)"
    source $HOME/.rbenv/completions/rbenv.zsh"
fi</pre>
<h4>rbenvを利用していない場合</h4>
まず次のコマンドを実行します（Zshの場合）。
<pre class="toolbar:2 lang:default decode:true">echo 'export PATH=$HOME/.phpenv/bin:$PATH' &gt;&gt; .zprofile</pre>
そして<span class="lang:default decode:true crayon-inline">.zshrc</span>に次の文を追記します。
<pre class="lang:default decode:true" title="$HOME/.zshrc"># phpenv
if which phpenv &gt; /dev/null; then
    eval "$(phpenv init - zsh)"
    source $HOME/.rbenv/completions/rbenv.zsh"
fi</pre>
<h4>（両者共通）php-installを導入する</h4>
phpenv(+php-build)は、rbenvにある<code>rbenv install</code>に相当する<code>phpenv install</code>がありません。

これを解決するためには、有志の人が作成されたphpenv-installスクリプトを
<pre class="lang:default decode:true" title="phpenvのプラグインインストール場所">$HOME/.phpenv/libexec/</pre>
にインストールします。
<pre class="lang:default decode:true" data-url="https://gist.github.com/raw/1305922/15cc747ba1ef11212c52218232e87aae3f603d79/rbenv-install">#!/usr/bin/env bash
set -e
[ -n "$RBENV_DEBUG" ] &amp;&amp; set -x

# Provide rbenv completions
if [ "$1" = "--complete" ]; then
  exec php-build --definitions
fi

if [ -z "$RBENV_ROOT" ]; then
  RBENV_ROOT="${HOME}/.phpenv/libexec"
fi

DEFINITION="$1"
case "$DEFINITION" in
"" | -* )
  { echo "usage: phpenv install VERSION"
    echo
    echo "Available versions:"
    php-build --definitions | sed 's/^/  /'
    echo
  } &gt;&amp;2
  exit 1
  ;;
esac

VERSION_NAME="${DEFINITION##*/}"
PREFIX="${RBENV_ROOT}/versions/${VERSION_NAME}"

php-build "$DEFINITION" "$PREFIX"
phpenv rehash</pre>
<p style="text-align: right;">参考：<a href="https://gist.github.com/1305922" target="_blank">yuya-takeyama / README.md - https://gist.github.com/1305922</a></p>
上記のスクリプトを自分の<code>$HOME/.phpenv/libexec/</code>にインストールするためには次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">curl https://raw.github.com/gist/1305922/15cc747ba1ef11212c52218232e87aae3f603d79/rbenv-install -o $HOME/.phpenv/libexec/rbenv-install chmod 755 $HOME/.phpenv/libexec/rbenv-install</pre>
<h2><a name="howto_phpenv"></a>phpenvの用法用量</h2>
基本的にはrbenvと全く同じです。先述のphpenv installに関してのみ素の状態では使用できないのでご注意ください。
<h2>参考URL</h2>
<ul>
	<li><a href="https://github.com/CHH/phpenv">https://github.com/CHH/phpenv</a></li>
</ul>
<h1><a name="nodebrew"></a>nodebrew</h1>
nodebrewはNode.jsのパッケージ管理ツールです。セットアップにperlを使います。

インストールディレクトリは<span class="lang:default decode:true crayon-inline">$HOME/.nodebrew</span>で、nodebrewを通して入手したnpmやその他パッケージも同様のディレクトリ以下で管理されます。
<h2><a name="install_nodebrew"></a>導入</h2>
次のコマンドを実行します。
<pre class="toolbar:2 lang:default decode:true">curl https://raw.github.com/hokaccha/nodebrew/master/nodebrew | perl - setup</pre>
<h3>環境設定</h3>
次のコマンドを実行します（Zshの場合）。
<pre class="toolbar:2 lang:default decode:true">echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' &gt;&gt; .zprofile
echo 'export NODEBREW_ROOT=$HOME/.nodebrew' &gt;&gt; .zprofile</pre>
<h2><a name="howto_nodebrew"></a>nodebrewの用法用量</h2>
nodebrewには次のようなコマンドがあります。
<pre class="lang:default decode:true" title="nodebrewのコマンド例"># nodebrewから特定バージョンのインストールと使用
nodebrew install v0.8.5
nodebrew install stable #安定版
nodebrew install latest #開発最新版
nodebrew use v0.8.5

# リモートのインストール可能な、インストール済みの、現在使用中の各バージョンを一覧表示
nodebrew ls-all

# nodebrewのアップデート
nodebrew selfupdate

# nodebrewの特定あるいは全バージョンのアンインストール
nodebrew clean  | all</pre>
<h2><a name="nodebrew_sublimetext2"></a>nodebrew × Sublime Text 2</h2>
まずはSublime Text 2のパッケージコントロールからNode.jsを入れましょう。

<a href="https://github.com/tanepiper/SublimeText-Nodejs">tanepiper / SublimeText-Nodejs</a>

次に、Package/Nodejs/Nodejs.sublime-settingsを開いて、以下のように設定しましょう。
<pre class="lang:default decode:true" title="$SUBLIME_HOME/Package/Nodejs/Nodejs.sublime-settings">"node_command": "/Users/hfm/.nodebrew/current/bin/node",
"npm_command": "/Users/hfm/.nodebrew/current/bin/npm",</pre>
これでnodebrewで使用しているバージョンのnodeとnpmがST2でも使用できるようになりました。
<h2>参考URL</h2>
<ul>
	<li><a href="https://github.com/hokaccha/nodebrew">hokaccha / nodebrew</a></li>
	<li><a href="http://yosuke-furukawa.hatenablog.com/entry/2012/08/20/080445">Sublime Text 2 入れてみました。 - from scratch</a></li>
</ul>
