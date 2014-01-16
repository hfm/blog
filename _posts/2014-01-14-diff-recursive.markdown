---
layout: post
title: diff -rで再帰的に差分を取得する
tags: 
- tips
---
[OpenSSL](http://www.openssl.org)のver 1.0.1fがリリースされた時に、1.0.1eと何が道変わったのかを知るためには、まずはCHANGELOGを見ることだと思う。

ただもうちょっと深く突っ込んで、具体的にソースコードのどの辺が修正されたのかが気になったのだけど、例えばGitHub管理されていないようなプロジェクトはどうすればいいだろう。

```sh
wget http://www.openssl.org/source/openssl-1.0.1{e,f}.tar.gz
tar xzvf openssl-1.0.1e.tar.gz
tar xzvf openssl-1.0.1f.tar.gz

diff -r -u openssl-1.0.1{e,f}
```

ひとまずこれで全ての差分が出る。  
量が多すぎるのでteeとか使ってファイルに落としたほうがいいと思う。
