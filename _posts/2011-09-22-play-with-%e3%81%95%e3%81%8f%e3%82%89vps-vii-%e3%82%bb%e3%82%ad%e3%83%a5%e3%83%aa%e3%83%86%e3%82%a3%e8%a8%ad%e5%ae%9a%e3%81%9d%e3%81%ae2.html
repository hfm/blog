---
layout: post
title: Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証
categories:
- Dev
tags:
- CentOS
- SakuraVPS
- ssh
status: publish
type: post
published: true
meta:
  _jd_tweet_this: 'yes'
  _jd_twitter: ''
  _wp_jd_clig: ''
  _wp_jd_bitly: http://bit.ly/reOUBf
  _wp_jd_wp: ''
  _wp_jd_yourls: ''
  _wp_jd_url: ''
  _wp_jd_target: http://blog.hifumi.info/dev/play-with-%E3%81%95%E3%81%8F%E3%82%89vps-vii-%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E8%A8%AD%E5%AE%9A%E3%81%9D%E3%81%AE2/?utm_campaign=twitter&utm_medium=twitter&utm_source=twitter
  _jd_wp_twitter: a:4:{i:0;s:159:"【ブログ編集】 Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証
    http://bit.ly/reOUBf - 前回　Play with さくらVPS 6 of steps";i:1;s:159:"【ブログ編集】 Play
    with さくらVPS vii セキュリティ設定その2 SSH鍵認証 http://bit.ly/reOUBf - 前回　Play with さくらVPS
    6 of steps";i:2;s:159:"【ブログ編集】 Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証 http://bit.ly/reOUBf
    - 前回　Play with さくらVPS 6 of steps";i:3;s:159:"【ブログ編集】 Play with さくらVPS vii セキュリティ設定その2
    SSH鍵認証 http://bit.ly/reOUBf - 前回　Play with さくらVPS 6 of steps";}
  _jd_post_meta_fixed: 'true'
  _edit_last: '1'
  _revision-control: a:1:{i:0;s:8:"defaults";}
  _syntaxhighlighter_encoded: '1'
  _yoast_wpseo_metadesc: 今回はMacからSSHでさくらVPSにログインする際、パスワード入力によるログインではなくRSA鍵を生成して鍵認証によるログインを実現します。
  _yoast_wpseo_metakeywords: さくらVPS, CentOS, RSA鍵認証, SSH
  _yoast_wpseo_title: Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証
  _aioseop_keywords: さくらVPS,CentOS,ssh,セキュリティ,公開鍵暗号,ssh-keygen
  _aioseop_description: 今回はMacからSSHでさくらVPSにログインする際、パスワード入力によるログインではなくRSA鍵を生成して鍵認証によるログインを実現します。
  _aioseop_title: Play with さくらVPS vii セキュリティ設定その2 SSH鍵認証
  dsq_thread_id: '1225541565'
---
前回　<a title="Play with さくらVPS 6 of steps セキュリティ設定その1" href="http://blog.hifumi.info/dev/play-with-%e3%81%95%e3%81%8f%e3%82%89vps-6-of-steps-%e3%82%bb%e3%82%ad%e3%83%a5%e3%83%aa%e3%83%86%e3%82%a3%e8%a8%ad%e5%ae%9a%e3%81%9d%e3%81%ae1/">Play with さくらVPS 6 of steps セキュリティ設定その1</a>

今回はMacからSSHでさくらVPSにログインする際、パスワード入力によるログインではなくRSA鍵を生成して鍵認証によるログインを実現します。

<a title="Play with さくらVPS 6 of steps セキュリティ設定その1" href="http://blog.hifumi.info/dev/play-with-%e3%81%95%e3%81%8f%e3%82%89vps-6-of-steps-%e3%82%bb%e3%82%ad%e3%83%a5%e3%83%aa%e3%83%86%e3%82%a3%e8%a8%ad%e5%ae%9a%e3%81%9d%e3%81%ae1/"><!--more--></a>
<h1>目次</h1>
<p style="padding-left: 30px;"><a href="#7-ssh">7. SSH鍵認証ログインの設定(for Mac)</a>
<a href="#7-1-ssh">7.1. Mac側でSSH鍵を生成する</a>
<a href="#7-2-ssh">7.2. さくらVPSにMacで作成した公開鍵を送信する</a>
<a href="#7-2-1-ssh">7.2.1. SFTPを使う場合</a>
<a href="#7-2-2-ssh">7.2.2. SCPを使う場合</a>
<a href="#7-3-ssh">7.3. さくらVPS側でログイン設定を変更する</a>
<a href="#7-3-1-ssh">7.3.1. さくらVPS側で.sshフォルダを作成する</a>
<a href="#7-3-2-ssh">7.3.2. sshd_configファイルを編集する</a>
<a href="#7-4-ssh">7.4. MacからSSHポート番号を変更後のさくらVPSへ簡単に接続する</a></p>

<h1><a name="7-ssh"></a>7. SSH鍵認証ログインの設定 (for Mac)</h1>
MacからさくらVPSへSSH接続するには、
<pre class="lang:default decode:true" title="MacからさくらVPSへのSSHログイン">$ ssh user@***.sakura.ne.jp</pre>
ユーザ名@ホストネームあるいはIPアドレスを打ち込むことでログインができます。SSHのポート番号を変更している場合（例えばSSH接続ポートを1001などにしている場合）は、
<pre class="lang:default decode:true" title="MacからさくらVPSへのSSHログイン（ポート番号指定付き）">$ ssh user@***.sakura.ne.jp -p 1001</pre>
こうなります。毎回このポート指定をするの面倒（<a title="Zshの設定プロファイルを用意する(.zprofileと.zshrc)" href="http://blog.hifumi.info/mac/zprofile-and-zshrc/">Zsh</a>とかで履歴のキーバインド検索を有効にしてると、ショートカットで履歴を一発検索できるようになるのでそういうのも要らないんですが）なので、後々何とかします。
<h2><a name="7-1-ssh"></a>7.1. Mac側でSSH鍵を生成する</h2>
Mac標準のターミナルを開いて、次のコマンドを入力しましょう。
<pre class="lang:default decode:true" title="Macのターミナルからssh-keygenコマンド">$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/user/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_rsa.
Your public key has been saved in id_rsa.pub.
The key fingerprint is:
**:**:**:**:**:**:**:**:**:**:**:**:**:**:**:** user_name@your_PC_name.local
The key's randomart image is:
+--[ RSA 2048]----+
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
|                 |
+-----------------+</pre>
ちなみにssh-keygenコマンドはオプション-bコマンドを使うとビット数指定できるんですが、デフォルトが2048bitですので、ssh-keygenだけで大丈夫だと思います。

順序は、
<ol>
	<li>生成するファイルパス及び名前を指定する（無指定だと<span class="crayon-inline">/Users/user/.ssh/id_rsaとid_rsa.pub</span>が生成される）。</li>
	<li>パスフレーズを聞かれるので、4文字以上で設定する。</li>
	<li> 再度確認されるので、同じパスフレーズを入力して確定。</li>
	<li>.sshフォルダ以下に秘密鍵id_rsaと公開鍵id_rsa.pubが生成される。</li>
</ol>
となります。
<pre>[Mac:~] user$ cd .ssh
[Mac:~/.ssh] user$ ls
id_rsa id_rsa.pub</pre>
こんな風に.sshフォルダにファイルが確認できれば問題ありません。
<h2><a name="7-2-ssh"></a>7.2. さくらVPSにMacで作成した公開鍵を送信する</h2>
Macからターミナルを使ってさくらVPSへ公開鍵を送信します。SFTPとSCP、二通り記述します。どちらも接続するためには、さくらVPSから与えられたユーザー名とホスト名を組み合わせて接続します。

Macのターミナルからsftpコマンドあるいはscpコマンドを用いてセキュアにファイルの転送をしましょう。また、ファイルパス指定の手間を省くために、sftp/scpコマンドを使う際には、MacのターミナルでMacユーザのホームフォルダ直下にある.sshフォルダにcdコマンドで移動しておきましょう。その方が楽です。
<h3><a name="7-2-1-ssh"></a>7.2.1. SFTPを使う場合</h3>
再びMacのターミナルから、SFTPを使って（Cyberduckでも通信できれば何でもいいですが）公開鍵id_rsa.pubをさくらVPSへ送信します。以下のステップは.sshフォルダ直下にいる状態で開始しています（ファイルパス指定が少し楽になります）
<pre>[Mac:~/.ssh] user$ sftp user@***.sakura.ne.jp
Connecting to VPSHostName //このあとパスワードを入力する
sftp&gt; put id_rsa.pub authorized_keys
Uploading id_rsa.pub to /home/VPSuser/authorized_keys
sftp&gt; quit</pre>
sftpモードになると、標準ではユーザのホームフォルダに転送できるので、putコマンドを使うときも特別ファイルパスを指定しなくても特に問題ありません。今回は１台目のMacとさくらVPSの間にSSH接続を実現したかったので、手っ取り早くid_rsa.pubをauthorized_keysに変更しています。

SFTP/SCP通信どちらを使っても構いません（多分）。やりたいこととしては、<strong>Macでssh-keygenを使って作成したRSA鍵の公開鍵をさくらVPS側に転送する</strong>、ということなので、それが達成できればCyberduckだろうがなんだろうが。
<h3><a name="7-2-2-ssh"></a>7.2.2. SCPを使う場合</h3>
<pre>[Mac:~/.ssh] user$ scp id_rsa.pub user@***.sakura.ne.jp:authorized_keys</pre>
パスワードを求められるので、それを入力すれば送信完了です。どちらもファイル名をid_rsa.pubからauthorized_keysに変えています。そのほうが手っ取り早いので。
<h2><a name="7-3-ssh"></a>7.3. さくらVPS側でログイン設定を変更する</h2>
<h3><a name="7-3-1-ssh"></a>7.3.1. さくらVPS側で.sshフォルダを作成する</h3>
先ほど送信したid_rsa.pub (authorized_keysに変更済み) を、さくらVPSに.sshフォルダを作成して、そこに移動させます。もちろんrootではなく作成してあるユーザで行います。
<pre>[VPS:~] user$ mkdir .ssh
[VPS:~] user$ mv authorized_keys .ssh/
[VPS:~] user$ chmod 700 .ssh
[VPS:~] user$ cd .ssh
[VPS:~/.ssh] user$ chmod 600 authorized_keys</pre>
ユーザのホームフォルダ直下に.sshフォルダを作成し、パーミッションを700 (drwx------) に設定し、転送しておいたauthorized_keysを.sshフォルダへ移動後、authorized_keysのパーミッションを600 (-rw-------) に設定します。
<h3><a name="7-3-2-ssh"></a>7.3.2. sshd_configファイルを編集する</h3>
/etc/ssh/sshd_configファイルを編集して、SSH接続に関して色々変更します。

具体的には、
<ol>
	<li>Rootからのログインを禁止する</li>
	<li>SSH接続のポート番号を変更する</li>
	<li>パスワードによるSSH接続を禁止する</li>
	<li>PAMの利用を禁止する</li>
</ol>
の４つを行います。
<pre>$ vi /etc/ssh/sshd_config
Port ** //デフォルトの22から変更する
PermitRootLogin No //Rootログインの禁止
AuthorizedKeysFile&gt; .ssh/authorized_keys //認証鍵パス指定
PasswordAuthentication no //パスワードログインの禁止
UsePAM no</pre>
#でコメントアウトされているところは、#を消してコメントアウトを解除して設定してください。

このあと、
<pre>[VPS:~] user$ sudo service sshd reload
sshd を再読み込み中:               [ OK ]</pre>
ここまで設定すれば、一度さくらVPSからログアウトして、再度ssh接続を試してみてください。初回だけ鍵に設定したパスワードを聞かれます。一度答えてしまえば、それ以降はssh接続をするとパスワードの入力抜きでログインできるようになります。

ただし、この設定をすると他のPCからSSH接続しようとすると弾かれてしまうのでご注意ください。複数台の端末からSSH接続を出来るようにするには、マシンごとのRSA鍵を生成して、その公開鍵をさくらVPSのauthorized_keysに逐次追記していけば良いと思います。詳しくは<a title="03.さくらインターネットVPSを使ってみる。〜複数のMacからssh接続〜" href="http://www.aguuu.com/archives/2010/09/sakura_internet_vps_03/" target="_blank">こちら</a>をご覧ください（リンク先はMacになってますが、Windowsでも似たような作業です）。
<h2><a name="7-4-ssh"></a>7.4.（ログインポート番号変更者向け）.ssh/configの設定</h2>
先ほどの「7.3.2. sshd_configファイルを編集する」で、SSHログインポートの変更をしました。再びさくらVPSにターミナルからSSHログインしようとすると、
<pre>Mac$ ssh user@***.sakura.ne.jp
ssh: connect to host ***.sakura.ne.jp port 22: Connection refused</pre>
となってしまいます。

そこで、Macの.sshフォルダ内にconfigファイルを作成して、特定のホスト或いはIPアドレスへ接続する時だけ自動でポート番号を指定するようにします。具体的には以下のとおり。
<pre>[Mac:~/.ssh] user$ vi config
Host ***.sakura.ne.jp
HostName ***.sakura.ne.jp
Port **** //ここにsshd_configで設定したPortの番号を入力する

Host *
ServerAliveInterval 60</pre>
configファイル内はこのように設定します。このように設定することで、次回よりMacからSSHコマンドでさくらVPSへ接続するときには、自動でconfigファイル内に記述されてあるポート番号を指定して接続してくれるようになります。
