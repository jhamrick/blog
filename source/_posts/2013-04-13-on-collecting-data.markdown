---
layout: post
title: "On collecting data"
date: 2013-04-13 20:44
comments: true
permalink: /2013/04/13/on-collecting-data/
categories: 
  - Programming
tags:
  - python
  - sql
  - sqlite
  - pandas
  - numpy
  - scientific programming
  - experiment
  - data
---

When collecting data, how do you save it?

There are about a million different options. In Python, you can choose
from many different libraries:

* pickle
* numpy
* yaml
* json
* csv
* sql

... just to name a few. Over time I'm fairly certain that I've managed
to save data (whether behavioral or simulation) in all of these
formats. This is really inconsistent: it makes it difficult to know
what encoding any particular dataset is in, let along the format of
the data itself, and it means I end up writing and rewriting code to
do saving, loading, parsing, etc., more times than I ought to.

I realize there are libraries like
[SQLAlchemy](http://www.sqlalchemy.org/), but this is actually a bit
*too* powerful for what I want. I want something simple and easy to
remember, and I want it to interface with the tools that I already
use; I'm not terribly interested in executing cross-table queries, for
example.  However, I do want some of the functionality of SQL/SQLite
(multiple tables, locking against concurrent access, flexible queries,
etc.).

So, I've begun writing a small module called `dbtools` (very creative
name, I know) that handles simple interfacing with a SQLite database.
Inspired by [ipython-sql](https://pypi.python.org/pypi/ipython-sql),
my library returns
[pandas DataFrame](http://pandas.pydata.org/pandas-docs/stable/dsintro.html#dataframe)
objects from `SELECT` queries, and can handle basic forms of other SQL
statements (`CREATE`, `INSERT`, `UPDATE`, `DELETE`, and `DROP`).

This is obviously very much a work in progress, and I'm not even sure
this will be useful for others! But, *I* do need a better, more
convenient way to save data -- especially behavioral data collected
online -- and so that's the goal of this library.  If you're
interested, you can find the source on
[GitHub](https://github.com/jhamrick/dbtools)
(patches/contributions welcome!).

Here are some examples of how it works.

## Create and load

```python Creating a table
>>> from dbtools import Table
>>> tbl = Table.create("data.db", "People",
... [('id', int),
... ('name', str),
... ('age', int),
... ('height', float)],
... primary_key='id',
... autoincrement=True)
>>> tbl
People(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, height REAL)
>>> type(tbl)
<class 'dbtools.table.Table'>
```

If a table already exists, we can just directly create a Table object:

```python Accessing a table
>>> tbl = Table("data.db", "People")
>>> tbl
People(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, height REAL)
>>> tbl.columns
(u'id', u'name', u'age', u'height')
>>> tbl.primary_key
u'id'
>>> tbl.autoincrement
True
```

## Insert

Inserting with a list (excluding `id`, because it autoincrements):

```python Inserting a list
>>> tbl.insert(["Alyssa P. Hacker", 25, 66.24])
>>> tbl.select()
                name  age  height
id
1   Alyssa P. Hacker   25   66.24
>>> type(tbl.select())
<class 'pandas.core.frame.DataFrame'>
```

Inserting with a dictionary:

```python Inserting a dictionary
>>> tbl.insert({
... 'name': 'Ben Bitdiddle',
... 'age': 24,
... 'height': 70.1})
>>> tbl.select()
                name  age  height
id
1   Alyssa P. Hacker   25   66.24
2      Ben Bitdiddle   24   70.10
```

You can insert as many things as you want as a time -- just pass them
in as a list of lists and/or dictionaries.

## Select

In the previous two examples, I already used an instance of selection
with `tbl.select()`, which is the equivalent of doing `FROM People
SELECT *`. You can use slicing to select rows (but only if the primary
key column is an integer and autoincrements). Note that because SQLite
databases are one-indexed, indexing the zeroth element returns an
empty `DataFrame`.

```python Selecting rows
>>> tbl[1]
                name  age  height
id
1   Alyssa P. Hacker   25   66.24
>>> tbl[2:]
             name  age  height
id
2   Ben Bitdiddle   24    70.1
```

If you pass in a string or sequence of strings, it will treat them as
column names and select those columns:

```python Selecting columns
>>> tbl['name', 'height']
                name  height
id
1   Alyssa P. Hacker   66.24
2      Ben Bitdiddle   70.10
```

More advanced selection can be done through the `select` method by
specifying the `where` keyword argument (and you can use the `?`
syntax from the `sqlite3` library for untrusted inputs):

```python Selection with WHERE
>>> tbl.select(where='age>24')
                name  age  height
id
1   Alyssa P. Hacker   25   66.24
>>> tbl.select(columns=['name', 'height'], where=('age>?', 24))
                name  height
id
1   Alyssa P. Hacker   66.24
```

## Update

Updating data in the table works by taking a dictionary (with the keys
being columns, and values being new data) and (optionally) a `where`
keyword argument like in the `select` method to specify what data
should be updated.

```python Updating
>>> tbl.update({'age': 26}, where='id=1')
>>> tbl.select()
                name  age  height
id
1   Alyssa P. Hacker   26   66.24
2      Ben Bitdiddle   24   70.10
```

## Delete

Deleting a row or rows requires specifying a `where` keyword argument
like in `select` and `update` (if it is not given, all rows are
deleted).

```python Deleting a row
>>> tbl.delete(where='height<70')
>>> tbl.select()
             name  age  height
id
2   Ben Bitdiddle   24    70.1
```

## Drop

Finally, we can drop a table if we so desire. Of course, this means we
can't interface with it afterwards unless we explicitly create it
again:

```python Drop a table
>>> tbl.drop()
>>> tbl.select()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "dbtools/table.py", line 339, in select
    cur.execute(*cmd)
sqlite3.OperationalError: no such table: People
```

## Other stuff

Currently there isn't too much else, except that I've included a
`save_csv` method which will call `select` and then save the result to
a csv file (using the `DataFrame.to_csv` method). I'm sure I'll come
up with other helper methods in the future, and am open to
suggestions.
