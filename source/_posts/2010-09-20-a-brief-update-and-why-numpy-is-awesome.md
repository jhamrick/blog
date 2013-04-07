---
title: A Brief Update, and Why Numpy is Awesome
layout: post
permalink: /2010/09/20/a-brief-update-and-why-numpy-is-awesome/
comments: true
categories:
  - Programming
tags:
  - classes
  - numpy
  - pika
  - python
  - SIPB
  - software
  - UROP
---

Wow, things are crazy. Classes and the rest of my responsibilities
have hit like a tidal wave, and I finally am able to start swimming
towards the surface to get some air. I'm only taking 3.5 classes this
term, but I'm also working on my awesome UROP 15-20 hours a week, on
top of being SIPB Chair, writing a game for the MIT Assassin's Guild,
being pika's senior house manager, and being pika's computer chair. I
always love being this busy, but sometimes I wonder if I like it a
little *too* much. It's hard to find a term when I'm *not* in over my
head. But, regardless, things are going well and I'm excited to almost
be done with my undergraduate career!

<!-- more -->

So, what else? I don't really have the time to compose a full-fledged
post (I'll get to the rest of those security posts soon, I
promise...), so I'm going to talk about why Python's NumPy is awesome.

For my UROP this summer, I created an experiment which involves
looking at towers of blocks; I coded the whole interface in Python
using Panda3D. One of the first tasks was to create a way to randomly
generate towers, with a few constraints: blocks may only be placed
within a *n* by *n* square in the xy plane, and blocks must be
"locally stable" -- that is, if you just look at the block you are
placing and the block(s) directly beneath it, the block you're placing
needs to be able to sit on the block(s) below it and not fall off. Of
course, this guarantees nothing about the overall stability of the
tower, but it does guarantee that individual blocks themselves are
stable. In order to represent which blocks are where, a "depth map" is
maintained, where the value for each grid square is the *z* value of
the highest block at that point.

Unfortunately, having the "locally stable" constraint makes it more
difficult to place blocks. You can't just randomly pick a pair of (x,
y) coordinates to place it, because they need to be stable. You want
to be able to examine the list of all locally-stable positions, and
then choose a coordinate pair from that. So how do you determine if
it's locally stable? The naive approach (which is the one that I
initially took) is to iterate through every single point and check to
see if it's locally stable. To see if it's stable, you need to check
every point within the area that the block occupies. If we assume the
origin to be at the center of the block, then we need the block to be
supported in *x*, -*x*, *y*, and -*y*, which essentially means that
there must be at least two points of the maximum height for that
sub-"depth map" that are diagonally across from each other. So, we are
looping through every coordinate in the world and then through every
coordinate that the block covers. Long story short, it's slooowwww.

So, where does NumPy come into this? If we use matrix operations
instead of for loops, then the whole stability calculation becomes
lightning fast. At the start of the program, the depth map is
initialized to all zeros, and then a list is created of every possible
"slice" -- that is, the area where a block could potentially rest.
Then, when calculating which spots are valid, we look at each slice,
find the maximum, and then compare the slice to the maximum
(e.g. numpy.array(slice > numpy.max(slice), dtype=numpy.bool)). Then,
you do an element-wise *and* with a bitmask, which represents whether
a given coordinate provides *x*, -*x*, *y*, and/or -*y*. Finally, you
sum over every coordinate in the slice matrix, and if the result has a
1 for every bit, then it is a valid spot to place a block.

It sounds like a lot of these operations require iteration and
wouldn't be much faster than using for loops anyway. In some cases,
I've glossed over the actual techniques I used to do the calculation
(e.g. finding the maximum of each slice can be done with matrix
operations, and does not require a loop). In other cases, I am sure
that NumPy does use loops, but in a very effective and efficient
manner. If I had the time to source dive, I'd take a look and see what
the running times for their algorithms are.

Anyway, enough of my sleep-deprived ramblings. I am quite happy with
how NumPy enables fast and easy matrix manipulations. Perhaps I am
just fascinated by the efficiency of matrix operations themselves.
But, in any case, NumPy is another point in Python's favour -- while
Python is not my favourite language, when it comes to cases like this,
it is certainly the most convenient.
