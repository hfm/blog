---
date: 2016-08-07T11:00:38+09:00
title: GPG署名付きコミット
draft: true
tags:
- git
---

OSX の場合、GnuPG は `brew install gpg2` で手に入る。

名前とメールアドレスさえ分かれば、なりすましは容易である。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">コミットした覚えがないリポジトリが。気持ち悪い。link: Commits · runnez/sol.js: <a href="https://t.co/S33igj9PEc">https://t.co/S33igj9PEc</a></p>&mdash; Yukihiro Matsumoto (@yukihiro_matz) <a href="https://twitter.com/yukihiro_matz/status/745256966679732224">2016年6月21日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

![](/images/2016/08/07/new-gpg-key.png)


```console
$ gpg2 --gen-key
```

2年 RSA 鍵 4096bit

```sh
gpg2 --armor --export $(gpg2 --list-secret-keys --keyid-format LONG | awk '$1~/^sec$/ {print $2}' | sed -E 's@.+/@@') | pbcopy
```

![](/images/2016/08/07/add-gpg-key.png)

```sh
git config --global gpg.program gpg2
git config --global user.signingkey $(gpg2 --list-secret-keys --keyid-format LONG | awk '$1~/^sec$/ {print $2}' | sed -E 's@.+/@@')
```

```console
$ git commit --amend -S

You need a passphrase to unlock the secret key for
user: "OKUMURA Takahiro <hfm.garden@gmail.com>"
4096-bit RSA key, ID 45FB072A, created 2016-07-31

gpg-agent[86423]: command get_passphrase failed: Inappropriate ioctl for device
gpg: problem with the agent: Inappropriate ioctl for device
gpg: skipped "766BE37045FB072A": Operation cancelled
gpg: signing failed: Operation cancelled
error: gpg failed to sign the data
```

```sh
GPG_TTY=$(tty)
export GPG_TTY
```

```sh
brew install pinentry-mac

echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
```

![](/images/2016/08/07/verified.png)

- [Generating a GPG key \- User Documentation](https://help.github.com/articles/generating-a-gpg-key/)
- [Signing commits using GPG \- User Documentation](https://help.github.com/articles/signing-commits-using-gpg/)
- [Git \- Signing Your Work](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)
