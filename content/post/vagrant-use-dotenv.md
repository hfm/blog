---
date: 2014-11-19T23:32:43+09:00
title: Vagrantfileでdotenvを使う
tags: 
- ruby
- vagrant
---
正直使いドコロの難しい技ではありますが、vagrantのプラグインはgemを引っ張ってきてるだけなので、

```sh
vagrant plugin install dotenv
```

ってやれば、vagrantでdotenvを使えるようになり、`.env`にトークンとか書いておけば、vagrant upした時とかに反映されます。
Vagrantfileの中に

```rb
require 'dotenv'
Dotenv.load
```

を書けば、`.env`の中身が反映されて便利なり。

## 結論

状況次第ではありますが、ぶっちゃけdirenvの方が便利だと思います。
