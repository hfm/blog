---
layout: post
title: Python(3.3.0)のmultiprocessingの速さを比べてみた
categories:
- Dev
tags:
- Python
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _aioseop_keywords: Python,multiprocessing,プログラム,Program
  _aioseop_title: Python(3.3.0)のmultiprocessingの速さを比べてみた
---
<h1>Python multiprocessing</h1>
ここ最近でPython3.3.0でもようやくnumpy/scipyやmatplotlib, networkxやstatsmodelsやnltkといった諸々のライブラリが利用可能になってきました。 使用環境は次の通り。
<ul>
	<li>OS X 10.8.3</li>
	<li>Python 3.3.0</li>
	<li>2.3 GHz Intel Core i7</li>
	<li>16GB 1600 MHz DDR3</li>
</ul>
割とパワフルなスペック
<h1>program</h1>
比較対象としてリスト内包表記を選択しました。
<blockquote><a title="Pythonの内包表記はなぜ速い？" href="http://dsas.blog.klab.org/archives/51742727.html" target="_blank">Pythonの内包表記はなぜ速い？</a> / <a title="DSAS開発者の部屋" href="http://dsas.blog.klab.org/" target="_blank">DSAS開発者の部屋</a>

今回は、「エキスパートPythonプログラミング」の2章から、リスト内包表記について補足します。 本書で、リスト内方表記が速い理由について、次のような訳注を書きました。

"訳注：リストに要素を append() する場合、インタプリタは「リストから append 属性を取り出してそれを関数として呼び出す」という処理をしなければなりません。 それに対して、リスト内包表記を使うと、インタプリタに直接「リストに要素を追加する」という処理をさせることができます。インタプリタが解釈する命令数が減る、属性の取り出しが不要になる、関数呼び出しが不要になる、という3つの理由で、リスト内包表記を使うと速くなります。"</blockquote>
あ
<pre class="lang:python decode:true" title="multiprocessing">import numpy as np
import multiprocessing as mlp
import time

def main(X):
    print("Data Length\t\t\t:", len(X))

    spd = time.clock()
    calc_map(X)
    spd = time.clock() - spd
    print("Multiprocess Map\t:", spd)

    spd = time.clock()
    calc_imap(X)
    spd = time.clock() - spd
    print("Multiprocess iMap\t:", spd)

    spd = time.clock()
    calc_apply(X)
    spd = time.clock() - spd
    print("Multiprocess Apply \t:", spd)

    spd = time.clock()
    calc_comp(X)
    spd = time.clock() - spd
    print("List Comprehensions\t:", spd)

def calc_map(X):
    pool = mlp.Pool()
    result = pool.map(func=calc_power, iterable=X, chunksize=3000)
    return result

def calc_imap(X):
    pool = mlp.Pool()
    result = [r for r in pool.imap(func=calc_power, iterable=X, chunksize=3000)]
    return result

def calc_apply(X):
    pool = mlp.Pool()
    result = pool.apply(func=calc_power, args=(X,))
    return result

def calc_comp(X):
    return [calc_power(X[t]) for t in range(len(X))]

def calc_power(X):
    return X ** 2

if __name__ == '__main__':
    print("CPUs\t\t\t\t:", mlp.cpu_count())
    main(np.random.rand(10))
    main(np.random.rand(100))
    main(np.random.rand(1000))
    main(np.random.rand(10000))
    main(np.random.rand(100000))
    main(np.random.rand(1000000))
    main(np.random.rand(10000000))</pre>
ああ
<h1>result</h1>
<pre class="lang:default decode:true" title="処理結果">CPUs                : 8
Data Length         : 10
Multiprocess Map    : 0.027174000000000004
Multiprocess iMap   : 0.01109199999999999
Multiprocess Apply  : 0.011204999999999965
List Comprehensions : 9.100000000000774e-05

Data Length         : 100
Multiprocess Map    : 0.015120999999999996
Multiprocess iMap   : 0.01593100000000003
Multiprocess Apply  : 0.013925999999999994
List Comprehensions : 0.00022499999999997522

Data Length         : 1000
Multiprocess Map    : 0.025980000000000003
Multiprocess iMap   : 0.021921999999999997
Multiprocess Apply  : 0.018123
List Comprehensions : 0.001831000000000027

Data Length         : 10000
Multiprocess Map    : 0.087561
Multiprocess iMap   : 0.09058100000000008
Multiprocess Apply  : 0.019840999999999998
List Comprehensions : 0.017249999999999988

Data Length         : 100000
Multiprocess Map    : 0.705835
Multiprocess iMap   : 0.7403
Multiprocess Apply  : 0.03594000000000008
List Comprehensions : 0.17743100000000034

Data Length         : 1000000
Multiprocess Map    : 6.757089
Multiprocess iMap   : 6.983575000000002
Multiprocess Apply  : 0.19784699999999944
List Comprehensions : 1.8046490000000013

Data Length         : 10000000
Multiprocess Map    : 67.830874
Multiprocess iMap   : 70.555025
Multiprocess Apply  : 13.619205999999991
List Comprehensions : 17.82403400000001</pre>
