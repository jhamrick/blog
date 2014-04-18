---
title: 'Installing 64-bit Panda3D for Python 2.7 on OS X'
layout: post
comments: true
permalink: /2013/09/26/instaling-64-bit-panda3d-for-python-27-on-osx/
categories:
  - Programming
tags:
  - panda3d
  - python
  - OS X
---

I use the [Panda3D video game engine](http://www.panda3d.org/) to
develop experiments for my research. I needed to install a development
version that included some bugfixes, but unfortunately, installing
Panda3D on OSX is not the easiest task to accomplish. The development
builds they provide are unfortunately only 32-bit, but I needed to be
able to run my Panda3D code alongside libraries like NumPy, which I
had installed as 64-bit (which is the default on OSX). For a while, I
tried to get NumPy/SciPy/etc. installed for 32-bit, but failed, and
ultimately was able to get Panda3D compiled for 64-bit Python
2.7. Here are the steps that I took in order to compile it; hopefully
they will be useful to others (and at the very least, a reference for
myself going forward!)

<!-- more -->

## Getting the Source

Check out the Panda3D
[source repository](http://sourceforge.net/projects/panda3d/) using
CVS. I'll be referring to the root directory of this repository as
`$P3DDIR`.

## Installing Dependencies

This is actually the bulk of the work required to get Panda3D to
build.

1. First, install the [NVIDIA Cg toolkit](https://developer.nvidia.com/cg-toolkit).
   
2. Xcode no longer comes with PackageMaker, so you need to download
   the
   ["Auxiliary Tools for Xcode"](https://developer.apple.com/downloads/index.action#)
   and install them to
   `/Applications/Xcode.app/Contents/Applications`.

3. Many of the "thirdparty" dependencies can be installed via
   [Homebrew](http://brew.sh/). These include:
	* `python`
	* `apple-gcc42 --with-gfortran-symlink` (and then manually create
	  symlinks from `/usr/local/bin/{g++-4.2, gcc-4.2, gfortran-4.2}`
	  to `/usr/local/bin/{g++, gcc, gfortran}` respectively)
	* `fftw --with-fortran`
	* `freetype`
	* `gtk+`
	* `wxmac`
	* `eigen`

4. There are a few libraries for which there are existing thirdparty
   builds (see below), but which can also be installed via Homebrew. I
   went ahead and installed them anyway, but this might be
   unnecessary:
	* `jpeg`
	* `libpng`
	* `ode --enable-double-precision`
	* `libtiff`
	* `wxmac`

5. The Panda3D developers have provided some thirdparty builds of some
   of these tools. A few I got from
   [a tarfile that rdb posted in the forums](http://rdb.name/thirdparty_mac_x86_64.tar.bz2).
   You should install these to `$P3DDIR/thirdparty/darwin-libs-a`
   (except `Pmw`, which goes just in `$P3DDIR/thirdparty/`). The tools
   in this tar include:
	* `Pmw`
	* `artoolkit`
	* `bullet`
	* `fcollada`
	* `fmodex`
	* `jpeg`
	* `npapi`
	* `ode`
	* `squish`

6. A few other thirdparty builds are included in the 1.8.1 release and
   are already compiled for 64-bit. You can get them from
   [this tarfile](http://www.panda3d.org/download/panda3d-1.8.1/panda3d-1.8.1-tools-mac.tar.gz)
   and you should install to `$P3DDIR/thirdparty/darwin-libs-a`:
	* `png`
	* `tiff`

7. Finally, there are a few thirdparty libraries that I couldn't get
   to work -- that is, Panda3D wouldn't compile against them. (If
   anybody manages to get it to work with these tools, please let me
   know!) They are:
	* `ffmpeg`
	* `vrpn`
	* `rocket`
	* `opencv`

## Compiling

You should now be ready to compile! Don't worry about not having
GLES/GLES2/EGL -- they are for using Panda3D on embedded systems,
which is functionality I don't need. I haven't attempted to install
those libraries, so I don't know if this will work with them or not.

From the root of the repository (`$P3DDIR`), run the following
command:

`python2.7 makepanda/makepanda.py --everything --installer --no-ffmpeg --no-vrpn --no-rocket --no-opencv --no-gles --no-gles2 --no-egl`

Mount the resulting `.dmg` and try to install it normally. However, if
it gives an error (as it did for me), try installing the package from
the command line:

`sudo installer -verbose -dumplog -pkg /Volumes/Panda3D/Panda3D.mpkg -target /`

That still gave me an error, but it at least seemed to copy everything
to the right places.  I also still have some issues with shaders, but
I think that is a separate bug. Other than that, I now have a recent
64-bit build that works!
