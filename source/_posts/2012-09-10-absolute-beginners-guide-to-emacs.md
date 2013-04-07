---
title: 'Absolute Beginner&#8217;s Guide to Emacs'
layout: post
permalink: /2012/09/10/absolute-beginners-guide-to-emacs/
comments: true
dsq_thread_id:
  - 1191992058
categories:
  - Software
tags:
  - emacs
  - software
  - technology
  - tutorial
---

I've been using Emacs () as my primary text editor for several years
now. It takes some getting used to -- the keyboard shortcuts are
completely different from what you're probably familiar with,
e.g. Ctrl-C for copy and Ctrl-V for paste. Despite the somewhat steep
initial learning curve, however, I find that Emacs is invaluable for
rapid coding and for flexibly editing all different types of files in
the same environment.

I remember how overwhelming it was to figure out how to do anything
when I first got started, so in this tutorial I'm going to aim to give
you the basics to get started. This is by no means a complete guide to
Emacs (though if you have suggestions for things to add, I'd be happy
to do so), but hopefully should be enough to start comfortably using
Emacs as a text editor.

This tutorial is mainly for people who have primarily used GUI text
editors and coding environments and are not used to a primarily
text-based program, running commands in the editor itself, and/or
using large amounts of keyboard shortcuts.

<!-- more -->

For reference, here is the list of shortcuts I'll be introducing in
this tutorial:

* `C-h C-h` : help
* `C-g` : quit
* `C-x b` : switch buffers
* `C-x right` : right-cycle through buffers
* `C-x left` : left-cycle through buffers
* `C-x k` : kill buffer


* `C-x 0` : close the active window
* `C-x 1` : close all windows except the active window
* `C-x 2` : split the active window vertically into two horizontal
windows
* `C-x 3` : split the active window horizontally into two vertical
windows
* `C-x o` : change active window to next window


* `C-x C-f` : open file
* `C-x C-s` : save file
* `C-x C-w` : save file as


* `C-space` : set region mark
* `C-w` : kill region
* `C-k` : kill region between point and end of current line
* `M-w` : kill region without deleting
* `C-y` : yank region from kill ring
* `M-y` : move to previous item in the kill ring
* `M-Y` : move to next item in the kill ring


* `C-_` : undo
* `C-s` : search forwards
* `C-r` : search backwards
* `M-%` : query replace ('space' to replace, 'n' to skip, '!' to
replace all)
* `M-q` : wrap text


* `C-left` : move one word left
* `C-right` : move one word right
* `C-up` : move one paragraph up
* `C-down` : move one paragraph down
* `home` : move to the beginning of the line
* `end` : move to the end of the line
* `page up` : move up a page
* `page down` : move down a page
* `M-` : move to end of buffer


## Opening Emacs

When you first open Emacs, you will see a window that looks something
like this (click to view larger image):

[![][2]][2]

 [2]: /images/emacs/emacs-welcome.png

There is the standard menubar up at the top (With "File", "Edit",
etc.) and a toolbar right below it. You can use those to explore what
Emacs has to offer and to perform operations that you don't know the
keyboard shortcut for, but ultimately, try not to rely on them. The
way to use Emacs efficiently is to learn how to navigate it using
keyboard shortcuts.

Let's go over some basic terminology first with regards to the layout
of Emacs:

[![][3]][3]

 [3]: /images/emacs/emacs-terminology.png

Although in standard terminology the running instance of Emacs would
be called a window, in Emacs terminology it is called a
*frame*. Within Emacs itself, there is a *window* in which we see the
welcome "GNU Emacs" *buffer* (more on windows and buffers in a bit).

The blinking black cursor (over the W in "Welcome") is called the
*point*. Not only is it like a cursor in your standard text editor
(where the text is inserted when you type), but it is the location
where you will sometimes need to run functions as well (e.g., "change
the word that the point is currently in to be uppercase"). We'll come
back to this later.

The grey bar at the bottom of the screen is the *status bar* and
displays various information about the point and the active buffer
(there is one status bar per window). The white space below that is
called the *mini-buffer* and will occasionally display status messages
(e.g., after saving a file), and is also the place where you enter
Emacs commands.

 

## Keyboard Shortcuts

There are two very important keys in Emacs. The first is the "meta"
key. For me, this is the "Alt" key (but it could also be the Windows
key, for example). You will frequently see the meta key abbreviated as
just "M", e.g. `M-x` means the "meta key x key" combination.

The second important key is the "Ctrl" key. Like the meta key, you
will see combinations with the key abbreviated as just "C", e.g. `C-f`
means the "ctrl key f key" combination.

You may also sometimes see key combos like `C-c |` vs. `C-c
C-|`. THESE ARE DIFFERENT KEY COMBOS. The first means "control key c
key, release, then | key". The second means "control key c, release,
then control key | key".

The three most important keyboard shortcuts to know are `C-h C-h`
(help), `C-g` (quit), and `M-x` (run command). The help command
will put you in a position to figure out how to do something if you're
stuck, and the quit command will cancel an operation (for example, if
you are entering a command at the mini-buffer, C-g will quit the
mini-buffer and move the point back to the buffer you were in
previously -- see the next section for more details on buffers and the
mini-buffer). The run command will let you run any command in Emacs;
you probably won't need to use it much right away, but it's good to
know if you run into a scenario where you do need to run a command.

 

## Buffers and Windows

Before we go into actually opening files, I'm going to go into a bit
more detail about buffers and windows. First, you can have many
buffers open at once. Usually they display the contents of a file, but
they can also display output from programs or other information. By
default, Emacs creates a single window and displays the *GNU Emacs*
buffer in it. It also always opens up a \*Messages\* buffer to display
information and error messages about Emacs itself.

[![][4]][4]

 [4]: /images/emacs/messages-buffer.png

There is also always a \*scratch\* buffer, which is what it sounds
like -- a place for notes or other text you don't want to save.

[![][5]][5]

 [5]: /images/emacs/scratch-buffer.png

You can't see the other buffers until you tell Emacs to view them
through a window. To do this, use the `C-x b` key combination. This
will move the point to the mini-buffer and display a message that
looks like "Switch to buffer (default \*scratch\*)":

[![][6]][6]

 [6]: /images/emacs/switch-buffers.png

(Remember that if you want to cancel the current operation, i.e. you
decide you don't want to switch buffers after all, you can use `C-g`
to quit the mini-buffer).

You will frequently want to know all the buffers that are currently
open so you can choose the correct one to switch to. To do this, just
press the tab key from the mini-buffer prompt:

[![][7]][7]

 [7]: /images/emacs/list-buffers.png

This opens a new window beneath the original one and creates a buffer
to display the list of completions (notice that the \*Completions\*
buffer is included in the list of buffers!). Note that you don't have
to use the tab completion if you don't want to, but it is handy.

Type a buffer name into the mini-buffer (for example, \*scratch\*) and
hit enter. This will close the window displaying the \*Completions\*
buffer and open the \*scratch\* buffer in the window that had
previously displayed the *GNU Emacs* buffer.

You can also cycle through buffers sequentially with the key combos
`C-x right` and `C-x left`.

Revisiting the concept of windows: they are essentially just views
into a buffer. You can open up multiple windows in the same frame (I
usually use two vertical windows) and you can have multiple windows
displaying the same buffer:

[![][8]][8]

 [8]: /images/emacs/emacs-windows.png

Again, this is just a view into the buffer, so if I edit the buffer in
the left window, the changes will be reflected in the right window,
because they are both displaying the same buffer:

[![][9]][9]

 [9]: /images/emacs/same-buffer.png

There are a few relevant key commands for manipulating windows:

* `C-x 0` : close the active window
* `C-x 1` : close all windows except the active window
* `C-x 2` : split the active window vertically into two horizontal windows
* `C-x 3` : split the active window horizontally into two vertical windows
* `C-x o` : change active window to next window

Note that closing a window does NOT mean that the buffer it is
displaying is closed.

Why the distinction between windows and buffers? It is useful to have
buffers open in the background even if they are not currently
displayed through a window because reading and displaying a buffer
from memory is much, much faster than reading and displaying a buffer
from disk. So if you are frequently switching between five different
files but you only have two windows open, it is better to open all
files once, load them into buffers (memory), and then switch between
the buffers instead.

 

## Opening, saving, and closing buffers

To open a file and load it into a buffer, use `C-x C-f`, which will
open a prompt in the mini-buffer that says "Find file:
~/path/to/current/directory/". Just as with switching buffers, you can
press the tab key to list the files in the directory you have
specified if you need to.

[![][10]][10]

 [10]: /images/emacs/open-file.png

You can then type in the name (and/or change the path) of the file you
want:

[![][11]][11]

 [11]: /images/emacs/open-hello-world.png

Press enter, and a new buffer will be created with the file you
specified:

[![][12]][12]

 [12]: /images/emacs/hello-world.png

If you make changes to the buffer and you want to save it back to the
file on disk, use `C-x C-s`:

[![][13]][13]

 [13]: /images/emacs/save-file.png

If you want to save the buffer under a new file name (basically, "Save
As" functionality), use `C-x C-w`, which will prompt you to specify
the file name:

[![][14]][14]
[![][15]][15]
[![][16]][16]

 [14]: /images/emacs/write-file.png
 [15]: /images/emacs/write-hello-world-different-name.png
 [16]: /images/emacs/wrote-hello-world-different-name.png

If the file already exists, it will double check to see whether you
are actually intending to overwrite the existing file:

[![][17]][17]

 [17]: /images/emacs/overwrite.png

Once you are done with the buffer and want to actually close/kill it,
use `C-x k`, which will prompt you in the mini-buffer for the name
of the buffer to kill (similar to the prompt given when switching
buffers). If you don't specify a buffer, it will kill the active
buffer by default.

[![][18]][18]

 [18]: /images/emacs/kill-buffer.png

Emacs will display one of the other open buffers in the window that
had previously contained the buffer you just killed.

 

## Manipulating text

You are probably familiar with the terms "cut", "copy", and "paste"
when it comes to manipulating regions of text. Emacs has these
functions as well, however they are typically referred to under
different names. The *kill* operation is analogous to "cut", and
*yank* is analogous to "paste". There is more going on behind the
scenes than just copying, cutting, and pasting; we'll come back to
this in a bit.

First, before I actually tell you how to kill and yank text, you need
to know about the *region*. Just as you might select a region of text
with the mouse to copy, you can do so in Emacs. However, this is
usually done using the cursor and -- you guessed it -- more keyboard
shortcuts.

To select a region, move the point to one end of your desired
region. Then hit `C-space`; you will see a message in the
mini-buffer saying "Mark set":

[![][19]][19]

 [19]: /images/emacs/set-mark.png

Or possibly "Mark deactivated", if you had previously set the mark (if
this is the case, just press C-space again to reactivate the mark):

[![][20]][20]

 [20]: /images/emacs/deactivate-mark.png

Now move the point to the other end of the region. The text which is
in the region will become highlighted.

[![][21]][21]

 [21]: /images/emacs/select-region.png

Now you can do an operation on the selected region (for example,
killing it). To kill a selected region, use `C-w`:

[![][22]][22]

 [22]: /images/emacs/kill-region.png

You can also implicitly define a region from the point to the end of
the current line and kill it with `C-k`.

To perform a yank, use `C-y`:

[![][23]][23]

 [23]: /images/emacs/yank-region.png

You can undo what you just did by pressing `C-_` several times (note
how the mini-buffer displays an "Undo!" message):

[![][24]][24]

 [24]: /images/emacs/undo.png

If you want to kill a region without actually deleting the text, use
`M-w`. That doesn't seem to make a lot of sense -- kill a region
without deleting it? What's the difference?

The difference is that in basic text editors, you can only copy or cut
one piece of text at a time. In Emacs, there is what is called a *kill
ring* which can hold multiple regions of text that you have
killed. When you yank text, you are yanking it off the kill ring and
back into the buffer. So if I kill a region without deleting it, I am
copying the contents of the region into the kill ring but not actually
deleting the region from the buffer.

Here's a demonstration. If I kill (without deleting) two lines
sequentially and then perform a yank, Emacs copies the most recent
item in the kill ring:

[![][25]][25]

 [25]: /images/emacs/yank-most-recent.png

And if I yank again on the next line, it is again the most recent item
in the kill ring:

[![][26]][26]

 [26]: /images/emacs/yank-again.png

And if I then use `M-y` *without moving the point first*, Emacs will
replace the yanked text with the next item from the kill ring:

[![][27]][27]

 [27]: /images/emacs/next-yank.png

To move the opposite direction in the kill ring, use `M-Y`.

 

## Other useful commands

### Search

To search in a buffer (or region, if you have one selected), use
`C-s` (to search forward) or `C-r` (to search backward). Type your
search query into the mini-buffer and keep pressing C-s or C-r to
cycle through the results. When you reach the end of the search
results, Emacs will display a "Failing I-search" message the
mini-buffer. If you use the search key combo again, you will wrap over
to the beginning of the results and Emacs will display the
"Overwrapped I-search" message in the mini-buffer.

[![][28]][28]

 [28]: /images/emacs/search.png

### Find and replace

To find and replace a search query, use `M-%`. Enter in the text you
want to find:

[![][29]][29]

 [29]: /images/emacs/query-replace.png

Then press enter and enter the text you want to replace it with:

[![][30]][30]

 [30]: /images/emacs/query-replace-with.png

Emacs will highlight the text to be replaced (just like if you were
searching for it). Press 'space' to replace it or 'n' to skip it and
go to the next one. Press '!' to replace all queries.

[![][31]][31]

 [31]: /images/emacs/replace.png

### Wrapping text

If you type a lot of words into Emacs, you will notice that it does
not automatically wrap the text. This can be very annoying both for
moving the point around if you are typing full paragraphs, because
Emacs will treat the paragraph as a single line, and for readability.

[![][32]][32]

 [32]: /images/emacs/long-paragraph.png

To get around this, I use `M-q` to wrap the paragraph of text that
the point is currently in:

[![][33]][33]

 [33]: /images/emacs/fill-region.png

### Moving the point

It can be slow to move the point only with the arrow keys; these are
the commands that I use to speed up navigation (note that there are
some other commands you can use for the same operations -- these are
just the ones I find most convenient).

To move the point up or down a whole paragraph (instead of a single
line), use `C-up` or `C-down`. To move the point past a whole word
(instead of a single character), use `C-left` or `C-right`. To
move to the beginning of a line, use the `home` key; to move to the
end of a line, use the `end` key. To move up or down a page, you can
use the `page up` and `page down` keys. To move to the beginning
of the buffer, use `M-`.
