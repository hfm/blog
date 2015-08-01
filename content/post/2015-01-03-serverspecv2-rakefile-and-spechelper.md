---
layout: post
date: 2015-01-03 08:04:34 +0900
title: Serverspec v2用Rakefileとspec_helper.rbの紹介
tags:
- serverspec
- ruby
---
少し前の話になるんですが，[30days Album](https://30d.jp)に[Serverspec v2](http://serverspec.org)を導入しました．

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">本日、Serverspec(もちろんv2です)を導入し、インフラエンジニアが歓喜している 30days Albumでございますが、ソフトウェアエンジニアとAndroidアプリエンジニアを募集しております！ <a href="http://t.co/O8fnhArXVb">http://t.co/O8fnhArXVb</a></p>&mdash; 30days Album 写真共有・保存 (@30daysalbum) <a href="https://twitter.com/30daysalbum/status/537445879817314304">2014, 11月 26</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

せっかくなので，30days Albumで使われているServerspec用のRakefileとspec_helper.rbを簡単に紹介してみようと思います．

ちなみに，半分くらいは[@lamanotrama](https://twitter.com/lamanotrama)さんが書いていたりします．
（Serverspec v1時代にガガッと黒田さんが書いたのを，僕がv2用に合わせて書き直してます）

## Rakefile

`Rakefile`は以下のとおりです．  
※本番で使用しているものから都合上一部削っています．

```rb
require 'rake'
require 'rspec/core/rake_task'
require 'socket'

task :default do
  sh "rake -T"
end

$env = ENV['SERVERSPEC_ENV'] ||=
  case Socket.gethostname
  when /30d\.jp\z/
    'production'
  else
    'development'
  end

def role_hosts
  targets = Hash.new {|h,k| h[k] = [] }

  case $env
  when 'production'
    hosts = `awk '$1~/node/ {print $2}' manifests/node.pp | awk -F. '{print $1}' | grep -v stats | sed "s@'@@g"`.split("\n")
  when 'development'
    hosts = `awk '/^[^#]*\.vm\.define/ {print $2}' Vagrantfile | sed -E "s@(^:|\\"|')@@g"`.split("\n")
  end

  roles = hosts.map { |h| h.gsub(/\d/,'') }.sort.uniq
  hosts.each do |host|
    roles.each do |role|
      targets[role] << host if host =~ /^#{role}\d*$/
    end
  end

  targets
end

desc "Run serverspec to all hosts on #{$env}"
task :spec => role_hosts.keys.map {|role| "spec:#{role}" }

namespace :spec do
  role_hosts.each do |role, hosts|
    desc "Run serverspec to all #{role} hosts on #{role}"
    task role.to_sym => hosts.map {|host| "spec:#{role}:#{host}" }

    namespace role.to_sym do
      hosts.each do |host|
        desc "Run serverspec to #{host} on #{$env}"
        RSpec::Core::RakeTask.new(host.to_sym) do |t|
          ENV['TARGET_HOST'] = host
          t.fail_on_error = false
          t.pattern = ENV['TESTS'] || Dir.glob("spec/{base,#{role}}/*_spec.rb")
        end
      end
    end
  end
end
```

### $env

実行環境を指定しています．

`SERVERSPEC_ENV`という環境変数を使うか，もし指定がなければ，`Socket.gethostname`のドメインでproduction, development(vagrant)を判定しています．
stagingやintegration等の環境があればwhen節を増やして対応します．

### role_hosts

サーバのロールとホスト名をハッシュにして返します．
例えば`www001.30d.jp`であれば，ホスト名は`www001`となり，ロールは`www`となります．

30days AlbumではConfiguration Management ToolにPuppetを使用しているので，それに依存した設定があります．
`manifests/node.pp`の中には，例えば以下のように，どのホストにどのmanifestsを適応するかのnode情報が定義されています．

```puppet
node 'sample.30d.jp' {
  include foo
  include bar
}
```

`awk '$1~/node/ ...'`では，awkでhost名を切り出しています．

Vagrant環境では，Vagrantfileのdefine部分からホスト名を切り出しています．

特に本番環境のロール・ホスト情報の切り出しには課題があると感じており，[mackerel.io](https://mackerel.io)や[serf](https://www.serfdom.io)等を使ってもう少し上手く切り出したほうが良いかもしれません．
あるいは，Puppetを使用しているので，HieraやENC[^1]を使うのも良さそうです．

### ENV['TARGET_HOST']

`www001`といったホスト名が入ります．
これは後述するspec_helper.rbでも使用します．

### ENV['TESTS']

単体のspecを実行したい場合に`TESTS`という環境変数にファイルを指定します．

### rakeタスク

`$env`と`role_hosts`によって，以下のようにRakeタスクが定義されます．

```
$ bundle exec rake -vT
rake spec                   # Run serverspec to all hosts on production
rake spec:www               # Run serverspec to all app hosts on app
rake spec:www:app001        # Run serverspec to app001 on production
rake spec:www:app002        # Run serverspec to app002 on production
rake spec:db                # Run serverspec to all db hosts on db
rake spec:db:db001          # Run serverspec to db001 on production
rake spec:db:db002          # Run serverspec to db002 on production
rake spec:db:db003          # Run serverspec to db003 on production
```

`Rakefile`についての説明は以上です．

## spec_helper.rb

次はspec_helper.rbです．
本番環境とVagrant環境のそれぞれで実行出来るようにしています．

```rb
require 'serverspec'
require 'net/ssh'
require 'custom_property'

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST'].dup
puts "\n## Running Tests on #{host} >>>"

case ENV['SERVERSPEC_ENV']
when 'production'
  host << '.30d.lan'
  options = Net::SSH::Config.for(host)
  options[:user] = 'root'
  options[:user_known_hosts_file] = '/dev/null'
when 'development'
  require 'tempfile'
  config = Tempfile.new('', Dir.tmpdir)
  `vagrant ssh-config #{host} > #{config.path}`
  options = Net::SSH::Config.for(host, [config.path])
end

set :backend,     :ssh
set :host,        host
set :ssh_options, options
set :path,        '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

set_property custom_property
```

Serverspec v2の設定については， [Serverspec - Changes of Version 2](http://serverspec.org/changes-of-v2.html)を参考に作成しています．

### ENV['TARGET_HOST']

`Rakefile`で代入した環境変数で，`www001`や`db001`といったホスト名が入っています．
`host`変数にこれを代入して，本番環境であれば`.30d.jp`をappendしています．

### `set_property custom_property`

これは後述しますが，Serverspec/Specinfraが保持しているproperty以外の情報を取得するための設定が入っています．

## custom_property.rb

ホストの特定の情報を取得するために使っています．

詳細は[Serverspec - Advanced Tips](http://serverspec.org/advanced_tips.html)の**How to use host specific properties**にあります．

```rb
def target_hostname
  hostname = Specinfra.backend.run_command('hostname').stdout.chop
  host = { hostname: hostname }
  host
end

def target_os_dist
  dist = Specinfra.backend.run_command("awk '{print $1}' /etc/redhat-release").stdout.chop
  property = { os: os }
  property[:os][:dist] = dist
  property
end

def custom_property
  property = {}
  property
    .merge(target_hostname)
    .merge(target_os_dist)
end
```

例えば`target_os_dist`は，`CentOS`や`SL`といったRedHat系のディストリビューションを格納するために使っています．
Specinfraの`os[:family]`はどちらも`redhat`という文字列になってしまうので，それの対策だったりします．

## 終わりに

駆け足の紹介でしたが，Rakefile, spec\_helper,rb, custom\_property,rb の3つのファイルを用いてServerspecの環境を設定しています．
より良い方法がありましたらご教授くださいませm(_ _)m

[^1]: [Vagrant で Puppet ENC (External Node Classifiers) を試す | blog: takahiro okumura](/2014/12/31/vagrant-puppet-enc)
