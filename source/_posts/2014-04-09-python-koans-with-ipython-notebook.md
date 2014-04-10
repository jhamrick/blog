---
title: 'Python Koans with the IPython Notebook'
layout: post
comments: true
permalink: /2014/04/09/python-koans-with-ipython-notebook/
categories:
  - Programming
tags:
  - ipython
  - python
  - ipython notebook
---

Every week, a group of Python enthusiasts around Berkeley get together
to talk about various Python things. This past week, we talked about
Greg Malcom's wonderful
[Python koans](https://github.com/gregmalcolm/python_koans), which are
a way of learning Python through test-driven-development (TDD). The
basic idea is that by fixing failing tests, you can learn Python! I
think this is a brilliant idea.

tl;dr As a proof of concept, I converted the Python koan
`about_strings` (which you can find
[here](https://github.com/gregmalcolm/python_koans/blob/master/python2/koans/about_strings.py),
for Python 2, or
[here](https://github.com/gregmalcolm/python_koans/blob/master/python3/koans/about_strings.py),
for Python 3) into an IPython notebook. Here's the
[notebook on nbviewer](http://nbviewer.ipython.org/urls/gist.githubusercontent.com/jhamrick/10344303/raw/31808f83b012a99879ba5a57e0406f23056a5ff1/About+koans).

<!-- more -->

However, I felt like some of the tests were a little artificial:

```python Use backslash for escaping quotes in strings
def test_use_backslash_for_escaping_quotes_in_strings(self):
    a = "He said, \"Don't\""
    b = 'He said, "Don\'t"'
    self.assertEqual(__, (a == b))
```

To fix this test, you need to replace `__` with `True`. If you're
anything like me, then you'll just start going through the motions and
just put `True` (because that's the answer to a lot of the tests)
without actually paying too much attention to the tests
themselves. Don't get me wrong -- I absolutely think that fixing
failing test cases can be an excellent learning method. But, at least
for tests about some of the basic parts of Python (like strings), it
seems like just writing a test that requires you to put `True` is not
the best solution.

I had a thought, which was that if some of these test cases had
*syntax* errors, then that would be a lot more instructional. For
example, the following test requires you to fix two syntax errors in
order for it to pass:

```python Use backslash for escaping quotes in strings, take 2
def test_use_backslash_for_escaping_quotes_in_strings(self):
    a = "He said, "Don't""
    b = 'He said, "Don't"'
    self.assertEqual(a, b)
```

The problem with this idea, however, is that it won't work with the
current format of Python koans, which has a whole bunch of tests all
in the same file. The reason is that Python first checks the file for
syntax problems, and if it finds *any*, it will throw an error before
any code is actually executed. Thus, if there were a whole bunch of
tests with syntax errors, you would have to fix *all* of them before
you could even run the tests.

After pondering this for a little while longer, I came up with another
idea -- why not have each test in an individual cell within an
[IPython notebook](http://ipython.org/notebook.html)? Then, each cell
can be run individually, and thus each test can still be solved one at
a time! Even if the cells don't have syntax errors in them, this could
be a great environment for solving Python koans, because you don't
have to switch back and forth between an editor and a shell, and you
can easily create new cells to test ideas out, if you feel like it.

As a proof of concept, I converted the lesson `about_strings` (which
you can find
[here](https://github.com/gregmalcolm/python_koans/blob/master/python2/koans/about_strings.py),
for Python 2, or
[here](https://github.com/gregmalcolm/python_koans/blob/master/python3/koans/about_strings.py),
for Python 3) into an IPython notebook. Here's the
[notebook on nbviewer](http://nbviewer.ipython.org/urls/gist.githubusercontent.com/jhamrick/10344303/raw/31808f83b012a99879ba5a57e0406f23056a5ff1/About+koans). Let
me know what you think!
