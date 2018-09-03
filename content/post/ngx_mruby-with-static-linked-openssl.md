---
date: 2016-06-27T02:20:33+09:00
title: OpenSSL を静的リンクした ngx_mruby と動的証明書読み込みの基礎検証
tags:
- nginx
- ngx_mruby
- openssl
---
ngx_mruby で大量ドメインの証明書を動的に処理する[^1]には OpenSSL 1.0.2e 以上が必要となる[^2]。しかし、CentOS, Ubuntu, Debian の中では Xenial しか OpenSSL 1.0.2 をサポートしていない[^3]。それ以外の OS では、OpenSSLを自前ビルドするか静的リンクするのが良さそうだ。

最近、ngx_mruby の configure オプションに OpenSSL のソースを渡す機能が追加された[^4][^5]。そこで今回は、[hsbt/ngx_mruby-package-builder](https://github.com/hsbt/ngx_mruby-package-builder) をベースに、OpenSSL を静的リンクした ngx_mruby を rpmbuild する方法を調査した。その後、ビルドした ngx_mruby を使って動的証明書読み込みの簡単な動作検証を行った。

ビルド方法
---

まず、Dockerfile は以下のようになった。

```Dockerfile
FROM centos:7

RUN yum -y -q install bison gcc git make rake rpmdevtools wget which

RUN rpmdev-setuptree

# Get nginx
ENV NGINX_VERSION 1.11.1
RUN wget -q http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-$NGINX_VERSION-1.el7.ngx.src.rpm -P /tmp
RUN rpm -U /tmp/nginx-$NGINX_VERSION-1.el7.ngx.src.rpm
RUN yum-builddep -y -q /tmp/nginx-$NGINX_VERSION-1.el7.ngx.src.rpm

# Get OpenSSL
ENV OPENSSL_VERSION 1.0.2
RUN mkdir /usr/local/src/openssl && \
    wget -qO- https://www.openssl.org/source/openssl-$OPENSSL_VERSION-latest.tar.gz | \
    tar -xz -C /usr/local/src/openssl --strip=1

# Get ngx_mruby
ENV NGX_MRUBY_VERSION 1.18.0
RUN mkdir /usr/local/src/ngx_mruby && \
    wget -qO- https://github.com/matsumoto-r/ngx_mruby/archive/v$NGX_MRUBY_VERSION.tar.gz | \
    tar -xz -C /usr/local/src/ngx_mruby --strip=1

# build ngx_mruby with static-linked openssl
WORKDIR /usr/local/src/ngx_mruby
RUN ./configure -q --with-ngx-src-root=/root/rpmbuild/BUILD/nginx-$NGINX_VERSION --with-openssl-src=/usr/local/src/openssl
ADD build_config.rb /usr/local/src/ngx_mruby/build_config.rb
RUN make -s build_mruby
RUN make -s generate_gems_config

# rpmbuild
WORKDIR /root/rpmbuild/SPECS
ADD patches/centos/nginx.spec.patch /root/rpmbuild/SPECS/nginx.spec.patch
RUN patch -p0 < nginx.spec.patch
RUN rpmbuild -ba nginx.spec
```

nginx は 公式の source RPM を利用する。yum-builddep は yum-utils に同梱されているツールで、対象の source RPM のビルドに必要なパッケージをまとめてインストールする。今回は rpmdevtools の依存関係としてインストールされている。

また、ngx_mruby の configure オプションに `--with-openssl-src` をつけて OpenSSL 1.0.2 を指定している。build\_config.rb をカスタマイズしやすいように ADD しているが、デフォルトで良ければこれは不要。

最後の rpmbuild の直前で、OpenSSL や ngx_mruby を一緒にビルドするために nginx.spec へパッチを適用している。その patch ファイルは以下のようになった。

```diff
--- nginx.spec.orig
+++ nginx.spec
@@ -12,7 +12,6 @@
 Requires(pre): shadow-utils
 Requires: initscripts >= 8.36
 Requires(post): chkconfig
-Requires: openssl
 BuildRequires: openssl-devel
 BuildRequires: perl
 BuildRequires: GeoIP-devel
@@ -24,7 +23,6 @@
 Requires(pre): shadow-utils
 Requires: initscripts >= 8.36
 Requires(post): chkconfig
-Requires: openssl >= 1.0.1
 BuildRequires: openssl-devel >= 1.0.1
 BuildRequires: perl-devel
 BuildRequires: perl-ExtUtils-Embed
@@ -38,7 +36,6 @@
 Epoch: %{epoch}
 Requires(pre): shadow-utils
 Requires: systemd
-Requires: openssl >= 1.0.1
 BuildRequires: systemd
 BuildRequires: openssl-devel >= 1.0.1
 BuildRequires: perl-devel
@@ -120,6 +117,10 @@
         --with-mail_ssl_module \
         --with-file-aio \
         --with-ipv6 \
+        --without-stream_access_module \
+        --with-openssl=/usr/local/src/openssl \
+        --add-module=/usr/local/src/ngx_mruby \
+        --add-module=/usr/local/src/ngx_mruby/dependence/ngx_devel_kit \
         %{?with_http2:--with-http_v2_module}")

 Summary: High performance web server
```

静的リンクした OpenSSL を使うので、Requires から openssl パッケージは不要になった。むしろ Requires を抜いておかないと、ngx_mruby rpm をインストールするときに、openssl パッケージを要求されてしまう。

また、本記事から逸れるが、ngx_mruby の stream module を有効化するために `--without-stream_access_module` オプションを指定している。

残り3つのオプションが本記事の要である。`--with-openssl` `--add-module` オプションで OpenSSL と ngx_mruby, ngx_devel_kit のソースコードを指定している。

ところで、ngx_mruby v1.14.15 から依存パッケージの指定が git submodule から git subtree に変わっている。これにより、git submodule init を実行せずとも ngx_devel_kit や mruby が同梱されるようになっていた。

#### 今回作成したパッケージビルダのリポジトリ

これらの Dockerfile や patch ファイルをまとめたリポジトリを用意した。docker-compose で build -> run すれば RPM や deb パッケージが手に入るようになっている。

- [hfm/ngx_mruby-with-openssl-pkg-builder: Build ngx_mruby package with static-linked openssl](https://github.com/hfm/ngx_mruby-with-openssl-pkg-builder)

一応、CentOS6, Trusty, Xenial も用意したが、動作確認をしてないので自己責任でお願いします。あと、Xenial は OpenSSL 1.0.2 をパッケージインストール出来るため、あまり恩恵は無いかも。

OpenSSL を静的リンクした ngx_mruby の動作確認
---

nginx -V で "**built with OpenSSL 1.0.2h ...**" のような行が出力されていればビルドは成功している。

```console
[root@f671dfb76e9a /]# nginx -V
nginx version: nginx/1.11.1
built by gcc 4.8.5 20150623 (Red Hat 4.8.5-4) (GCC)
built with OpenSSL 1.0.2h  3 May 2016
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_perl_module=dynamic --add-dynamic-module=njs-1c50334fbea6/nginx --with-threads --with-stream --with-stream_ssl_module --with-http_slice_module --with-mail --with-mail_ssl_module --with-file-aio --with-ipv6 --without-stream_access_module --with-openssl=/usr/local/src/openssl --add-module=/usr/local/src/ngx_mruby --add-module=/usr/local/src/ngx_mruby/dependence/ngx_devel_kit --with-http_v2_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic'
```

パフォーマンス計測も含めたキチンとした動作検証は、証明書の準備などが大変なので別に回すとして、まずはリクエスト時の Server Name に対応した証明書が返ってくることを確認する。

適当な自己署名証明書と以下のような nginx.conf を用意し、 `nginx -p . -c nginx.conf` で動作させる。証明書は sample.com.{crt,key}, foo.com.{crt,key} という名前にした。

```nginx
events {
    worker_connections  1024;
}

http {
    server {
        listen      443 ssl http2;
        server_name _;

        ssl_protocols       TLSv1.2;
        ssl_ciphers         AESGCM:HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers on;
        ssl_dhparam         /etc/nginx/dhparam.pem;
        ssl_certificate     /etc/nginx/certs/dummy.crt;
        ssl_certificate_key /etc/nginx/certs/dummy.key;

        # SSLハンドシェイクのタイミングで servername に対応した証明書が読み込まれる
        mruby_ssl_handshake_handler_code '
          ssl = Nginx::SSL.new
          ssl.certificate = "/etc/nginx/certs/#{ssl.servername}.crt"
          ssl.certificate_key = "/etc/nginx/certs/#{ssl.servername}.key"
        ';

        location / {
            mruby_content_handler_code "Nginx.echo 'ssl test ok'";
        }
    }
}
```

これを curl で確認する。`--header 'Host: sample.com'` は TLS ClientHello のタイミングで Server Name を渡せなかった。別解を探していると、`--resolve` オプションを使って /etc/hosts などを使わずに名前解決できることがわかった[^6]。

最終的に以下のような curl コマンドで証明書を確認した。

```console
[root@d9811f8c3057 /]# curl -k -v --resolve sample.com:443:127.0.0.1 https://sample.com
* Added sample.com:443:127.0.0.1 to DNS cache
* About to connect() to sample.com port 443 (#0)
*   Trying 127.0.0.1...
* Connected to sample.com (127.0.0.1) port 443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
* skipping SSL peer certificate verification
* SSL connection using TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
* Server certificate:
*       subject: CN=sample.com,C=JP
*       start date: Jun 26 13:03:39 2016 GMT
*       expire date: Jul 06 13:03:39 2016 GMT
*       common name: sample.com
*       issuer: CN=sample.com,C=JP
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: sample.com
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx/1.11.1
< Date: Sun, 26 Jun 2016 17:13:10 GMT
< Content-Length: 12
< Connection: keep-alive
<
ssl test ok
* Connection #0 to host sample.com left intact
[root@d9811f8c3057 /]# curl -k -v --resolve foo.com:443:127.0.0.1 https://foo.com
* Added foo.com:443:127.0.0.1 to DNS cache
* About to connect() to foo.com port 443 (#0)
*   Trying 127.0.0.1...
* Connected to foo.com (127.0.0.1) port 443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
* skipping SSL peer certificate verification
* SSL connection using TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
* Server certificate:
*       subject: CN=foo.com,C=JP
*       start date: Jun 26 17:12:01 2016 GMT
*       expire date: Jul 06 17:12:01 2016 GMT
*       common name: foo.com
*       issuer: CN=foo.com,C=JP
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: foo.com
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx/1.11.1
< Date: Sun, 26 Jun 2016 17:12:59 GMT
< Content-Length: 12
< Connection: keep-alive
<
ssl test ok
* Connection #0 to host foo.com left intact
```

それぞれのリクエストの "Server certificate:" ブロックを見ると、**CN=sample.com** と **CN=foo.com** になっていることが分かる。

今回、Docker を用いて OpenSSL を静的リンクした ngx_mruby を rpmbuild し、それを使って動的証明書読み込みの簡単な動作検証を行った。自己署名証明書と nginx.conf, そして curl を用いて、 Server Name に応じた証明書が返ってくることを確認した。

簡単な設定だけで、大量ドメインの証明書を動的に処理することが出来るようになったが、パフォーマンスは hello world ベンチマークで 10% 程度の減少とされている[^7]ので、引き続きプロダクション導入における検証・検討を続けていく必要がある。

[^1]: [HTTP/2へのmruby活用やこれからのTLS設定と大量証明書設定の効率化について - 人間とウェブの未来](http://hb.matsumoto-r.jp/entry/2016/02/05/140442)
[^2]: https://github.com/matsumoto-r/ngx_mruby/blob/v1.18.0/src/http/ngx_http_mruby_module.c#L377-L383
[^3]: [Supporting HTTP/2 for Google Chrome Users | NGINX](https://www.nginx.com/blog/supporting-http2-google-chrome-users/)
[^4]: [Added `--with-openssl-src` to configure script by rhykw · Pull Request #167 · matsumoto-r/ngx_mruby](https://github.com/matsumoto-r/ngx_mruby/pull/167)
[^5]: https://github.com/matsumoto-r/ngx_mruby/wiki/Install#if-you-build-with-non-system-openssl
[^6]: https://curl.haxx.se/mail/archive-2015-01/0042.html
[^7]: https://speakerdeck.com/matsumoto_r/pfswokao-lu-sitatlszhong-duan-tongx-mrubyniyoruda-liang-domeinshe-ding-falsexiao-lu-hua?slide=18
