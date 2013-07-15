---
layout: post
title: 異常検知（変化点検出）をPythonで書いてみた
categories:
- Dev
- Machine learning
- Study
tags:
- Machine Learning
- Python
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;i:2;}
  _thumbnail_id: '3762'
  dsq_thread_id: '1224374719'
  _aioseop_keywords: データマイニング, Python, 異常検知, 変化点検出, Machine Learning, Data mining
  _aioseop_description: 山西健司氏の『データマイニングによる異常検知』の時系列的な振る舞いの変化点を検出する「変化点検出」をPythonで実装しました。
  _aioseop_title: 異常検知（変化点検出）をPythonで書いてみた
---
The entry written in English is <a title="Anomaly Detection (Change Point Detection) in Python" href="http://blog.hifumi.info/dev/changefinder-with-python-en/">here</a>.

データマイニングについて勉強する機会があり、Python言語の練習がてら「変化点検出」と呼ばれる手法について、近似的ではありますが、試作してみました。

<!--more-->
<h1>変化点検出とは</h1>
変化点検出とは、入力データの時系列的な振る舞いの変わり目（変化点）を検出する方法です（<a href="http://academic.research.microsoft.com/Author/1793969/kenji-yamanishi" target="_blank">山西健司</a>著『データマイニングによる異常検知』）。

[amazon asin=4320018826&amp;template=wishlist&amp;chan=default]<a title="A unifying framework for detecting outliers and change points from time series" href="http://scholar.google.co.jp/scholar?q=A+unifying+framework+for+detecting+outliers+and+change+points+from+time+series" target="_blank">A unifying framework for detecting outliers and change points from time series</a> (Google Scholar)

DoS攻撃や新種のワームの発生による、急激な値の変わり目（トラフィック量の急増等）を検知するのに有効とされる手法です。

動作原理を知りたい方は、<a href="https://twitter.com/yokkuns" target="_blank">里 洋平</a>さん (<a href="http://www.hatena.ne.jp/yokkuns/" target="_blank">id:yokkuns</a>) による変化点検出についてのスライドをご参照下さい。

[slideshare id=8425312&amp;doc=tokyowebmining13-110625213239-phpapp02]
<h2>R言語による実装例</h2>
また、里さんは変化点検出についてR言語で実装されています。
<blockquote>時系列的な振る舞いの変化点を検出するためのパッケージを作ってみました。
<ul>
	<li>CRAN: <a href="http://cran.r-project.org/web/packages/ChangeAnomalyDetection/" target="_blank">http://cran.r-project.org/web/packages/ChangeAnomalyDetection/</a></li>
	<li>github: <a href="https://github.com/yokkuns/r-AnomalyDetection" target="_blank">https://github.com/yokkuns/r-AnomalyDetection</a></li>
</ul>
<p style="text-align: right;">出典：<a href="http://d.hatena.ne.jp/yokkuns/20120930/1348978641" target="_blank">異常検知（変化点検出）のパッケージを作ってみた</a></p>
</blockquote>
今回はこの変化点検出について、里さんの実装を参考に、Pythonでの実装（移植）を行ないました。
<h1>Pythonでの実装</h1>
開発環境は次のとおりです。
<ul>
	<li><a href="http://www.python.org/" target="_blank">Python 3.3.0</a></li>
	<li><a href="http://www.numpy.org/" target="_blank">numpy 1.7.0</a></li>
	<li><a href="http://www.scipy.org/" target="_blank">scipy 1.2.0.dev-3145a22</a></li>
	<li><a href="http://statsmodels.sourceforge.net/" target="_blank">statsmodels 0.5.0</a></li>
</ul>
また、実装した変化点検出プログラムについて、GitHubにリポジトリを作成しました。

<a title="Tacahilo/ChangeAnomalyDetection" href="https://github.com/Tacahilo/ChangeAnomalyDetection" target="_blank">Tacahilo/ChangeAnomalyDetection</a>
<h2>プログラム</h2>
サンプルプログラムは次のとおりです。smoothingはoutlier関数でもchangepoint関数でも用いているので、新たにdefを作っても良さそうです。
<pre class="lang:python decode:true" title="changepoints_detection.py">#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import numpy as np
import scipy as sp
import statsmodels.tsa.arima_model as ar

class change_finder(object):
    def __init__(self, term=70, window=5, order=(1, 1, 0)):
        self.term = term
        self.window = window
        self.order = order
        print("term:", term, "window:", window, "order:", order)

    def main(self, X):
        req_length = self.term * 2 + self.window + np.round(self.window / 2) - 2
        if len(X) &lt; req_length:
            sys.exit("ERROR! Data length is not enough.")

        print("Scoring start.")
        X = (X - np.mean(X)) / np.std(X)
        score = self.outlier(X)
        score = self.changepoint(score)
        score = np.r_[np.zeros(len(X) - len(score)), score]
        print("Done.")

        return score

    def outlier(self, X):
        count = len(X) - self.term - 1

        ## train
        trains = [X[t:(t + self.term)] for t in range(count)]
        target = [X[t + self.term + 1] for t in range(count)]
        fit = [ar.ARIMA(trains[t], self.order).fit(disp=0) for t in range(count)]

        ## predict
        resid = [fit[t].forecast(1)[0][0] - target[t] for t in range(count)]
        pred = [fit[t].predict() for t in range(count)]
        m = np.mean(pred, axis=1)
        s = np.std(pred, axis=1)

        score = -sp.stats.norm.logpdf(resid, m, s)
        score = self.smoothing(score, self.window)
        return score

    def changepoint(self, X):
        count = len(X) - self.term - 1

        trains = [X[t:(t + self.term)] for t in range(count)]
        target = [X[t + self.term + 1] for t in range(count)]
        m = np.mean(trains, axis=1)
        s = np.std(trains, axis=1)

        score = -sp.stats.norm.logpdf(target, m, s)
        score = self.smoothing(score, np.round(self.window / 2))
        return score

    def smoothing(self, X, w):
        return np.convolve(X, np.ones(w) / w, 'valid')</pre>
<h2>使い方</h2>
<pre class="lang:python decode:true" title="sample.py">from numpy.random import rand, multivariate_normal
import changepoints_detection

data_a = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
data_b = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
data_c = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
data_d = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
X = np.r_[data_a, data_b, data_c, data_d][:, 0]

cp_detect = changepoints_detection(term=70, window=7, order=(2, 2, 0))
result = cp_detect.main(X)</pre>
<ul>
	<li>term...学習期間</li>
	<li>window...移動平均時間</li>
	<li>order...arima関数に渡すパラメータ</li>
</ul>
Xとresultをプロットしたものは次のとおりです。

[caption id="attachment_3762" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/03/sample.png"><img class="size-medium wp-image-3762" alt="変化点検出のサンプル" src="http://blog.hifumi.info/wp-content/uploads/2013/03/sample-400x300.png" width="400" height="300" /></a> 変化点検出のサンプル[/caption]

青がデータ点、緑が変化点です。データの変わり目の部分でスコアが高い値を獲得しています。
<h1>地震の加速度によるサンプル例</h1>
気象庁公式ウェブサイトの気象統計情報に、福島県浜通りで発生した地震（2011.4.11時点）の加速度波形の一部がサンプルとして掲載されています。
<blockquote><a href="http://www.seisvol.kishou.go.jp/eq/kyoshin/jishin/110411_fukusima-hamadori/" target="_blank">http://www.seisvol.kishou.go.jp/eq/kyoshin/jishin/110411_fukusima-hamadori/</a>

気象庁｜強震波形（福島県浜通りの地震)</blockquote>
今回は、ここのサンプルデータから福島県棚倉町棚倉中居野の波形データを利用させて頂きました。ダウンロード出来るデータの、８行目から続く３列の数値データ（南北、東西、上下方向からそれぞれの加速度）を入力とし、それぞれの波形から得られる変化点検出データをプロットしました。

学習期間 (term)とorderのパラメータの設定次第でどのような結果になるかを確認します。

まずは、学習期間を100、orderを(1,1,0)で設定した場合のスコアが次になります。青が波形データ、赤がスコア値になります。

[caption id="attachment_3854" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/03/sample_eq_100_110.png"><img class="size-medium wp-image-3854" alt="学習期間100、orderを(1,1,0)で設定した結果" src="http://blog.hifumi.info/wp-content/uploads/2013/03/sample_eq_100_110-400x300.png" width="400" height="300" /></a> 学習期間100、orderを(1,1,0)で設定した結果[/caption]

次に、学習期間 (term) を100、orderを(1,5,0)で設定した場合のスコアが次になります。

[caption id="attachment_3855" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/03/sample_eq_100_150.png"><img class="size-medium wp-image-3855" alt="学習期間100、orderを(1,5,0)で設定した結果" src="http://blog.hifumi.info/wp-content/uploads/2013/03/sample_eq_100_150-400x300.png" width="400" height="300" /></a> 学習期間100、orderを(1,5,0)で設定した結果[/caption]

最後に、学習期間 (term) を100、orderを(1,7,0)で設定した場合のスコアが次になります。

[caption id="attachment_3859" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/03/sample_eq_100_170.png"><img class="size-medium wp-image-3859" alt="学習期間100、orderを(1,7,0)で設定した結果" src="http://blog.hifumi.info/wp-content/uploads/2013/03/sample_eq_100_170-400x300.png" width="400" height="300" /></a> 学習期間100、orderを(1,7,0)で設定した結果[/caption]

学習期間を100で統一し、orderの一部を変えてテストした結果が上の３つの図のようになりました。パラメータ次第でスコアが大きく変化しているのが分かります。

試験としては若干チープかもしれませんが、入力に対して最適なパラメータを設定することは大切ですので、変化点検出が上手く動いてくれてるように見えない時でも少しパラメータをいじるなどして調整してみるのもいいと思います（ただし、パラメータの設定次第ではものすごく計算に時間がかかります）。
