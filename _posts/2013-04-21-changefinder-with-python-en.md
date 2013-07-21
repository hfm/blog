---
layout: post
title: Anomaly Detection (Change Point Detection) in Python
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
  _thumbnail_id: '3859'
  dsq_thread_id: '1224594708'
  _aioseop_keywords: Python, Anomaly Detection, Change Point Detection, Machine Learning,
    Data mining
  _aioseop_description: I've impletented a program of change-points detection in Python
    language. This is used for anomaly detection from time series.
  _aioseop_title: Anomaly Detection (Change Point Detection) in Python
---
The entry written in Japanese is <a title="異常検知（変化点検出）をPythonで書いてみた" href="http://blog.hifumi.info/dev/changefinder-with-python/">here</a>.
<h1>Change-point detection</h1>
Change-point detection is a framework for detecting outliers and change points from time series. The framework is often used for detection of sudden change-points from boosting traffic load of DoS attack or a new worm.

Here is the principles of change-point detection by <a href="https://twitter.com/yokkuns" target="_blank">Mr. Yohei SATO</a> (<a href="http://www.hatena.ne.jp/yokkuns/" target="_blank">id:yokkuns</a>).
<span style="color: #ff0000;">*the following slides is in Japanese language</span>.

[slideshare id=8425312&amp;doc=tokyowebmining13-110625213239-phpapp02]

<!--more-->
<h1>Implementation in Python</h1>
My development environment is here.
<ul>
	<li><a href="http://www.python.org/" target="_blank">Python 3.3.0</a></li>
	<li><a href="http://www.numpy.org/" target="_blank">numpy 1.7.0</a></li>
	<li><a href="http://www.scipy.org/" target="_blank">scipy 1.2.0.dev-3145a22</a></li>
	<li><a href="http://statsmodels.sourceforge.net/" target="_blank">statsmodels 0.5.0</a></li>
</ul>
And I've pushed an implementation to a repository in GitHub.

<a title="Tacahilo/ChangeAnomalyDetection" href="https://github.com/Tacahilo/ChangeAnomalyDetection" target="_blank">Tacahilo/ChangeAnomalyDetection</a>
<h2>Program in Python</h2>
Here is a sample python program for change-points detection.
<pre class="lang:python decode:true" title="changepoint_detection.py">#!/usr/bin/env python
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
<h2>How to use</h2>
Example:
<pre class="lang:default decode:true" title="sample.py">#!/usr/bin/env python
# -*- coding: utf-8 -*-

from numpy.random import rand, multivariate_normal
import changepoint_detection

data_a = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
data_b = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
data_c = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
data_d = multivariate_normal(rand(1) * 20 - 10, np.eye(1) * (rand()), 250)
X = np.r_[data_a, data_b, data_c, data_d][:, 0]

cp_detect = changepoint_detection(term=70, window=7, order=(2, 2, 0))
result = cp_detect.main(X)</pre>
<ul>
	<li>term... A terms in training</li>
	<li>window...Moving average (MA) terms</li>
	<li>order...parameters for ARIMA function</li>
</ul>
Following is plot data of X and result. A blue line is each data value, and a green line is each score.

[caption id="attachment_3762" align="aligncenter" width="400"]<a href="http://blog.hifumi.info/wp-content/uploads/2013/03/sample.png"><img class="size-medium wp-image-3762" alt="変化点検出のサンプル" src="http://blog.hifumi.info/wp-content/uploads/2013/03/sample-400x300.png" width="400" height="300" /></a> Sample of change-points detection[/caption]
