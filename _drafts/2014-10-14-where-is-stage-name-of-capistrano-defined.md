---
layout: post
date: 2014-10-14 07:55:39 +0900
title: Capistrano 3のstageはどこで定義されてるの？
tags: 
- capistrano
---
[capistrano-withrsyncを使ってVagrantで構築したVMにデプロイする](/2014/10/14/capistrano-withrsync/)というエントリを書いた時に分からなかったことがあった．

Capistrano 3の利用の際，`config/deploy/vagrant.rb`というファイルを置いたら，`cap vagrant deploy`が出来るようになったが，このstage名はどこで定義されているのだろう．
ファイルとコマンドから`<stage name>.rb`という推理を得たが，果たしてどこで実装されているのだろう．


- https://github.com/capistrano/capistrano/tree/v3.2.1
- https://github.com/capistrano/capistrano/blob/v3.2.1/lib/capistrano/setup.rb#L9-L20
- `stage_config_path`
- `include Capistrano::DSL`
- https://github.com/capistrano/capistrano/blob/v3.2.1/lib/capistrano/dsl/stages.rb
- https://github.com/capistrano/capistrano/blob/v3.2.1/lib/capistrano/dsl/stages.rb#L9-L11
  - stage_config_path
- https://github.com/capistrano/capistrano/blob/v3.2.1/lib/capistrano/dsl/stages.rb#L5-L7
  - stages
- https://github.com/capistrano/capistrano/blob/v3.2.1/lib/capistrano/dsl/paths.rb#L31-L33
  - Pathname

## 終わりに


## 参考

- [capistrano/capistrano](https://github.com/capistrano/capistrano)
