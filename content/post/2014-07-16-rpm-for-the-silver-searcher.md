---
layout: post
title: Vagrantでag(the silver searcher)のrpmを作る
date: 2014-07-16
tags:
- packer
- vagrant
- linux
- rhel
---
agことthe silver searcher[^1]のrpmを作るスクリプトを用意した[^2]。

```sh
#!/bin/sh
# usage: vagrant up --provision

set -e

version='0.23.0'
ag_source="https://github.com/ggreer/the_silver_searcher/archive/${version}.tar.gz"

# INSTALL BUILD TOOL
sudo yum -y groupinstall "Development Tools"
sudo yum -y install pcre-devel xz-devel zlib-devel

# SET RPMMACROS
cat <<'EOS' > /home/vagrant/.rpmmacros
%_topdir      /home/vagrant/rpmbuild
%debug_package %{nil}
EOS

# SET RPM DIRECTORY
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
curl -L $ag_source -o ~/rpmbuild/SOURCES/the_silver_searcher-${version}.tar.gz

# GET SOURCE OF AG
tar xfzv ~/rpmbuild/SOURCES/the_silver_searcher-${version}.tar.gz -C ~/rpmbuild/BUILD
~/rpmbuild/BUILD/the_silver_searcher-${version}/build.sh
cp -a ~/rpmbuild/BUILD/the_silver_searcher-${version}/the_silver_searcher.spec ~/rpmbuild/SPECS

# BUILD
rpmbuild -ba ~/rpmbuild/SPECS/the_silver_searcher.spec
mv ~/rpmbuild/RPMS/$(uname -i)/* /vagrant
```

これを、例えば`build-ag-rpm.sh`という名前にして、Vagrantfileのprovisionに指定する。

```rb
Vagrant.configure("2") do |config|
  config.vm.box = "hfm4/centos6" # vagrantcloudに登録したCentOS 6.5 x86_64のbox
  config.vm.hostname = "build-ag-rpm.dev"
  config.vm.provision :shell do |shell|
    shell.path = "build-ag-rpm.sh"
    shell.privileged = false
  end
end
```

最後にvagrantを以下のように起動すればいい。

```sh
vagrant up --provision
```

provisionが無事終わると、Vagrantfileのあるディレクトリにagのrpmが置かれている。

[^1]: [ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher)
[^2]: [いまさら聞けないrpmbuildことはじめ - blog.tnmt.info](http://blog.tnmt.info/2011/04/29/rpmbuild-for-beginner/)
