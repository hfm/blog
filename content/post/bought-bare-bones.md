---
layout: post
title: Shuttle XS36VLを買った
date: 2013-10-20
tags:
- diary
---
ファンレスベアボーンの[Shuttle XS36VL](http://www.shuttle-japan.jp/barebone/slim/xs36vl)を買いました。

![](http://30d.jp/img/hfm/public/a0d63846-3969-11e3-a701-f80f41f63894_large.jpg)

製品名     | XS36VL
-----------+-----------------------------------------------
OS         | Scientific Linux 6.4 (32bit)
プロセッサ | Intel® Dual Core Atom D2550
メモリ     | [DDR3 SO-DIMM PC3-10600 CL9 4GB (W3N1333Q-4G/N)](http://www.amazon.co.jp/exec/obidos/ASIN/B009URHVLA/hifumiass-22/ref=nosim/)
ドライブ   | [2.5inch 内蔵型 SATA6Gbps 128GB CSSD-S6T128NHG5Q](http://www.amazon.co.jp/exec/obidos/ASIN/B00C9RFGOW/hifumiass-22/ref=nosim/)

## USBブート用にimageを作成する

/dev/disk\*の探し方は「[MacでRaspberry PiにOSを入れるまでのやることリスト](http://qiita.com/hfm/items/96d20d9cc29fb46fd8a3#2-2)」を参考にどうぞ。

```sh
# Scientific Linux 6.4のboot.iosをダウンロード
curl -O http://ftp.riken.jp/Linux/scientific/6.4/i386/iso/SL-64-i386-2013-03-18-boot.iso

# ddで書き込むために、isoをdmgファイルへ変換する
hdiutil convert -format UDRW -o boot.dmg SL-64-i386-2013-03-18-boot.iso

# USBメモリへ書き込む
diskutil unmount /dev/disk1s1
sudo dd bs=1m if=boot.dmg of=/dev/rdisk1
diskutil eject /dev/disk1s1
```

あとはimageの入ったUSBメモリをXS36VLへ差し込み、USB BOOTで起動すればインストーラが起動してインストールが始まります。

Installation Methodは、32bitのみ対応なので http://ftp.riken.jp/Linux/scientific/6.4/i386/os/ を指定しましょう。

## XS36VL

SATA3Gbポートだったり64bit非対応だったりIntel VT-x非対応だったりで、スペックはやや低めです。

ただ、個人用途には十分な内容だったのでこれを選びました。
なにげにカードリーダもついてたり、D-Sub, DVI-Iの他にHDMIポートまでついてるのが良かったです。

あと薄い。ファンレスで光学ドライブも無いので、他のShuttleベアボーンと比べても薄いです。

![](http://30d.jp/img/hfm/public/a1d57586-3969-11e3-a701-f80f41f63894_large.jpg)

1台のベアボーンを動かすのに合計約3万円でした（メモリ2枚買ってますが、1枚は予備のつもり）。
実際にはサブモニタを買ったりしているので、もう少し出費は上がっているのですが…。

とはいえ、目の前にサーバがあると、「好きに使っていい」感じがしてワクワクしますね！
