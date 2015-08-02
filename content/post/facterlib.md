---
date: 2014-10-27T21:57:25+09:00
title: 環境変数FACTERLIBについて
tags: 
- facter
---
Facterはシステムの状態を収集するツールである．
Puppet関連ツールの1つで，位置づけでいえばChefにとってのOhaiである．
コマンドラインからの実行も可能で，例えば以下のように，osに関する情報を取得することが出来る．

```rb
$ facter os
=> {"name"=>"Darwin", "family"=>"Darwin", "release"=>{"major"=>"13", "minor"=>"4", "full"=>"13.4.0"}}
```

Facterに関する詳細はドキュメント[^1][^2]に譲るとして，今回は環境変数`FACTERLIB`の話をしたい．

## FACTERLIB

Custom Factsを簡単に説明すると，Factsの拡張を自作することである．
そしてそのCustom Factsをコマンドラインから読み取る時に，環境変数`FACTERLIB`を用いる．
（もう少し正確に書くと，`$LOAD_PATH`と`FACTERLIB`，そしてPuppetの場合はpluginsync[^3]で配布されたFactsが読み込まれる）

環境変数`FACTERLIB`の使い方は以下のとおり．

```sh
FACTERLIB="/PATH/TO/FACTS" facter your_custom_fact
=> value
```

Custom Factsのあるディレクトリパスを指定すれば，簡単に呼び出せる．
PuppetでFactsの値を確かめたい時などに活用出来る．

### どこで実装されている？

`FACTERLIB`を使えばCustom Factsを呼び出せることは分かった，ではそれはどのように実現されているのだろう．

[`lib/facter/util/loader.rb#L70-91`](https://github.com/puppetlabs/facter/blob/2.2.0/lib/facter/util/loader.rb#L70-L91)に定義される`search_path`メソッドに実装を見つけた．
このメソッドに配列`search_paths`があり（メソッド名と紛らわしいが），どうやらここでパスの収集を行っているらしい．

```rb
def search_path
  search_paths = []
  search_paths += $LOAD_PATH.map { |path| File.expand_path('facter', path) }

  if @environment_vars.include?("FACTERLIB")
    search_paths += @environment_vars["FACTERLIB"].split(File::PATH_SEPARATOR)
  end
  ...
end
```

`search_paths`には，まず`$LOAD_PATH`のそれぞれの末尾に`facter`をつなげたものが入る．
そして次に，環境変数`FACTERLIB`の内容をsplitして`search_paths`に追加している．
`File::PATH_SEPARATOR`はパスの区切り文字，デリミタのことで，UNIX環境では`:`が入る[^4]．

`search_paths`はどこで使われているかというと，[loader.rb#L24-L32](https://github.com/puppetlabs/facter/blob/2.2.0/lib/facter/util/loader.rb#L24-L32)や[loader.rb#L43-L52](https://github.com/puppetlabs/facter/blob/2.2.0/lib/facter/util/loader.rb#L43-L52)あたりでpathに含まれるCustom Factsらをloadするのに用いられている．
以下にloader.rb#L43-52を示す．

```rb
paths = search_path
unless paths.nil?
  paths.each do |dir|
    # dir is already an absolute path
    Dir.glob(File.join(dir, '*.rb')).each do |path|
      # exclude dirs that end with .rb
      load_file(path) if File.file?(path)
    end
  end
end
```

`Dir.glob(File.join(dir, '*.rb'))`とあるように，`search_paths`の各パスの中にある`*.rb`なファイルを全てロードしている．

## まとめ

Facterはシステムの情報収集ツールであり，標準機能の他にCustom Factsを使って拡張が可能である．
コマンドラインからCustom Factsを利用したい場合は，環境変数`FACTERLIB`を指定し，`FACTERLIB="/PATH/TO/FACTS" facter your_custom_fact`のように使えばよい．

[^1]: https://docs.puppetlabs.com/facter/latest/
[^2]: https://docs.puppetlabs.com/facter/2.2/custom_facts.html
[^3]: https://docs.puppetlabs.com/guides/plugins_in_modules.html#enabling-pluginsync
[^4]: http://docs.ruby-lang.org/ja/2.1.0/method/File/c/PATH_SEPARATOR.html
