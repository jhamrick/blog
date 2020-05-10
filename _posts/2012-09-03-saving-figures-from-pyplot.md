---
title: Saving figures from pyplot
layout: post
comments: true
permalink: /2012/09/03/saving-figures-from-pyplot/
categories:
  - Programming
tags:
  - berkeley
  - matplotlib
  - numpy
  - pyplot
  - python
  - scientific programming
  - code
---

Well, it has been a while since I've posted. Over the summer I moved
to beautiful Berkeley, California to start my PhD in Psychology at
Cal. Moving has kept me pretty busy, but as things are starting to
settle down a bit, I've decided to start making an effort to blog
regularly (even if it's just a short and simple post like this one).

Most posts are probably going to be Python-related (particularly from
a scientific computing point-of-view). If you have any requests or
suggestions, please let me know! I'm always open to ideas.

Often when I'm doing data analysis, I will need to save many figures
to disk at once. For example, if I'm looking at the distribution of
human responses to every stimulus I have (say, around 60 different
stimuli), I'm going to need a different plot for each. Matplotlib
actually has a pretty straightforward function for saving figures, but
there's a little bit of scaffolding that I like to have around it by
default.

<!-- more -->

{% gist 5320734 savefig.py %}

This probably seems like a lot of code, but it's mostly
commments/docstring. The important part is Line 47, where we actually
save the image -- but I like having the option to automatically close
the figure and print out information about what's being saved. Also,
if the directory doesn't exist that I'm trying to save to, I'd much
rather it just be created than throw an error.

Here's an example of this function in use:

```python
import numpy as np
import pyplot as plt

# Make a quick sin plot
x = np.linspace(, 10, 100)
y = np.sin(x)
plt.plot(x, y)
plt.xlabel("Time")
plt.ylabel("Amplitude")

# Save it in png and svg formats
save("signal", ext="png", close=False, verbose=True)
save("signal", ext="svg", close=True, verbose=True)
```

This will create a simple sin wave and save it to "signal.png" and
"signal.svg" before closing it altogether.
