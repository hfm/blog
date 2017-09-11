---
date: 2017-09-10T04:34:23+09:00
title: MogileFS と STRICT_TRANS_TABLES
draft: true
tags:
- mogilefs
- mysql
---
MogileFS 

(process_deletes2サブルーチンの一部)

https://github.com/mogilefs/MogileFS-Server/blob/2.72/lib/MogileFS/Worker/Delete.pm#L210-L216

```perl
# devid is observed down/readonly: delay for at least
# 10 minutes.
unless ($dev->observed_writeable) {
    $sto->reschedule_file_to_delete2_relative($fidid,
        60 * (10 + $todo->{failcount}));
    next;
}
```

https://github.com/mogilefs/MogileFS-Server/blob/2.72/lib/MogileFS/Device.pm#L92-L101

```perl
sub host_ok {
    my $host = $_[0]->host;
    return ($host && $host->observed_reachable);
}

sub observed_writeable {
    my $self = shift;
    return 0 unless $self->host_ok;
    return $self->{observed_state} && $self->{observed_state} eq 'writeable';
}
```

https://github.com/mogilefs/MogileFS-Server/blob/2.72/lib/MogileFS/Store.pm#L1880-L1887

```perl
sub reschedule_file_to_delete2_relative {
    my ($self, $fid, $in_n_secs) = @_;
    $self->retry_on_deadlock(sub {
        $self->dbh->do("UPDATE file_to_delete2 SET nexttry = " . $self->unix_timestamp . " + ?, " .
                       "failcount = failcount + 1 WHERE fid = ?",
                       undef, $in_n_secs, $fid);
    });
}
```

```sql
Create Table: CREATE TABLE `file_to_delete2` (
  `fid` int(10) unsigned NOT NULL,
  `nexttry` int(10) unsigned NOT NULL,
  `failcount` tinyint(3) unsigned NOT NULL DEFAULT '0', -- 👈
  PRIMARY KEY (`fid`),
  KEY `nexttry` (`nexttry`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
```

failcount は tinyint(3) なので 0 ~ 255 の値を取りうる。

file\_to\_replicate テーブルにも同じようなことをやっている

STRICT\_TRANS\_TABLES や STRICT\_ALL\_TABLES
