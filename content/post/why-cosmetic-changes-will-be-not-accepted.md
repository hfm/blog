---
date: 2016-06-13T09:09:00+09:00
title: なぜ受け入れないのか
draft: true
tags:
- hiera
---
社内 Slack に投下された、ある URL を見て知った Rails コミュニティのコントリビュートガイドラインの話。どんなPullRequestが受け入れられるのか、あるいは受け入れられないのか。
（正確には、これだけ大きなコミュニティなのだから、なにかしらガイドはあるだろうと思っていたけど、その文言を見たことはなかった。）

- https://github.com/rails/rails/pull/13771#issuecomment-32746700

この PR の変更内容は以下のように、 条件分岐のなかで使われていた `obj_a` を外側にまとめるというものだ（厳密にはちょっと違うのだけど、PR した当人はそのつもりだったのだろう）。

```diff
--- before	2016-06-13 11:37:40.000000000 +0900
+++ after	2016-06-13 11:37:32.000000000 +0900
@@ -1,6 +1,5 @@
 if cond
-  obj_a = value
   ...
-else
-  obj_a = value
 end
+obj_a = value
```

> Changes that are cosmetic in nature and do not add anything substantial to the stability, functionality, or testability of Rails will generally not be accepted (read more about [our rationales behind this decision](https://github.com/rails/rails/pull/13771#issuecomment-32746700)).
>
> Thanks for your contribution! However, this is a cosmetic change, and as noted in the the contributing to rails guide, we have a policy of not accepting these kind of changes.
>
> I know this might be thinking, "sure, it might not be adding much value, but I already wrote the code, so the cost is already paid – by me – so why not just merge it"? The reason is that there are a lot of hidden cost in addition to writing the code itself.
>
> Someone need to spend the time to review the patch. However trivial the changes might seem, there might be some subtle reasons the original code are written this way and any tiny changes have the possibility of altering behaviour and introducing bugs. (For example, in this case, do you know if self.name= and assign_names doesn't depend on controller_name being set? I don't – so I'd have to look it up and make sure. Also, there is a travis failure associated with this PR, it's probably a random failure, but I'd have to investigate to be sure). All of these work takes away time and energy that could be spent on actual features and bug fixes.
>
> It creates noise. There are currently 1,362 people watching this repo at the time of writing – these people will get an email from github everytime someone opens a new issue, comment on a ticket, etc. They do this (probably) because they want to watch out for PRs and issues that they care about, and these PRs will further lower the signal-to-noise ratio in these notification emails.
>
> It pollutes the git history. When someone need to investigate a bug and git blame these lines in the future, they'll hit this "refactor" commit which is not very useful.
>
> It makes backporting bug fixes harder.
>
> Theses are just some examples of the hidden costs that are not so apparent from the surface.
>
> It's awesome that you want to contribute to Rails, please keep the PRs coming! All we ask is that you refrain from sending these types of changes in the future (and read the contribution guide :). I hope you'll understand!
>
> P.S. I'm not picking on you – it's just that we seem to be getting more PRs in the cosmetic changes category, and so I wanted to take this chance to explain our position and have something I can link to in the future.

ちなみにこのコメントの後ろに、「Rails コミュニティはコードの品質向上は奨励されないことに驚いた」と皮肉っぽいコメントが寄せられている。この PR がコードの品質向上に貢献できているのかは置いといて、たかが diff といえど、そこに込められた意図や意義は人によって解釈に差異が出るものだなと感じた。（あと、テストがコケてしまっているので、たぶん品質の向上どころか、既存の状態を破壊してしまう変更になってるのも気掛かり）

参考
---

- [Contributing to Ruby on Rails 4.4 Write Your Code - Ruby on Rails Guides](http://guides.rubyonrails.org/contributing_to_ruby_on_rails.html#write-your-code)
- https://github.com/rails/rails/pull/13771#issuecomment-32746700
