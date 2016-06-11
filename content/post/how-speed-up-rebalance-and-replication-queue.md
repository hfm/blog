---
date: 2016-06-12T06:52:58+09:00
title: Rebalance / Replication Queue
draft: true
tags:
- puppet
---

原文は[Rebalance / Replication Queue](https://groups.google.com/forum/#!topic/mogile/ZdB9OlMa6_g)にある。
なお、翻訳ではなく意訳である。なるべく誤解のないように努めたが、より正確な記述は原文にあたってほしい。

> Jed
>
> 2つのホストから新しいホストへリバランスを行おうとしている。次のパラメタで始めてみた（送りたいデータはもっとたくさんあるんだけど、一晩で終わるくらいの量で始めたかったんだ。）
>
> from_hosts=7,12 fid_age=old limit_by=size limit=20g to_hosts=16
>
> The process started but has been running very slowly (at least it seems that way). Started at 6/3/2016, 9:48:59 PM (Eastern) [13 hours] and only 116 gigabytes and 361,340 files have been queued.
>
> I tried increasing the some queue settings using mogadm and I’m currently on:
>
>      internal_queue_limit = 5000
>      queue_rate_for_rebal = 3500
>      queue_size_for_rebal = 20000
>
> When reviewing mogadm rebalance status the runs are at least 10 minutes apart.
>
> The replication queue has only 25,000 items (all deferred) but I’m guessing that since the rebalance runs are so far apart the replication is not being efficient.
>
> General info: All trackers are running 2.70. 14 storage hosts and ~350 active devices. Database load average is 0.10 to 0.30
>
> Can anyone think of next steps to try to speed this up? I did try increasing queue_rate_for_rebal to 5000 but the job master was dying for this reason:
>
> Jun  4 09:57:51 tracker2 mogilefsd[31735]: crash log: DBD::mysql::db do failed: Got a packet bigger than ‘max_allowed_packet' bytes at /usr/local/share/perl5/MogileFS/Store.pm line 1545.#012 at /usr/local/share/perl5/MogileFS/Worker/JobMaster.pm line 266

https://groups.google.com/d/msg/mogile/ZdB9OlMa6_g/7NrxEY2jFAAJ
