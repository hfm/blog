---
layout: post
title: Raspberry PiでArch Linuxを使う最低限のセットアップ
categories:
- Dev
tags:
- Raspberry Pi
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _aioseop_keywords: Raspberry Pi, Arch Linux
  _aioseop_description: "SDカードのベンチマークから、Raspberry PiにArch Linuxをインストールするまでの手順、環境のセッテアップから無線LANのWi-Fi化等のモロモロの用意を紹介しています。\r\nおまけとして、レゴブロックによるRaspberry
    Pi専用ケースの作成もしました。"
  _aioseop_title: Raspberry PiでArch Linuxを使う最低限のセットアップ
---
&nbsp;

<a title="Raspberry Pi" href="http://www.raspberrypi.org/" target="_blank">Raspberry Pi</a>を購入しました。
<h1><!--more-->もくじ</h1>
<ul>
	<li>SDカードとOSイメージの用意
<ul>
	<li>SDカード</li>
	<li>Arch Linux ARMの SDカードイメージの入手</li>
	<li>SDカードへのイメージファイル書き込み</li>
</ul>
</li>
	<li>Raspberry Piの起動、sshログイン</li>
	<li>chef-soloによる自動環境構築</li>
	<li>（おまけ）LEGOブロックで専用ケースづくり</li>
</ul>
<h1>SDカードとOSイメージの用意</h1>
<h2>SDカード</h2>
[amazon asin=B009HM56D8&amp;template=wishlist&amp;chan=default]

<a title="Iozone Filesystem Benchmark" href="http://www.iozone.org/" target="_blank">iozone</a>というベンチマークツールを利用して、SDカードのパフォーマンスを計測してみました。
<blockquote><a title="ファイルシステムのベンチマークを測定するには" href="http://www.atmarkit.co.jp/flinux/rensai/linuxtips/912fsbench.html" target="_blank">ファイルシステムのベンチマークを測定するには</a>
IOzone（http://www.iozone.org/）は、ディスクの入出力に関するさまざまなテストを行うことができるソフトウェアだ。...

<a title="Using IOzone for Linux disk performance analysis" href="http://www.dbi-services.com/index.php/blog/entry/using-iozone-for-linux-disk-performance-analysis" target="_blank">Using IOzone for Linux disk performance analysis</a>
IOzone (www.iozone.org) is an open source solution for file system benchmark. ...</blockquote>
詳細が気になる方は<a href="https://gist.github.com/4671472" target="_blank">gistに貼りつけたのでそちらをご参照ください</a>。
<h2>Arch Linux ARMの SDカードイメージの入手</h2>
Arch Linux ARMは<a title="Downloads | Raspberry Pi" href="http://www.raspberrypi.org/downloads" target="_blank">こちらのダウンロードページ</a>からzipファイルを直接<span style="font-size: x-small;">（http経由）</span>またはtorrent経由で入手可能です。
<blockquote>Arch Linux ARM / <a title="Download | Raspberry Pi" href="http://www.raspberrypi.org/downloads" target="_blank">Download</a>

Arch Linux ARM is based on Arch Linux, which aims for simplicity and full control to the end user. Note that this distribution may not be suitable for beginners. The latest version of this image uses the hard-float ABI, and boots to a command prompt in around ten seconds. ...</blockquote>
あ 今回はtorrent経由で入手します。Homebrewからctorrentというコマンドラインで動くBitTorrentクライアントをインストールして、Arch Linux ARMを入手します。
<pre class="lang:default decode:true">$ brew install ctorrent
$ wget http://downloads.raspberrypi.org/images/archlinuxarm/archlinux-hf-2013-02-11/archlinux-hf-2013-02-11.zip.torrent
$ ctorrent archlinux-hf-2013-02-11.zip.torrent
...
Download complete.
...
# Contrel-Cで終了させる</pre>
ctorrentはデフォルトで72時間動き続けるので、DL完了後はControl-Cで終了させ、入手したarchlinuxのzipファイルを解凍します。
<pre class="lang:default decode:true">$ shasum archlinux-hf-2013-02-11.zip
1d2508908e7d8c899f4a5284e855cb27c17645dc  archlinux-hf-2013-02-11.zip
$ unzip archlinux-hf-2013-02-11.zip</pre>
<h2>SDカードへのイメージファイル書き込み</h2>
あ
<pre class="lang:default mark:7 decode:true">$ df -h
Filesystem      Size   Used  Avail Capacity  iused    ifree %iused  Mounted on
/dev/disk0s2   233Gi  162Gi   71Gi    70% 42455423 18614017   70%   /
devfs          191Ki  191Ki    0Bi   100%      670        0  100%   /dev
map -hosts       0Bi    0Bi    0Bi   100%        0        0  100%   /net
map auto_home    0Bi    0Bi    0Bi   100%        0        0  100%   /home
/dev/disk1s1    30Gi  2.7Mi   30Gi     1%        0        0  100%   /Volumes/UNTITLED

$ diskutil unmount /dev/disk2s1
Volume UNTITLED on disk2s1 unmounted</pre>
あ
<pre class="lang:default decode:true">$ sudo dd bs=1m if=archlinux-hf-2013-02-11.img of=/dev/rdisk1
Password:
1850+0 records in
1850+0 records out
1939865600 bytes transferred in 59.153875 secs (32793551 bytes/sec)
$ diskutil eject /dev/rdisk1
Disk /dev/rdisk1 ejected</pre>
あ
<h1>Raspberry Piの起動、sshログイン</h1>
あああ
<pre class="lang:default decode:true" title="Raspberry Pi(Arch Linux)へのsshログイン">$ ssh root@192.168.1.3
root@192.168.1.3's password: 
Last login: Fri Mar 15 22:30:29 2013
[root@alarmpi ~]# df
Filesystem     1K-blocks   Used Available Use% Mounted on
rootfs           1713424 468124   1158260  29% /
/dev/root        1713424 468124   1158260  29% /
devtmpfs           84924      0     84924   0% /dev
tmpfs             236560      0    236560   0% /dev/shm
tmpfs             236560    276    236284   1% /run
tmpfs             236560      0    236560   0% /sys/fs/cgroup
tmpfs             236560      0    236560   0% /tmp
/dev/mmcblk0p1     91962  24796     67166  27% /boot
[root@alarmpi ~]#</pre>
あ
<pre class="lang:default decode:true">[root@alarmpi ~]# fdisk /dev/mmcblk0
mmcblk0    mmcblk0p1  mmcblk0p2  
[root@alarmpi ~]# fdisk /dev/mmcblk0
mmcblk0    mmcblk0p1  mmcblk0p2  
[root@alarmpi ~]# fdisk /dev/mmcblk0
Welcome to fdisk (util-linux 2.22.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Command (m for help): p

Disk /dev/mmcblk0: 32.0 GB, 32026656768 bytes, 62552064 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004f23a

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1   *        2048      186367       92160    c  W95 FAT32 (LBA)
/dev/mmcblk0p2          186368     3667967     1740800   83  Linux

Command (m for help): d
Partition number (1-4): 2
Partition 2 is deleted

Command (m for help): n
Partition type:
   p   primary (1 primary, 0 extended, 3 free)
   e   extended
Select (default p): p
Partition number (1-4, default 2): 2
First sector (186368-62552063, default 186368): 186368
Last sector, +sectors or +size{K,M,G} (186368-62552063, default 62552063): 
Using default value 62552063
Partition 2 of type Linux and of size 29.8 GiB is set

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.
[root@alarmpi ~]#</pre>
あ
<pre class="lang:default decode:true">$ ssh root@192.168.1.3
root@192.168.1.3's password: 
Last login: Fri Mar 15 22:46:16 2013 from 192.168.1.42
[root@alarmpi ~]# resize2fs /dev/mmcblk0p2
resize2fs 1.42.6 (21-Sep-2012)
Filesystem at /dev/mmcblk0p2 is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 2
The filesystem on /dev/mmcblk0p2 is now 7795712 blocks long.</pre>
あ
<pre class="lang:default decode:true">[root@alarmpi ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs           30G  460M   28G   2% /
/dev/root        30G  460M   28G   2% /
devtmpfs         83M     0   83M   0% /dev
tmpfs           232M     0  232M   0% /dev/shm
tmpfs           232M  272K  231M   1% /run
tmpfs           232M     0  232M   0% /sys/fs/cgroup
tmpfs           232M     0  232M   0% /tmp
/dev/mmcblk0p1   90M   25M   66M  27% /boot</pre>
あ

ああ
<h2>無線機器によるWi-Fi接続化</h2>
awa

[amazon asin=B004AM6C3S&amp;template=wishlist&amp;chan=default]

ああ
<h1>（おまけ）LEGOブロックで専用ケースづくり</h1>
あ

[amazon asin=B0048BQ6LO&amp;template=wishlist&amp;chan=default]

あ
<h1>参考</h1>
<ul>
	<li><a title="Raspberry Pi の Arc Linux を Mac を使ってセットアップしてみた" href="http://d.hatena.ne.jp/paraches/20121015" target="_blank">Raspberry Pi の Arc Linux を Mac を使ってセットアップしてみた</a></li>
</ul>
