---
title: Social Problems in Computer Science
layout: post
permalink: /2010/07/27/social-problems-in-computer-science/
comments: true
categories:
  - General
  - Programming
  - Software
tags:
  - computer science
  - elitism
  - hacking
  - teaching
  - education
---

This morning, I read a [blog post][1] about women in computer science
which was quite compelling. It reminded me, of course, of
[another article][2] about women in CS, and I began thinking about
about what my own opinion is on the subject. Sexism in CS and
similarly technical fields is certainly a problem. But why? And how
have I encountered it?

 [1]: http://www.stubbornella.org/content/2010/07/26/woman-in-technology/
 [2]: http://valerieaurora.org/howto.html

<!-- more -->

It struck me that I am incredibly lucky to be a student at MIT, where
I have never actually encountered blatant sexism. No one has ever
groped me, or told me I was incompetent because I was a woman (nor
have I ever felt that was the case). I was elected SIPB Chair, but it
was not that people thought I was sexy or that I slept with anyone,
but that I was the right person for the job. When I ask more
experienced hackers technical questions, they don't try to dumb it
down or tell me that I won't understand -- they explain it the same
way they would to anyone else. Really, I couldn't ask for a better
environment.

However, it still didn't feel quite like sexism (or something like it)
it was entirely absent. After thinking a while longer, I realized what
the problem was:

> The tech environment walks a fine line between being elitist and
> being a meritocracy, and often manages to slip back into elitism.

It's not so much a problem of sexism as it is a problem of general
attitude. Becoming good at dealing with computers takes a lot of
hands-on experience. There aren't any classes that will teach you how
to debug NetworkManager or how to reconfigure your X configuration so
that gdm doesn't fail. So those of us who like figuring out the
answers to such problems have only a handful of options: 1) learn
everything using Google, 2) learn everything by asking an expert, 3)
both 1 and 2, or 4) give up. Sometimes, if the problem is specialized
enough, 2 and 4 are really the only options. Unfortunately, it is
often the case when asking an experienced hacker that they will give a
harsh, unhelpful, and/or elitist response. Here's an example.

> **Person A:** I need to reinstall this computer with Debian, but I
> don't have a CD or DVD burner or any flash media. I'm not sure if I
> have any other options. Could you help me?  
> **Person B:** I don't have time. Just use PXE.  
> **A** (thinking)**:** PXE, what's that? I guess I'll Google it. Hmm,
> well, Wikipedia says it's a way of booting your computer over the
> network. I guess sort of like a livecd, except over the network?
> That's kind of cool. How do I do it? [This site][3] seems to give
> some links. Looks like the Debian link is broken, so I'll use the
> Red Hat link and see if I can just change the relevant things.
> [an hour passes]  
> **A** (frustrated)**:** This isn't working. How am I supposed to
> install my computer over the internet if I have to install stuff to
> the computer to begin with? I don't understand how this works!  
> **B:** ... what the hell are you doing? You just choose the
> "netboot" option in your BIOS, like you would choose to boot from
> CD-ROM or hard drive, etc.  

 [3]: http://www.kegel.com/linux/pxe.html

Do you see what Person B did wrong, here? Person A was asking for
help, and clearly does not know about netbooting (or they wouldn't
have asked). Person B assumes they know what PXE is and that they know
how to use it, or at least that they can figure it out for
themselves. Unfortunately, the documentation on PXE is unhelpful and
misleading and never mentions needing to change a setting in your
BIOS. Person A tried to figure it out themselves using the vague
information given to them by Person B, but only managed to waste an
hour and become even more confused! Furthermore, when Person A comes
back for more help, Person B acts like they are an idiot for being
ignorant and confused, and treats them with disdain. *It would have
been so much nicer, faster, and easier for Person B to simply say in
the first place "try using the netboot option in your BIOS to boot
into the installer over the internet".*

In my experience, the sort of attitude taken by Person B, either
intentionally or unintentionally, is the most formidable obstacle
facing new tech-oriented people. In particular, I have noticed that
men tend to be better at muscling their way through this "barrier of
newbie shame". Many studies have shown that women tend to be less
confident and less assertive than men, and when the environment is
such that you *have* to be assertive and confident in order to get
anywhere, it is no wonder that many choose to give up and choose a
different path. Being ignorant does not make you dumb, but many people
in CS act like it does.

*There is no reason why the tech environment should be so elitist.* I
heartily agree that it must retain a degree of meritocracy: you need
to earn your respect as a hacker. However, everyone has to start
somewhere; no one is born with awesome hacking abilities, and not
everybody is as able to figure out how things work without a few
pointers. Wouldn't it be so much better to have more skilled people in
computer science, to fix even more bugs and create even more brilliant
pieces of software? I believe that if we could tone down the elitism,
such a world would become a reality.

Unfortunately, it's not as easy as just recognizing what the problem
is. Being elitist is not always a conscious or deliberate action (most
people are not so much of an ass to say "I won't be helpful because I
am better than you") -- it is usually just the easy way out. Becoming
a hacker in an elitist environment makes it all too simple to just
assume that that is the correct way of doing things. It is easy to
fall into the mindset of "I had to deal with and stand up to that sort
of bullshit when I was new, so why shouldn't everyone else?". It is
easy to find yourself too busy to really help, so you just brush them
off with a short, unhelpful answer or tell them to RTFM. It is easy to
forget that you were once the confused, ignorant newbie who didn't
have the background that you now do.

In addition, I think that many people become rough and abrasive
because they are all too often asked to *fix things themselves* as
opposed to *giving advice*. Every tech person is all too familiar with
friends, relatives, and acquaintances asking them to fix computers or
install software, and most tech people I know hate it. It is
especially frustrating when people who are nominally technically
competent ask you to do things for them. The urge to say "no, go
figure it out yourself!" is extremely strong, and it is easy to lump
favor-seekers into the same category as advice-seekers. But it is
important to make the distinction, and to actually be helpful when
someone asks for advice.

So, how can we fix this problem? Recognizing that it is a problem is a
first step, but it is not enough. Changing things will not be quick or
easy, either. But, there are a few things we can try:

1.  If you are too busy to help, politely say so and apologize that
    you don't have the time. Don't give vague or cryptic answers.
2.  Don't assume that they have the same background of knowledge that
    you do, because they probably don't. Try to explain things at
    their level. That doesn't mean "dumb it down", but "make sure to
    include relevant pieces of knowledge that you have but they
    don't".
3.  Point them towards documentation which you know is helpful,
    instead of just throwing terminology around.
4.  Be polite, even if they are asking what seems like a dumb question
    or asking you to do something for them. You can say "no, that's
    not my job" or "no, I don't have time right now" without being
    rude and abrasive.

From now on, I will try to point out this phenomenon of elitism to
people I know in CS, and encourage them to be more conscientious of
their interactions with aspiring hackers. I hope that you will, too!
I'd also love to hear any other opinions on this matter. Have you
encountered this elitist environment elsewhere? How have you dealt
with it?
