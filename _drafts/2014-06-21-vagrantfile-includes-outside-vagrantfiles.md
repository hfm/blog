---
layout: post
title: Vagrantfileの管理について
tags:
- vagrant
---
サービスのRoleが増えるに連れて、Vagrantfileが長くなっていくのをなんとかするために設計パターンを考えた話。

#### TL;DR

- Vagrantfileが縦に長くなるのが辛い
- 中身はrubyなので、loadすれば複数枚のVagrantfileを使っても動かせる
- Vagrantfileにはcommon settingsとmain rolesを記述、特定目的のVMは別ファイルに管理するとどうだろう

## 背景

### 長大化するVagrantfile

いくつかの設定を共通化出来そうだと気づけばコードをまとめるが、独自に定義したメソッドの意味を確かめるために画面を何度もスクロールさせる。

個人プロジェクトならまだしも、複数人が携わるプロジェクトにおいて、1枚のコードが長大化するのは非常に苦痛である。

しかしVagrantfileについて、1枚にベタ書きする他に特に良い案も無い。N/Wやマシンスペックに関するdefineを作って共通化するのも悪く無いと思う。

会社のサービスでは、以下のようなメソッドを用意して、マシンスペック定義の共通化を測っている。

```rb
def vm_spec(c, opt = {})
  opt[:memory] ||= 512
  opt[:cpus]   ||= 2
  c.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", opt[:memory]]
    v.customize ["modifyvm", :id, "--cpus",   opt[:cpus]]
  end
end
```

これによって、各VMのdefineは1行のメソッドで済む。

```rb
config.vm.define :one do |c|
  c.vm.hostname = "one.vagrant.dev"
  vm_spec c, memory: 1024, cpus: 3
end
```


### 課題：zsh-completionsでVMリストが得られない

私はzsh userなのだが、Vagrantfileを分けてしまうとVMリストの補完が一部効かなくなる。
これは[zsh-completionsのsrc/\_vagrant#L78-81](https://github.com/zsh-users/zsh-completions/blob/master/src/_vagrant#L78-81)を見れば分かるのだが、VMリストの補完にVagrantfileを利用しているためだ。

```sh
# 今日時点 (2014/06/21)の補完方法
grep Vagrantfile -oe '^[^#]*\.vm\.define * ['\\''":]\?\([a-zA-Z0-9\-_]\\+\)['\\''"]\?' 2>/dev/null |  awk '{print $NF}' | sed 's/'\\''//g'|sed 's/\"//g'|sed 's/^://'

# 分かりにくすぎるので分解してみる（だがまだ分かりにくい）
grep Vagrantfile -oe '^[^#]*\.vm\.define * ['\\''":]\?\([a-zA-Z0-9\-_]\\+\)['\\''"]\?' 2>/dev/null | \
    awk '{print $NF}' | \
    sed 's/'\\''//g' | \ 
    sed 's/\"//g' | \
    sed 's/^://'
```

何故コンソール入力でも無いのにgrepしてawkするのか[\*1](#uuog)、何故sedを三連発もするのか、何故パイプの前後に半角スペースがあったりなかったりするのか、等といった疑問はさておき、Vagrantfileから`*.vm.define`のある行をgrepして補完リストを作成しているので、Vagrantfile以外の名前は当然補完対象ではなくなる。

### あとがき

『Vagrantfile 複数』とか『』で調べてもmulti VMの話しか出てこなかったので、このエントリと似た解決を試みた話が日本ではまだ展開されてない？あるいは皆個別に挑戦してはいるけど、暗黙知に留まっている？と思って書いてみた。

単純に調べ足りてないだけの気もするし、[erran-r7/multiple_vagrantfiles](https://github.com/erran-r7/multiple_vagrantfiles)もあるのだからそもそもが二番煎じ。
とはいえ

#### 脚注

- <a name='uuog'></a>\*1 ... http://www.smallo.ruhr.de/award.html#grep
