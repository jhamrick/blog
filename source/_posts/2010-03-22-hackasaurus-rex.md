---
title: Hackasaurus Rex
layout: post
comments: true
permalink: /2010/03/22/hackasaurus-rex/
categories:
  - SIPB
tags:
  - gutenbach
  - hackathon
  - MITeX
  - SIPB
  - software
---

[![][1]][2] This past weekend, [SIPB][2] held a [hackathon][3] (an
event where people come and work on various computer projects). SIPB,
the Student Information Processing Board, is the student group at MIT
in which I am most heavily involved. SIPB is essentially MIT's
computer club, and I had the honor of being elected Chair in
February. [Greg Brockman][4], my co-conspirator in SIPB administration
(aka, the Vice Chair) organized the whole thing almost single-handedly
-- from finding sponsors and advertising on Facebook, to making sure
there would be projects for everybody to work on.

 [1]: /images/hackasaurus.png
 [2]: http://sipb.mit.edu
 [3]: http://hackathon.mit.edu
 [4]: http://blog.gregbrockman.com/

<!-- more -->

This particular hackathon, entitled Hackasaurus Rex ("the king of all
hackathons"), featured prizes from [ThinkGeek][5] and mango lassis. It
was, in my opinion, a huge success. Over 50 people showed up over the
course of the evening, and the office had 5-10 people until about 4am
(even at the very beginning, when the office is usually pretty empty
during hackathons). We recruited several new people to SIPB, and even
got existing SIPB people involved in new projects! I am very pleased
with how it went.

 [5]: http://www.thinkgeek.com/index.shtml

I personally worked on [Gutenbach][6] and [MITeX][7]. Gutenbach is the
software the runs sipbmp3, the music player we have in the office,
which works by printing music files to a special printer: the printer
send the file through a filter (which pipes the song to mplayer), and
finally dumps the data not to an actual hardware device, but to
/dev/null. Gutenbach/sipbmp3 was originally built using lprng, but
given that all of MIT is migrating to CUPS, I figured it would be a
good time to move Gutenbach to CUPS as well. I played more of an
administrative role for Gutenbach during the hackathon, and got people
working on patching the filter and the configuration parts of the
Debian package.

 [6]: https://launchpad.net/~jhamrick/ archive/ppa
 [7]: http://mitex.mit.edu

Once that got started, I turned my attention to MITeX. A few of us
were in the SIPB office the other day, bemoaning the fact that few
people around MIT know how to use LaTeX, and that the activation
energy needed to learn it is beyond what most people are willing to
give. Wouldn't it be nice if there was an easy way for students to
write a document, and have it be tex'ed for them? Well, there's LyX,
which doesn't let you edit the LaTeX source, and has terrible support
for loading templates (I'd rather use my emacs with AUCTeX, thank you
very much). So, we thought, why don't we create our *own* application,
one specifically geared towards the types of documents MIT students
need to create? We could make it be a web application, meaning no
installation required! And thus, MITeX was born.

So, at the hackathon, we began work. We now have an interface that
provides four different templates to choose from, allows you to create
your document, and save it as either a .tex, .pdf, or .ps file. You
can also test-compile it to view the log output. Next step: WYSIWYG
editor, for people who don't understand LaTeX code. It doesn't look
like much yet, but all in all, we got quite a bit done.

Many other projects also got worked on during the hackathon, including
anygit (an index of the world's git repositories), [Scripts Pony][8],
[MacAthena][9], [QuickPrint][10] and the apt-zephyr hook (which sends
a [zephyr][11] when aptitude takes updates). Some [Planet Libre][12]
people also showed up and worked on their own stuff later in the
evening.

 [8]: http://pony.scripts.mit.edu/
 [9]: http://macathena.mit.edu/
 [10]: http://quickprint.mit.edu/
 [11]: http://sipb.mit.edu/doc/zephyr/
 [12]: http://www.fsf.org/associate/meetings/2010/

Given how much work got done, and how many new people we introduced to
SIPB during this hackathon, I think that SIPB will need to continue to
have such awesome hacking parties of this magnitude every so often!
It's probably not feasible to do it every month, but once or twice a
semester seems like a reasonable rate. Look forward to more exciting
hackathons in the future!

