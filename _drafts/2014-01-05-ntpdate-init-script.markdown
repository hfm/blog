---
layout: post
title: ntpdateのinit scriptを読んだ
tags: 
- linux
- shellscript
---
CentOS 6ではntpdateというserviceが追加されました。
正確には、RHEL5での`/etc/init.d/ntpd`を、RHEL6からは`/etc/init.d/ntpd`と`/etc/init.d/ntpdate`に分離したそうです。

 * [NTP設定 - とあるSIerの憂鬱](http://d.hatena.ne.jp/incarose86/20110505/1312522379)

最初これが何をやっているかよく分からなかったので、ソースコードを追ってみました。
大した発見はありませんが、良いロジックに出会えたりして面白いです。

## SRPMを入手

ntpdateのSRPMは以下から検索。

 * [RPM CentOS 6 ntpdate 4.2.6p5 x86_64 rpm](http://rpm.pbone.net/index.php3/stat/4/idpl/25010016/dir/centos_6/com/ntpdate-4.2.6p5-1.el6.centos.x86_64.rpm.html)

以下のコマンドでSRPMを入手し、ntpdateの起動スクリプトのみを抽出しました。

```sh
wget ftp://ftp.is.co.za/mirror/smeserver/releases/testing/9.0beta2/smeupdates-testing/SRPMS/ntp-4.2.6p5-1.el6.centos.src.rpm
rpm2cpio ntp-4.2.6p5-1.el6.centos.src.rpm | cpio -idv ntpdate.init

# macの場合
brew install rpm2cpio
rpm2cpio.pl ntp-4.2.6p5-1.el6.centos.src.rpm | cpio -idv ntpdate.init
```

これで`/etc/rc.d/init.d/ntpdate`の中身が手に入れられます。

## ソースコード探検

### description

上から見ていきましょう。

```bash
#!/bin/bash
#
# chkconfig: - 57 75
# description: set the date and time via NTP

### BEGIN INIT INFO
# Provides: ntpdate
# Required-Start: $network $local_fs $remote_fs
# Should-Start: $syslog $named
# Short-Description: set the date and time via NTP
# Description: ntpdate sets the local clock by polling NTP servers
### END INIT INFO
```

このシェルスクリプトは何であるかが簡単に説明されています。
descriptionを見る限り、日付と時刻をNTPを通じてセットするもので、あくまでクライアントとしての機能であると書かれています。

### sourcing

```bash
# Source function library.
. /etc/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

prog=ntpdate
lockfile=/var/lock/subsys/$prog
ntpconf=/etc/ntp.conf
ntpstep=/etc/ntp/step-tickers
```

この`/etc/init.d/functions`は、`/etc/init.d/`以下のほぼ全ての起動スクリプトで読まれており、環境変数やdaemon関数、status関数などの基本的な設定・関数の置き場所です。

また、`/etc/sysconfig/network`はHOSTNAMEやGATEWAY、そしてNETWORKING(=BOOL)が格納されています。ntpdateのようなネットワークを利用するスクリプトの場合は、NETWORKINGの値が主に重要だと思います。

```bash
# See how we were called.
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  restart|force-reload)
    stop
    start
    ;;
  *)
    echo $"Usage: $0 {start|stop|status|restart|force-reload}"
    exit 2
esac
```

### status()

```bash
status() {
  [ -f $lockfile ] || return 3
}
```

### stop()

```bash
stop() {
  [ "$EUID" != "0" ] && exit 4
  rm -f $lockfile
}
```

### start()

```bash
start() {
  [ "$EUID" != "0" ] && exit 4
  [ "$NETWORKING" = "no" ] && exit 1
  [ -x /usr/sbin/ntpdate ] || exit 5
  [ -f /etc/sysconfig/ntpdate ] || exit 6
  . /etc/sysconfig/ntpdate

  [ -f $ntpstep ] && tickers=$(sed 's/#.*//' $ntpstep) || tickers=

  if ! echo "$tickers" | grep -qi '[a-z0-9]' && [ -f $ntpconf ]; then
    # step-tickers doesn't specify a server,
    # use servers from ntp.conf instead
    tickers=$(awk '$1=="peer"||$1=="server"{print $2}' $ntpconf | \
      egrep -v '127\.127\.[0-9]+\.[0-9]+')
  fi

  if ! echo "$tickers" | grep -qi '[a-z0-9]'; then
    echo $"NTP server not specified in $ntpstep or $ntpconf"
    exit 6
  fi

  echo -n $"$prog: Synchronizing with time server: "

  [ -z "$RETRIES" ] && RETRIES=2
  retry=0
  while true; do
    /usr/sbin/ntpdate $OPTIONS $tickers &> /dev/null
    RETVAL=$?
    [ $RETVAL -eq 0 ] || [ $retry -ge "$RETRIES" ] && break
    sleep $[10 * (1 << $retry)]
    retry=$[$retry + 1]
  done

  [ $RETVAL -eq 0 ] && success || failure
  echo
  if [ $RETVAL -eq 0 ]; then
    touch $lockfile
    [ "$SYNC_HWCLOCK" = "yes" ] && \
      action $"Syncing hardware clock to system time" \
      /sbin/hwclock --systohc
  fi
  return $RETVAL
}
```

```bash
# Options for ntpdate
OPTIONS="-U ntp -s -b"

# Number of retries before giving up
RETRIES=2

# Set to 'yes' to sync hw clock after successful ntpdate
SYNC_HWCLOCK=no
```
