---
layout: post
title: ntpdateのinit script(RHEL 6)を読んだ
tags: 
- linux
- initscript
---

```bash
wget ftp://mirror.switch.ch/pool/4/mirror/redhat/linux/enterprise/6Client/en/os/SRPMS/ntp-4.2.6p5-1.el6.src.rpm
rpm2cpio ntp-4.2.6p5-1.el6.src.rpm | cpio -idv ntpdate.init
```
