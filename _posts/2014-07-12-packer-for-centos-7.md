---
layout: post
title: CentOS 7用のVagrant BoxをPackerで作った
tags:
- packer
- vagrant
- linux
- rhel
---
CentOS 7がリリースされていた [^1] ので、PackerでVagrant用Boxをビルドしてみた。

- [tacahilo/packer-centos-7](https://github.com/tacahilo/packer-centos-7/)

```
vagrant up hfm4/centos7
```

とすればアップできるように、vagrantcloudにも登録した [^2]。

1つハマった所があり、VBoxGuestAdditionsが4.3.12だとビルドに失敗してsynced folder [^3] がうまくいかなかった。
インストールスクリプトの一部がコケてしまうようで、gistに当時のvboxadd-install.logを貼り付けた。興味のある方は覗いていただけるといい。

- https://gist.github.com/tacahilo/fb866af81171dc31105d

当時のバグの原因は、どうやら以下のものに該当するらしい。

- [#12638 (VBOXADDITIONS_4.3.4_91027 does not compile in RHEL-7 beta) – Oracle VM VirtualBox](https://www.virtualbox.org/ticket/12638)

この問題は、https://www.virtualbox.org/download/testcase/VBoxGuestAdditions_4.3.13-94832.iso を使えばいいよ、と[Issueでコメントをもらい](https://github.com/tacahilo/packer-centos-7/issues/1#issuecomment-48670603) [^4]、そのとおりにしたら解決した。
ところでこの`testcase`というディレクトリは何なんだろう…。

色々ググっていると、VBoxGuestAdditionsのバージョンによってビルドがうまくいかない、という現象は割と起きていることがわかった。やっぱりVMWareがいいのかな。


Kernelソースがまともに読めないので、VBoxGuestAdditionsの実装のどこに不具合があるのかがいまいち分かっていないので、根本的な原因がわからないのが歯がゆいので、もう少し調べようと思う。

[^1]: [Release Announcement for CentOS-7/x86_64 – Seven.CentOS.org](http://seven.centos.org/2014/07/release-announcement-for-centos-7x86_64/)
[^2]: [hfm4/centos7](https://vagrantcloud.com/hfm4/centos7)
[^3]: [VirtualBox Shared Folders - Synced Folders - Vagrant Documentation](http://docs.vagrantup.com/v2/synced-folders/virtualbox.html)
[^4]: これは正式リリースではないのか、http://download.virtualbox.org/virtualbox には`4.3.12`と`4.3.14_RC1`がある
