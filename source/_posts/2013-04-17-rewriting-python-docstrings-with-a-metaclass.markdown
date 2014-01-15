---
layout: post
title: "Rewriting Python docstrings with a metaclass"
date: 2013-04-17 23:28
comments: true
permalink: /2013/04/17/rewriting-python-docstrings-with-a-metaclass
categories: 
  - Programming
tags:
  - python
  - inheritance
  - metaclass
  - docstring
  - hacking
  - code
---

**Update**: I gave a talk based on this post at the November 2013 San
 Francisco Python meetup! Here are the
 [slides](/publications/slides/sfpython2013/metaclasses-slides.slides.html?transition=none)
 and a [video](https://www.youtube.com/watch?v=ZrUIRSVv1gw) of the
 talk.

Today, I found myself in a situation where I had a few different
classes inheriting from each other, e.g.:

```python Inheritance structure
class A(object):
    def foo(self):
	    pass

class B(A):
    pass

class C(B):
    pass
```

Specifically, each of these classes was a test class that I was
running using `nose` -- `B` and `C` had different `setup` methods than
`A`, but otherwise ran the same test. However, `nosetests -v` doesn't
print out the name of the method's class, only the docstring, which is
of course the same for all three classes. This made it very difficult
to tell which method was actually failing.

To resolve this, I wrote a
[*metaclass*](http://stackoverflow.com/questions/100003/what-is-a-metaclass-in-python)
to intercept each class at creation time and rewrite its docstrings to
be prefixed with the name of the class. This was probabily overkill,
but I'd been itching to play around with metaclasses for a while and
decided this was a semi-valid excuse.

<!-- more -->

Here's the code:

{% gist 5410601 rewrite_docstrings.py %}

And here's an example of it working its magic:

```python Magic docstring rewriting!
class A(object):
    __metaclass__ = RewriteDocstringMeta

    def foo(self):
        """Do some stuff."""
        pass

class B(A):
    __metaclass__ = RewriteDocstringMeta

class C(B):
    __metaclass__ = RewriteDocstringMeta
        

print A.foo.__doc__ # prints 'A: Do some stuff.'
print B.foo.__doc__ # prints 'B: Do some stuff.'
print C.foo.__doc__ # prints 'C: Do some stuff.'
```

## How does this work?

The `__new__` method is called before the class itself is
created. `name` is the name of the future class (e.g. `A`), `parents`
are the parent classes, and `attrs` is a dictionary of attributes for
the class.

First (lines 32--43), we rewrite the docstrings for the functions given
in `attrs`. This is straightforward enough.  *However*, this isn't
actually sufficient to rewrite the docstrings for inherited methods,
which is what my goal ultimately was. This is because inherited
methods still belong to the class they are inherited from -- the
difference is that when called, the `self` contains the instance of
the child class rather than the parent class.

So, to rewrite the docstrings for all methods (even inherited ones),
we need to actually make a copy of the parent methods and update the
docstring of the copy (lines 45--72).

This took me a while to figure out, because I was under the mistaken
impression that when the `type` metaclass transformed a function into
an unbound method of a class, it was actually creating a copy of that
function which could then be modified. This is not the case. The
unbound method is more like a read-only wrapper around the
function.

In fact, due to the way Python's inheritance works, if `A`
has a method `foo` that is not overridden by `B` or `C`, neither `B`
nor `C` will actually have an unbound `foo` method. When a lookup is
performed on the attribute `foo`, Python checks the hierarchy of
scopes that `B` or `C` reside in until it finds `foo` (which is in the
`A` scope).

Even if you override this and explicitly create an unbound method for
`B` or `C` (but using the same original function), it will not matter
-- if you change the docstring for the function, it changes it for all
classes that inherit it, and you cannot change the unbound method
because it is read-only. Thus, it is necessary to actually *copy* the
function (how very un-Pythonic...) and then change the docstring of
the copy.

## Reflections

I don't think I could have done this by implementing the `__new__`
methods of the classes themselves (rather than creating a metaclass)
either, because bound instance methods -- just like unbound class
methods -- have read-only docstrings. I almost certainly could have
tweaked `nose` to find a better way to print out my test cases, but I
thought this was an interesting problem that deserved consideration
independent of the context it is being used in.

Have any of you played with docstrings and metaclasses much? Is there
a more elegant way to do this, that I missed? Or is this, in fact, one
of the rare times when it legitimately is appropriate to use a
metaclass?
