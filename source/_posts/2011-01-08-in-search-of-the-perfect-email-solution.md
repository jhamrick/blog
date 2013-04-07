---
title: In Search of the Perfect Email Solution
layout: post
permalink: /2011/01/08/in-search-of-the-perfect-email-solution/
comments: true
categories:
  - Software
tags:
  - android
  - email
  - gmail
  - gpg
  - imap
  - offlineimap
  - software
  - sup
  - technology
  - thunderbird
---

Wow, it's been a long time since I blogged last. I should fix that. 
Also, the site has a new theme! I hope you enjoy it. Anyway, onto
the content...

Over the course of the years, I came to realize that I was
dissatisfied with my email solution. Back in middle school, I used
Hotmail (yuck). Then Gmail came out, which was shiny and fantastic,
and I used that exclusively until I came to MIT. Once I discovered SSH
and that pine was automatically configured with all my mail on Athena
machines, I started using that. Then I found alpine. Then I got tired
of having to SSH into a screen session somewhere every time I wanted
to check my mail, so I switched back to Gmail again.  I eventually
became frustrated with GMail's slowness and the fact that they didn't
support GPG, so I switched back to MIT's IMAP and used
Thunderbird. And so the hilarity began...

<!-- more -->

That was roughly six months ago. I have since settled on something
more satisfactory, but still by no means perfect (more on why it is
unsatisfactory in a minute). But I have certainly learned a great
deal about email and email clients in the process, so hopefully I can
share with you my trials and tribulations to make your own search
easier.

By the time I started using Thunderbird for the first time, I had a
pretty good idea of what things I wanted in my email solution:

1. **Speed**. I want my mail client to load emails quickly and to
  perform operations quickly. I hate that Gmail tends to load so
  slowly (either the website or its IMAP interface); I want to be
  able to manipulate my emails fast and easily.

2. **Server-Side Address Book.** It is so irritating to have to take
  all my contacts and export them and load them on my other
  computers, and synchronize them every so often. It's more trouble
  than it's worth, so when there's no way to do it, I just end up
  not bothering with an address book at all. Unfortunately, there
  really isn't a solution to this outside of Gmail. Well, there's
  LDAP, but that doesn't *really* count, and there's Exchange, but
  if I switch to Exchange at MIT then there's no going back, and I
  don't want to be locked into something like that.

3. **Server-Side Filters.** I really don't want to have to implement
  the dozens of filters I have on every one of my computers. Again,
  the only real solution to this is Gmail (and Gmail's filtering
  system kind of sucks because it doesn't support regexes).

4. **GPG Support. **Some people laugh at me for signing all my emails
  with my GPG key, but I like to try to follow the "safe is better
  than sorry" mantra. No, I'm not *actually* worried that somebody
  is going to try to impersonate me over email, but you never know,
  right? Most clients have support for GPG in some way or another,
  but it varies on how well it works. Gmail's web interface doesn't
  have any GPG capabilities at all (though I've heard a rumor you
  can use FireGPG to do it for you).

5. **Android Support.** However I access my mail from my computers, I
  want to be able to access it in the same way from my phone. That
  includes being alerted when I have new mail, and not having to run
  ConnectBot to SSH somewhere to check it.

6. **Threading.** It's gotta have threading. Ok, it's workable if
  you're using a computer with a large enough screen that can also
  store all your mail (e.g., tens of thousands of messages), but you
  can't do that on a phone. If I need to be able to find an email,
  I want to be able to do it because the thread is in my inbox, and
  not have to search for each message in the thread individually. 
  Really good threading (like that found in [sup][1]) is preferable,
  but even Gmail-style threading is good enough for me.

 [1]: http://sup.rubyforge.org/

Gmail has 4/6 of these, with the two missing being speed and GPG
support. Not too shabby. But when I've just woken up and am checking
my mail, and it's taking a minute to load, it's enough to make me want
to switch to something better.

For a while I tried just using Thunderbird with MIT's IMAP, but that
lacks server side address-booking, filters, and in practice Android
support as well, as I have not yet found an email client on Android
(besides the Gmail app) that handles threading. This solution just
wasn't satisfactory enough for me, so I tried using Thunderbird with
Gmail's IMAP. That gave me 5/6, but dramatically decreased the speed
at which emails loaded. Well, maybe it was the same speed as using
the web, but it at least *felt* like it was slower, because every time
you clicked on a folder, it would have to refresh the folder, and then
every time you clicked on a message, it would have to refresh the
message... it was ugly, and not very fun. Furthermore, because of the
way that Gmail's IMAP works, you end up with multiple copies of every
message: one in Inbox, one in All Mail, and one in every other folder
that corresponds to any tags the email might have. When you read the
message in the Inbox, the messages in the other folders remain unread
until the next sync, which bugs the hell out of me.

So, Gmail IMAP Thunderbird was a no. At this point, I was feeling
adventurous, so I decided to set up my own mail server. I installed
Cyrus and Postfix on my server, and set up my own filters using
[Sieve][2]. I attempted to use LDAP for address booking, but quickly
gave up on that because LDAP is horribly confusing and opaque. This
worked pretty well in conjunction with Thunderbird -- I had speedy
email retrieval, server-side filters, GPG support, and threading. 
After a while, though, I became fed up with how much of a pain in the
ass it was to update my filters (I had to SSH to my server and update
the filter file by hand, then re-add it to the Sieve configuration). 
Furthermore, I was still bumping into the same
no-threading-support-on-Android problem as I had with MIT IMAP.

 [2]: http://sieve.info/

Back to the drawing board. I switched back to MIT IMAP and started
running [sup][1] in a screen session on my server. Sup is a wonderful
little program; it's terminal-based (which I like) and has the best
threading support I've ever seen (you can even join threads together
that it misses!). It's also blindingly fast, because you have to set
up [offlineimap][3] to fetch all of your mail, and then sup just loads
it off of the disk. I used sup for nearly six months before its cons
started to gnaw at me -- it has a terrible address book, I couldn't
get GPG to work, it doesn't play nicely with other mail clients, and
crashes more frequently than I would like. I had been running sup out
of the [maildir-sync][4] branch, which at least allowed me to mark
messages as read/deleted/etc. on the server. However, because sup
does everything with labels (as opposed to folders), accessing your
mail from a normal IMAP client is a pain. I would get email on my
phone and read it, but when when I got back to my computer, I'd have
to go through and archive all the emails I'd already read (and, of
course, I still had the Android threading issue). I don't like having
to go through messages twice if they're unimportant, so having to do
that was a big nuisance for me.

 [3]: https://github.com/jgoerzen/offlineimap/wiki
 [4]: http://www.mail-archive.com/sup-devel@rubyforge.org/msg00566.html

I decided to give Gmail IMAP Thunderbird another go, but the moment I
brought it up I knew I would get fed up with the slowness soon. My
adventures with sup had taught me about [offlineimap][3], so I
thought, "why not use offlineimap to make Thunderbird load messages
faster?". This required a bit more work than I initially thought --
Thunderbird doesn't support accessing Maildirs directly; you have to
actually access an IMAP or POP server. To solve this, I installed
[Dovecot][5], pointed it at my Maildir, and just had it listen locally
for IMAP connections. Then I was able to point Thunderbird at the
local IMAP server, and voila! I had fixed my speed problem. I set up
a cron job to run offlineimap every few minutes, and installed the
[RunBeforeGetMail][6] plugin to allow me to run offlineimap *right
now* if I really wanted to. The one downside with offlineimap is that
it is kind of slow in updating, but that's to be expected because
Gmail is so slow in the first place.

 [5]: http://www.dovecot.org/
 [6]: https://addons.mozilla.org/en-US/thunderbird/addon/153352/

So, Gmail IMAP offlineimap Dovecot Thunderbird is my current solution,
and I'm fairly happy with it. I can access my emails quickly, I have
a synchronized server-side addressbook and filtering system, I have
GPG and Android support, and some amount of threading (Thunderbird
doesn't do threading that well, but it's good enough). The only
problem that really still remains is that duplicate messages in All
Mail or other folders don't get marked as read until the next sync. 
This is irritating, and may cause me to switch eventually, but more
than likely I'll end up writing a plugin for Thunderbird to mark those
messages as read automagically.

If you'd like to duplicate my mail setup, here's what you need to do:

1. Turn on IMAP in Gmail.

2. Install offlineimap and configure it to access your Gmail IMAP.
   You might need to be careful when syncing for the first time if you
   have a lot of messages; I reached the daily bandwidth limit (twice)
   as I was bringing offlineimap up to speed. This will also take an
   extremely long time, as again, Gmail is slow.

3. Install Dovecot and configure it to access the Maildir where
   offlineimap stores your email. Unless you want to be able to access
   this email remotely, you probably want to have Dovecot only listen
   to localhost.
   
4. Install Thunderbird and point it at your local configuration. You
   can just put in 'localhost' and whatever port you're using for the
   incoming settings, and then use Google's SMTP server to send mail
   (or, if you're like me and don't actually use your Gmail address,
   point it at some other SMTP server, like MIT's).
   
5. Install some Thunderbird plugins! I would be very unhappy with my
   current setup without the following (and as of this writing, I am
   running Thunderbird 3.1.7):

	* [Enigmail][7] - adds GPG support
	* [G-Hub Lite][8] - adds tabs for various Google services (I use
      Calendar, Voice, Reader, and sometimes Docs)
	* [Gmail Conversation View][9] - significantly improves
	  Thunderbird's threading experience, by displaying entire
	  conversations (even after you've archived some of the messages
	  in that thread)
	* [Google Contacts][10] - allows you to use Google Contacts for
      your address book.
    * [Message Archive Options][11] - allows you to archive messages
      into just one folder, as opposed to creating separate folders
      for each year.
    * [RunBeforeGetMail][6] - lets you run an external command before
      Thunderbird fetches your mail (but it only works when you
      actually press the 'Get Mail' button)

 [7]: https://addons.mozilla.org/en-US/thunderbird/addon/71/
 [8]: https://addons.mozilla.org/en-US/thunderbird/addon/59195/
 [9]: https://addons.mozilla.org/en-US/thunderbird/addon/54035/
 [10]: https://addons.mozilla.org/en-US/thunderbird/addon/7307/
 [11]: https://addons.mozilla.org/en-US/thunderbird/addon/14896/

Hopefully this will help some of you figure out a solution to your
mail troubles. There is no perfect solution, but I feel like this at
least gets pretty close.
