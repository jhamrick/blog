---
title: Why is making a git commit so complicated?
layout: post
permalink: /2013/04/03/why-is-making-a-git-commit-so-complicated/
comments: true
dsq_thread_id:
  - 1191948004
categories:
  - Programming
  - Software
tags:
  - education
  - teaching
  - git
  - version control
---

I've realized that I don't blog very often because I tend to write
very long and thorough posts. In an effort to try to start blogging
more, I'm going to let myself off the hook some of the time and just
write about something short. Perhaps this will get me more in the
habit of writing, which will then lead to more in-depth posts!

Anyway, today in our lab meeting I gave a presentation on using
[git][1]. As I was working on the presentation the past few days, I
struggled with a way to answer a question which I've been asked
multiple times:

 [1]: http://git-scm.com/

> Why does it take so many steps to make a commit?

<!-- more -->

If you are not working with a [remote repository][2], creating a git
commit will look something like this:

 [2]: http://git-scm.com/book/en/Git-Basics-Working-with-Remotes

1.  `git status` to check what's been modified
2.  `git add` to add new/modified files to the stage
3.  `git commit` to create the commit

(If you are working with a remote, you'll additionally have to `git
push`. If you're unlucky and your local repository and the remote
repository have diverged, you might also need to `git pull; git
push`. If you're *really* unlucky, there will be a merge conflict that
you need to resolve in between the `git pull` and `git push`.)

Even just three steps is quite a lot for a beginning git user to
remember -- and that's just for a single commit! So, how do you
justify this: why are there so many operations to do something
seemingly so simple?

The answer is actually one of the reasons why git is so powerful: it
offers you full control over what operations you are doing (in this
case, in the form of the *stage*). To explain this, I came up with the
following analogy:

> Creating a commit is like putting some documents in a box and then
> taping the box shut. You want to keep the contents of your boxes
> relatively organized, so you don't want to just put anything in any
> box -- there should be some systematicity to it. So, even if you
> have a whole bunch of documents that need to go in boxes, you don't
> necessarily want to put all those documents in the same box.

This the same idea behind staging in git: you don't necessarily want
to put all your changes in the same commit. So, you can put some
things in a box (stage files with `git add`), take things out if you
change your mind (unstage with `git reset`), and finally seal the box
when you're happy with what's in it (commit the changes with `git
commit`).

Here, `git status` isn't so much a part of the committing operation as
it is useful to see what changes are available to be committed. For
newcomers to git, rather than having them use `git status`, it might
be more useful to let them use a GUI tool to visualize the changes
that they've made (I happen to be a fan of [SourceTree][3]
myself). While I do think people should be able to use git from the
command line, I do not always think it is necessarily the best place
to start when someone is first learning.

 [3]: http://www.sourcetreeapp.com/
