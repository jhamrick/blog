---
title: Macs and Emacs
layout: post
permalink: /2013/03/31/macs-and-emacs/
comments: true
dsq_thread_id:
  - 
categories:
  - Software
tags:
  - computer science
  - emacs
  - programming
  - software
  - tech
  - technology
---

In my [last post][1], I talked about how to set up Emacs as a Python
IDE. Since then, two things have changed:

 [1]: http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/

* I got a Macbook Air. Switching from Linux to Mac required a few
  (mostly minor) changes to my Emacs configuration.
* I have begun using the fabulous [IPython Notebook][2], which has
  really helped me organize my code and streamline my workflow.

 [2]: http://ipython.org/ipython-doc/dev/interactive/htmlnotebook.html

In this post I'll tell you how switching to a Mac has affected my
configuration. In a future post (coming soon!), I'll talk about the
IPython Notebook, how I set it up for my configuration, and how it's
really improved my Python development environment. You can find the
emacs configuration associated with this post
[here](https://github.com/jhamrick/emacs/tree/macs-and-emacs-post).

<!-- more -->

Disclaimer: I've made a lot of these changes piecemeal over the course
of a few months, so I may not be 100% correct about all of the
customizations here (and may have accidentally left out some
steps). If you run into any issues, let me know and I'll try to help
you debug!

## Mac Package Management

First off, I should mention which package manager I've been using to
set up my Mac. After hearing too many stories of frustration about
MacPorts, I was given a recommendation for [Homebrew][3] instead. So
far, I've found it to be quite straightforward and pleasant. It
doesn't have every application or library I want to install, but it
has given me enough of the basics that I'm satisfied. I'll be using
homebrew to install a lot of things in this guide, so the setup might
be a little different if you use MacPorts or something else. In
theory, it shouldn't matter since everything is compiled from source
regardless. With Homebrew, I installed a few utilities that have made
my Mac act more like Linux. These are optional with respect to this
guide, but I find them essential to really get anything done so I'm
listing them here anyway.

 [3]: http://mxcl.github.com/homebrew/

### Coreutils

OS X comes with many of the standard coreutils (e.g. `ls`), but they
are outdated versions. For example, the default build of `ls` is from
2002! There are much more recent versions than that, so I installed an
updated version (coreutils 8.20):

`brew install coreutils`

Homebrew installs these programs prefixed with 'g', e.g. `gls`. I
didn't want to use these utilities to be used system-wide by default
in case something needed backwards compatibility, so I am instead
using bash aliases. You can add something like the following to your
~/.bash_profile:

```bash
if [ $(uname -s) == "Darwin" ]; then 
    alias ls='gls'
fi
```

## Installing Emacs

Ok, on to Emacs! First, of course, we need to actually install
it. There are a few options available:

* Special Emacs builds like [Aquamacs][4], which makes some
  modifications to make Emacs more OS X-like.
* X11 Emacs running under [XQuartz][5] (you can install this version
  of Emacs using `brew install emacs --with-x`), which is
  traditional Emacs but runs under the X windowing system. This is
  the windowing system used by many flavors of linux, so it is
  literally as close as you can get to a linux build of Emacs.
* Cocoa Emacs, which is traditional Emacs built using Apple's Cocoa
  API and thus appears like a native OS X application.

 [4]: http://aquamacs.org/
 [5]: http://xquartz.macosforge.org/landing/

I decided that I didn't want that much customization to my Emacs
environment -- I wanted it to be as similar to the Emacs I use under
Linux as possible (especially because I still access Linux machines
fairly frequently). I first tried out the traditional X11 Emacs but it
was fairly annoying to have to switch to XQuartz and *then* Emacs from
my other applications. So, I ultimately settled on a Cocoa build,
which is basically traditional Emacs but is also integrated into the
OS X environment:

`brew install emacs --cocoa`

## Configuring Emacs

First, as I mentioned, I still use some Linux machines and wanted to
be able to share my Emacs configuration between them and my Mac. So, I
defined some helper functions to differentiate between OS X and Linux,
in cases where changing the configuration to make it work in OS X
would break it in Linux:

```scheme
(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))
```

### Remapping the Meta Key

If you're used to using Emacs on a PC, then you're probably used to
using the key(s) closest to the spacebar as your meta key. On a PC,
these are the *Alt* keys, but on a Mac, the Alt a.k.a. *Option* (⌥)
keys are actually the *second* closest to the spacebar: instead, the
closest keys are the *Command* (⌘) keys. By default, the meta key in
Emacs on a Mac is bound to Option. I don't know why this is the case,
because it's the most awkward key to hit. I rebound my meta key to the
Command key:

```scheme
; set command key to be meta instead of option
(if (system-is-mac)
   (setq ns-command-modifier 'meta))
```

I should also note that in System Preferences, I remapped my Caps Lock
to be another Control key.

### True and False

There were a lot of places in my configuration files that used `nil`
and `t` for *false* and *true*, respectively. This apparently does not
work in Cocoa Emacs. Replace `nil` with `-1` and `t` with `1` and this
should fix configuration options that seem to have stopped working.

### Theme

Many of the theme customizations I had in `custom-set-faces` also
stopped working. I had to rewrite some of the settings as explicit
commands, for example:

```scheme
(require 'faces)
(set-face-attribute 'font-lock-comment-face nil :foreground "lime green")
```

I also removed the dependency to [Color Theme][6] (which I was
previously using as a base for color customizations), as it is no
longer supported in Emacs 24.

 [6]: http://emacswiki.org/emacs/ColorTheme

### Paths

Cocoa Emacs does not use `PATH` or `PYTHONPATH` as it is defined in
`.bashrc` or `.bash_profile`, because those files are only evaluated
in an *interactive* shell. Unless Emacs is run from the shell, it will
not be running in an interactive session. Therefore, it is necessary
to redefine the `PATH` and `PYTHONPATH` from Emacs' configuration,
e.g.:

```scheme
; set PATH, because we don't load .bashrc
(setenv
 "PATH" (concat
	 "$HOME/bin:"
	 "/bin:"
	 "/usr/bin:"
	 "/sbin:"
	 "/usr/sbin:"
	 "/usr/local/bin:"
	 "/usr/local/sbin"))
 
; Set PYTHONPATH, because we don't load .bashrc
(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages:")
```

### Frame Size

I began manually setting the default frame size to the full height and
half the width of my screen, so I didn't have to resize it every
single time. This is less of a Mac-specific thing, but I thought I'd
mention it:

```scheme
; default window width and height
(defun custom-set-frame-size ()
  (add-to-list 'default-frame-alist '(height . 65))
  (add-to-list 'default-frame-alist '(width . 99)))
(custom-set-frame-size)
(add-hook 'before-make-frame-hook 'custom-set-frame-size)
```

### LaTeX

AUCTeX wasn't being activated by default on OS X (whereas it used to
be under Linux). This required adding `(require 'tex-site)` to enable
AUCTeX. To further enable correct LaTeX syntax highlighting, I needed
to add `(require 'font-latex)`. I also changed the PDF viewer
invocation to use [Skim][7] instead of evince:

```scheme
(if (system-is-mac)
 (progn
  (require 'tex-site)
  (require 'font-latex)
  (setq TeX-view-program-list
   (quote
    (("Skim"
      (concat "/Applications/Skim.app/"
	      "Contents/SharedSupport/displayline"
	      " %n %o %b")))))
  (setq TeX-view-program-selection
   (quote (((output-dvi style-pstricks) "dvips and gv")
	    (output-dvi "xdvi")
	    (output-pdf "Skim")
	    (output-html "xdg-open")))))

  (if (system-is-linux)
   (setq TeX-view-program-selection
    (quote (((output-dvi style-pstricks) "dvips and gv")
	     (output-dvi "xdvi")
	     (output-pdf "evince"
	     (output-html "xdg-open"))))))
```

 [7]: http://skim-app.sourceforge.net/
