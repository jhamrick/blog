---
title: The Demise of For Loops
layout: post
comments: true
permalink: /2012/04/29/the-demise-of-for-loops/
categories:
  - Programming
tags:
  - array computation
  - for loops
  - list comprehensions
  - numpy
  - python
  - scientific programming
  - code
---

I almost exclusively use Python in my research. I write 3D
interactive experiments using [Panda3D][1] and I collect, analyze, and
visualize my data using [NumPy][2], [SciPy][3], and
[matplotlib][4]. While I have been using Python for almost 5 years
now, I only began using Python for *scientific* programming when I
joined the [Computational Cognitive Science Group][5] at MIT. The
sort of programming I do these days is very different from the
software engineering I used to focus on.

 [1]: http://www.panda3d.org/ "Panda3D"
 [2]: http://numpy.scipy.org/ "NumPy"
 [3]: http://scipy.org/ "SciPy"
 [4]: http://matplotlib.sourceforge.net/ "matplotlib"
 [5]: http://cocosci.mit.edu/

In particular, I almost never use for loops when I am doing any form
of serious number crunching. For loops do have applications, but I
think they tend to be overused, especially in Python. There are two
reasons:

1.  Almost anything numerical can be done with NumPy.
2.  Almost everything else can be done with list comprehensions.

So what? Does it really matter whether you use NumPy vs. a list
comprehension vs. a normal for loop? It *absolutely* does and I will
go through a few examples in this post.

<!-- more -->

Let me start with a story. Once upon a time, when I was still new to
scientific computing, I needed to compute an array of correlations
between my model's predictions and human data for many different
settings of the model's parameters. Naively, my code involved a lot of
for loops. Something like this:

```python
corr = []
for i in xrange(S):
    corr.append([])
    for j in xrange(G):
        corr[-1].append([])
        for k in xrange(N):
            corr[-1].append([])
            for l in xrange(M):
                corr[-1].append(correlate(model[i, j, k, l], human))
```

... ouch. I shudder to think that I used to code like that! What makes
this such poor code is that I have *four* nested for loops (and
possibly more, if I had more parameters). Wouldn't it be so much nicer
to do something like:

```python
corr = [[[[correlate(model[i, j, k, l], human) 
           for l in xrange(M)] 
		   for k in xrange(N)] 
		   for j in xrange(G)] 
		   for i in xrange(S)]
```

Or, even better, if you could just operate over the arrays without any
loops at all?

Well, you can!

In this post, I'm going to go through a few interesting examples of
how using NumPy, list comprehensions, and for loops can be used for
the same applications, and furthermore, how well these different
approaches actually perform. You can find all of the code in this
blog post [here][6].

 [6]: https://gist.github.com/jhamrick/5320942

### Timing

Let me first start by introducing a simple timing function that I'll
be using to make these comparisons (you'll notice I do use a for loop
here!):

```python
from timeit import Timer
import numpy as np
import math
 
def timer(*funcs):
    # find the maximum function name length
    if len(funcs) > 1:
        maxlen = max(*[len(func) for func in funcs])
    elif len(funcs) == 1:
        maxlen = len(funcs[0])
    else:
        return
 
    # run each function 10000 times and print statistics
    times = []
    print "--"
    for func in funcs:
        timerfunc = Timer("%s()" % func, "from __main__ import %s" % func)
        runtime = timerfunc.repeat(repeat=10000, number=1)
        mtime = np.mean(runtime)
        stime = np.std(runtime)
        dfunc = func + (" " * (maxlen - len(func) + 1))
        print "%s: %.6f +/- %.6f seconds" % (dfunc, mtime, stime)
```

This function takes the names of an arbitrary number of local
functions, runs each function 10000 times, and prints out the mean and
standard deviation of these runs.

### Ranges and Lists

Ok.  One of the simplest things you need to be able to do in python is
to create a list of numbers, for example, from 0 to 1000 (exclusive):

```python
def numpy_arange():
    l = np.arange(1000)
def py_range():
    l = range(1000)
def py_xrange():
    l = xrange(1000)
```

And when we time this:

```python
>>> timer("numpy_arange", "py_range", "py_xrange")
--
numpy_arange : 0.000004  /- 0.000002 seconds
py_range     : 0.000011  /- 0.000003 seconds
py_xrange    : 0.000002  /- 0.000001 seconds
```

The fastest method is `xrange`. This isn't terribly surprising because
`xrange` doesn't actually create a list of numbers, it creates a
generator which will produce a list of numbers. If we actually force
it to be a list:

```python
def py_xrange_list():
    l = list(xrange(1000))
```

And time it:

```python
>>> timer("py_xrange_list")
--
py_xrange_list : 0.000012  /- 0.000001 seconds
```

We see that `xrange` isn't actually faster than `numpy.arange`. So,
this is a case where you should keep your application in mind (e.g.,
if you need a list of so many numbers that it won't fit in memory, you
would want to use `xrange`).

Another thing to keep in mind is whether you need the list to work
with other NumPy functions or not.  NumPy will convert lists and
tuples to `ndarray` types, and this can actually take a significant
amount of time. Let's look at some conversions to and from NumPy
arrays:

```python
def arange_to_list():
    l = list(np.arange(1000))
def xrange_to_ndarray():
    l = np.array(xrange(1000))
def range_to_ndarray():
    l = np.array(range(1000))
```

And timing them, we see it it is an order of magnitude slower to
create these lists and convert them than just creating them as the
appropriate type!

```python
>>> timer("arange_to_list", "xrange_to_ndarray", "range_to_ndarray")
--
arange_to_list    : 0.000140  /- 0.000009 seconds
xrange_to_ndarray : 0.000110  /- 0.000005 seconds
range_to_ndarray  : 0.000117  /- 0.000005 seconds
```

### Array Operations

Let's move on to actually using our arrays to do things.  

##### Sums

One really common operation is summing a list of numbers; NumPy here
has the advantage both in terms of readability...

```python
def numpy_sum():
    total = np.sum(np.arange(1000))
def loop_sum():
    total = 0
    for i in xrange(1000):
        total += i
```

... and speed (though you'll notice that the mean runtime of
`loop_sum` is within one standard deviation of `numpy_sum`'s mean, so
this isn't very significant):

```python
>>> timer("numpy_sum", "loop_sum")
--
numpy_sum : 0.000010  /- 0.000017 seconds
loop_sum  : 0.000038  /- 0.000020 seconds
```

##### Mean and Standard Deviation

We often want to do more complex array operations, such as finding the
mean and standard deviation of a list of numbers. NumPy makes this
pretty trivial compared to writing these functions by hand:

```python
def numpy_mean():
    mean = np.mean(np.arange(1000))
def loop_mean():
    def _mean(arr):
        # sum all the numbers
        total = 0
        for num in arr:
            total += num
        # calculate the mean
        mean = total / float(len(arr))
        return mean
    mean = _mean(range(1000))
 
def numpy_std():
    std = np.std(np.arange(1000))
def loop_std():
    def _std(arr):
        # calculate the mean
        total = 0
        for num in arr:
            total += num
        mean = total / float(len(arr))
        # calculate the variance
        total = 0
        for num in arr:
            total += (num - mean) ** 2
        var = total / float(len(arr))
        # standard deviation is square root of the variance
        std = math.sqrt(var)
        return std
    std = _std(range(1000))
```

The difference in speed is pretty significant, too. NumPy is primarily
written in C, so all of its functions are incredibly optimized;
unsurprisingly, they're faster than unoptimized pure Python:

```python
>>> timer("numpy_mean", "loop_mean", "numpy_std", "loop_std")
--
numpy_mean : 0.000014  /- 0.000006 seconds
loop_mean  : 0.000047  /- 0.000005 seconds
numpy_std  : 0.000035  /- 0.000002 seconds
loop_std   : 0.000244  /- 0.000007 seconds
```

##### Squares

I mentioned at the beginning of this post that many loops could be
replaced with list comprehensions. In particular, if you have a loop
where you are doing some computation and then appending to a list, you
should probably be using a loop comprehension instead. For example,
let's say we want a list of the first 10000 squares:

```python
def numpy_squares():
    squares = np.arange(1, 10001) ** 2
def listcomp_squares():
    squares = [i**2 for i in xrange(1, 10001)]
def loop_squares():
    squares = []
    for i in xrange(1, 10001):
        squares.append(i ** 2)
```

With the exception of the append, `listcomp_squares` is basically the
same as `loop_squares`. However, this small change can make a *huge*
difference:

```python
>>> timer("numpy_squares", "listcomp_squares", "loop_squares")
--
numpy_squares    : 0.000026  /- 0.000020 seconds
listcomp_squares : 0.000824  /- 0.000071 seconds
loop_squares     : 0.001373  /- 0.000088 seconds
```

I'll note that NumPy is, again, the faster choice for this
operation. However, NumPy does not have an optimized function for
everything. When this is the case, you should fall back on list
comprehensions and not for loops!

### Indexing

Let's end with a complex application of NumPy and list comprehensions
over for loops. One particular application that I frequently need is
to run models on all possible settings of several parameters -- for
example, if I have `x=(0, 1, 2)` and `y=(0, 1)`, I would want to run
my model on all `(x, y)` pairs in
`[(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1)]`. With many
parameters, computing these combinations can become messy.

NumPy gives us some magic that makes it really easy to compute these
settings. Importantly, we're going to use `numpy.ix_`, which (from the
documentation) "takes N 1-D sequences and returns N outputs with N
dimensions each, such that the shape is 1 in all but one dimension and
the dimension with the non-unit shape value cycles through all N
dimensions". So we'll use `numpy.ix_` to create arrays for each
dimension/parameter, and then concatenate these arrays together to get
the final array of shape `(n, d)` (where `n` is the number of
combinations, and `d` is the number of dimensions). The biggest
downside is that this function is somewhat difficult to understand
without a solid knowledge of NumPy.

```python
def numpy_make_grid(*args):
    # an array of ones in the overall shape, for broadcasting
    ones = np.ones([len(arg) for arg in args])
    # mesh grids of the index arrays
    midx = [(ix * ones)[None] for ix in np.ix_(*args)]
    # make into one Nx3 array
    idx = np.concatenate(midx).reshape((len(args), -1)).transpose()
    return idx
```

We can do the same without using NumPy, but it's a much larger
function (though perhaps easier to understand if you don't know what
`numpy.ix_` does). The approach I'll take with this function is to
first determine the number of combinations, create a big list of the
appropriate size, and then fill it in by looping over each of the
input lists. One benefit to this is that we could use `loop_make_grid`
to make combinations of strings, whereas `numpy_make_gride` requires
numerical combinations.

```python
def loop_make_grid(*args):
    # find the sizes of each dimension and the total size of the
    # final array
    shape = [len(arg) for arg in args]
    size = 1
    for sh in shape:
        size *= sh
    # make a list of lists to hold the indices
    l = [1 for i in xrange(len(args))]
    idx = [l[:] for i in xrange(size)]
    # fill in the indices
    rep = 1
    for aidx, arg in enumerate(args):
        # repeat each value in the dimension based on which
        # dimensions we've already included
        vals = []
        for val in arg:
            vals.extend([val] * rep)
        # repeat each dimension based on which dimensions we
        # haven't already included and actually fill in the
        # indices
        rest = size / (rep * len(arg))
        for vidx, val in enumerate(vals * rest):
            idx[vidx][aidx] = val
        rep *= len(arg)
    return idx
```

Let's now compare the runtime of these two approaches. We'll make a
1000 by 3 array for three lists of ten numbers:

```python
def numpy_indices():
    numpy_make_grid(np.arange(10), np.arange(10), np.arange(10))
def loop_indices():
    loop_make_grid(range(10), range(10), range(10))
```

And actually timing it, we see that `numpy_make_grid` is a lot faster
than `loop_make_grid`:

```python
>>> timer("numpy_indices", "loop_indices")
--
numpy_indices : 0.000112  /- 0.000083 seconds
loop_indices  : 0.000523  /- 0.000013 seconds
```

### Conclusion

When working with numbers, NumPy is a significantly faster option in
many cases. So, if you are doing any form of scientific computing, I
highly recommend learning how to use it well! You can find pretty good
documentation on using NumPy arrays at
[http://docs.scipy.org/doc/numpy/user/][7].

 [7]: http://docs.scipy.org/doc/numpy/user/ "NumPy Documentation"

That said, NumPy is not *always* appropriate. If you're doing
something more procedural -- for example, computing a kernel function
on a matrix -- you may find that NumPy doesn't have the nice optimized
functions you want. In these cases, try to use list comprehensions as
much as possible. If you're smart about using NumPy arrays and list
comprehensions, you may find you can get a considerable speed up in
your code!
