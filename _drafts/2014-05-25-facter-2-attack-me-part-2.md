---
layout: post
title: 続・Facter 2.xにちょっと苦しめられた
tags:
- ruby
- facter
- puppet
---
[前回](/2014/05/30/facter-2-attack-me/)同様、Facter 2.xへのバージョンアップでハマったことを書き留めておきます。

今回は`Facter.value(:domain)`、つまりドメイン名の取得方法の変化です。

## Facter.value(:domain)の取得方法の変化

該当コードは[Comparing 1.6.x...facter-2 · puppetlabs/facter](https://github.com/puppetlabs/facter/compare/1.6.x...facter-2#diff-62)のR26-L44のdiffです。

```diff
-    if name = Facter::Util::Resolution.exec('hostname') \
+    # In some OS 'hostname -f' will change the hostname to '-f'
+    # We know that Solaris and HP-UX exhibit this behavior
+    # On good OS, 'hostname -f' will return the FQDN which is preferable
+    # Due to dangerous behavior of 'hostname -f' on old OS, we will explicitly opt-in
+    # 'hostname -f' --hkenney May 9, 2012
+    basic_hostname = 'hostname 2> /dev/null'
+    windows_hostname = 'hostname > NUL'
+    full_hostname = 'hostname -f 2> /dev/null'
+    can_do_hostname_f = Regexp.union /Linux/i, /FreeBSD/i, /Darwin/i
+
+    hostname_command = if Facter.value(:kernel) =~ can_do_hostname_f
+                         full_hostname
+                       elsif Facter.value(:kernel) == "windows"
+                         windows_hostname
+                       else
+                         basic_hostname
+                       end
+
+    if name = Facter::Core::Execution.exec(hostname_command) \
```

## 参考

- [Custom Facts — Documentation — Puppet Labs](http://docs.puppetlabs.com/guides/custom_facts.html)
- [puppetlabs/facter](https://github.com/puppetlabs/facter/)
