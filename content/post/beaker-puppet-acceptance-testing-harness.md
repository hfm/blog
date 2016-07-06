---
date: 2016-07-01T08:23:31+09:00
title: Beaker による Puppet モジュールの受け入れテスト
draft: true
tags:
- puppet
- testing
---
最近、Puppet モジュールを書く機会が増えた。勤務先では9年以上 Puppet を活用しており、提供サービスも複数あることから、どうしてもモジュールが局所化してしまうという懸念があった。共通化できそうなものはなるべくモジュールしていこうと率先するため、モジュールを OSS 化していっている。

Puppet のコミュニティである [Puppet Forge](https://forge.puppet.com/) には、様々なサードパーティ製のモジュールがある。正直モジュール数は多くないが、質の良いものも多く、内製するよりもコストを下げられるメリットがある。

機会が増えてくると、必然的にテストを書く機会・時間も増えてきた。構成管理ツールのテストの代表的プロダクトといえば Serverspec はまず挙がると思う。

Puppet モジュールの雛形生成には `puppet module generate` コマンドを使う。メタデータに関する対話的な手続きは、あとから metadata.json を編集すればよいので、--skip-interview オプションで省略する。

```console
$ puppet module generate hfm-toml --skip-interview

Notice: Generating module at /path/to/toml...
Notice: Populating templates...
Finished; module generated in toml.
toml/examples
toml/examples/init.pp
toml/Gemfile
toml/manifests
toml/manifests/init.pp
toml/metadata.json
toml/Rakefile
toml/README.md
toml/spec
toml/spec/classes
toml/spec/classes/init_spec.rb
toml/spec/spec_helper.rb
```

生成されたファイルとそのレイアウトについては、本記事の主題ではないため [Module layout](https://docs.puppet.com/puppet/latest/reference/modules_fundamentals.html#module-layout) に解説を譲る。

今回は spec ディレクトリ以下を見ていく。

Beaker
---

Beaker は Puppet 社 [^2] が開発している受け入れテストツールである。

- [puppetlabs/beaker: Puppet Acceptance Testing Harness](https://github.com/puppetlabs/beaker)

Beaker には以下のフェーズが存在する。コンテナやVMを立ち上げ、Puppetを適用し、テストを実行し、結果を確認したのちに立ち上げたコンテナやVMを削除する、といった流れだ。

* Provisioning
* Validation
* Configuration
* Testing
* Tests
* Post-Suite
* Reverting
* Cleanup


Chef でいう Test Kitchen + InSpec といったところで、VMのセットアップからプロビジョニングやテスト実行、事後処理などを一気通貫で行ってくれる。

[^2]: 最近 Puppetlabs から社名変更した
