---
title: An Introduction to Classes and Inheritance (In Python)
layout: post
permalink: /2011/05/18/an-introduction-to-classes-and-inheritance-in-python/
comments: true
dsq_thread_id:
  - 1191974691
categories:
  - Programming
tags:
  - classes
  - inheritance
  - instances
  - python
  - tutorial
  - guide
---

**If you would like a copy of the code used in this post, you can
  download it [here][1].**

 [1]: https://gist.github.com/jhamrick/5320934

This post aims to give a short, basic introduction to the concept of
classes and inheritance, using Python as the language of choice.  **It
assumes knowledge of very basic Python syntax and functions. **These
examples were conceived during the [Boston Python Workshop][2] this
past weekend.

 [2]: http://openhatch.org/wiki/Boston_Python_workshop_2

<!-- more -->

### What is a Class?

Data structures like lists and strings are extremely useful, but
sometimes they aren't enough to represent something you're trying to
implement.  For example, let's say we needed to keep track of a bunch
of pets.  We could represent a pet using a list by specifying the
first element of the list as the pet's name and the second element of
the list as the pet's species.  This is very arbitrary and
nonintuitive, however -- how do you know which element is supposed to
be which?

Classes give us the ability to create more complicated data structures
that contain arbitrary content.  We can create a `Pet` class that
keeps track of the name and species of the pet in usefully named
attributes called `name` and `species`, respectively.

### What is an Instance?

Before we get into creating a class itself, we need to understand an
important distinction.  A class is something that just contains
structure -- it defines how something should be laid out or
structured, but doesn't actually fill in the content.  For example, a
`Pet` class may say that a pet needs to have a name and a species, but
it will not actually say what the pet's name or species is.

This is where *instances* come in. An instance is a specific copy of
the class that does contain all of the content. For example, if I
create a pet `polly`, with name `"Polly"` and species `"Parrot"`, then
`polly` is an instance of `Pet`.

This can sometimes be a very difficult concept to master, so let's
look at it from another angle. Let's say that the government has a
particular tax form that it requires everybody to fill out. Everybody
has to fill out the same *type* of form, but the content that people
put into the form differs from person to person. A **class** is like
the form: it specifies what content should exist. Your copy of the
form with your specific information if like an **instance** of the
class: it specifies what the content actually is.

### Keeping Track of Pets

Now that we have an idea of what a class is and what the difference
between a class and an instance is, let's look at a real class!

```python Pet Class
class Pet(object):
    
    def __init__(self, name, species):
        self.name = name
        self.species = species
    
    def getName(self):
        return self.name
    
    def getSpecies(self):
        return self.species
    
    def __str__(self):
        return "%s is a %s" % (self.name, self.species)
```

##### Line 1

This is the basic incant for creating a class.  The first word,
`class`, indicates that we are creating a class. The second word,
`Pet`, indicates the name of the class. The word in parentheses,
`object`, is the class that `Pet` is inheriting from. We'll get more
into inheritance below, so for now all you need to know is that
`object` is a special variable in Python that you should include in
the parentheses when you are creating a new class.

##### Lines 3-5

When we create a new pet, we need to initialize (that is, specify) it
with a `name` and a `species`. The `__init__` method (*method* is just
a special term for functions that are part of a class) is a special
Python function that is called when an instance of a class is first
created. For example, when running the code `polly = Pet("Polly",
"Parrot")`, the `__init__` method is called with values `polly`,
`"Polly"`, and `"Parrot"` for the variables `self`, `name`, and
`species`, respectively.

The `self` variable is the instance of the class. Remember that
instances have the structure of the class but that the values within
an instance may vary from instance to instance. So, we want to specify
that our instance (`self`) has different values in it than some other
possible instance. That is why we say `self.name = name` instead of
`Pet.name = name`.

You might have noticed that the `__init__` method (as well as other
methods in the `Pet` class) have this `self` variable, but that when
you call the method (e.g. `polly = Pet("Polly", "Parrot")`), you only
have to pass in two values. Why don't we have to pass in the `self`
parameter? This phenomena is a special behavior of Python: when you
call a method of an instance, Python automatically figures out what
`self` should be (from the instance) and passes it to the function. In
the case of `__init__`, Python first creates `self` and then passes it
in. We'll talk a little bit more about this below when we discuss the
`getName` and `getSpecies` methods.

##### Lines 7-11

We can also define methods to get the contents of the instance. The
`getName` method takes an instance of a `Pet` as a parameter and looks
up the pet's name. Similarly, the `getSpecies` method takes an
instance of a `Pet` as a parameter and looks up the pet's
species. Again, we require the `self` parameter so that the function
knows which instance of `Pet` to operate on: it needs to be able to
find out the content.

As mentioned before, we don't actually have to pass in the `self`
parameter because Python automatically figures it out. To make it a
little bit clearer as to what is going on, we can look at two
different ways of calling `getName`. The first way is the standard way
of doing it: `polly.getName()`. The second, while not conventional, is
equivalent: `Pet.getName(polly)`. Note how in the second example we
had to pass in the instance *because we did not call the method via
the instance*. Python can't figure out what the instance is if it
doesn't have any information about it.

To drive the difference between instances and classes home, we can
look at an explicit example:

```python
>>> from pets import Pet
>>> polly = Pet("Polly", "Parrot")
>>> print "Polly is a %s" % polly.getSpecies()
Polly is a Parrot
>>> print "Polly is a %s" % Pet.getSpecies(polly)
Polly is a Parrot
>>> print "Polly is a %s" % Pet.getSpecies()
Traceback (most recent call last):
  File "", line 1, in 
TypeError: unbound method getSpecies() must be called with Pet instance as first
argument (got nothing instead)
```

##### Lines 13-14

This `__str__` method is a special function that is defined for all
classes in Python (you have have noticed that methods beginning and
ending with a double underscore are special). You can specify your own
version of any built-in method, known as *overriding* the method. By
overriding the `__str__` method specifically, we can define the
behavior when we try to print an instance of the `Pet` class using the
`print` keyword.

### Using Classes

Let's look at some examples of using the `Pet` class!

```python Polly the Parrot
>>> from pets import Pet
>>> polly = Pet("Polly", "Parrot")
>>> polly.getName()
'Polly'
>>> polly.getSpecies()
'Parrot'
>>> print polly
Polly is a Parrot
```

```python Ginger the Cat
>>> from pets import Pet
>>> ginger = Pet("Ginger", "Cat")
>>> ginger.getName()
'Ginger'
>>> ginger.getSpecies()
'Cat'
>>> print ginger
Ginger is a Cat
```

```python Clifford the Dog
>>> from pets import Pet
>>> clifford = Pet("Clifford", "Dog")
>>> clifford.getName()
'Clifford'
>>> clifford.getSpecies()
'Dog'
>>> print clifford
Clifford is a Dog
```

### Subclasses

Sometimes just defining a single class (like `Pet`) is not enough. For
example, some pets are dogs and most dogs like to chase cats, and
maybe we want to keep track of which dogs do or do not like to chase
cats. Birds are also pets but they generally don't like to chase
cats. We can make another class that is a `Pet` but is also
specifically a `Dog`, for example: this gives us the structure from
`Pet` but also any structure we want to specify for `Dog`.

```python Dog Class
class Dog(Pet):
    
    def __init__(self, name, chases_cats):
        Pet.__init__(self, name, "Dog")
        self.chases_cats = chases_cats

    def chasesCats(self):
        return self.chases_cats
```

We want to specify that all `Dog`s have species `"Dog"`, and also
whether or not the dog likes to chase cats. To do this, we need to
define our own initialization function (recall that this is known as
*overriding*). We also need to call the parent class initialization
function, though, because we still want the `name` and `species`
fields to be initialized. If we did not have line 4, then we could
still call the methods `getName` and `getSpecies`. However, because
`Pet.__init__` was never called, the `name` and `species` fields were
never created, so calling `getName` or `getSpecies` would throw an
error.

We can define a similar subclass for cats:

```python Cat Class
class Cat(Pet):

    def __init__(self, name, hates_dogs):
        Pet.__init__(self, name, "Cat")
        self.hates_dogs = hates_dogs
    
    def hatesDogs(self):
        return self.hates_dogs
```

##### A Closer Look at Inheritance

Let's examine the difference between `Dog` and `Pet`.

```python
>>> from pets import Pet, Dog
>>> mister_pet = Pet("Mister", "Dog")
>>> mister_dog = Dog("Mister", True)
```

The function used below, `isinstance`, is a special function that
checs to see if an instance is an instance of a certain type of
class. Here we can see that `mister_pet` is an instance of `Pet`, but
not `Dog`, while `mister_dog` is an instance of both `Pet` and `Dog`:

```python
>>> isinstance(mister_pet, Pet)
True
>>> isinstance(mister_pet, Dog)
False
>>> isinstance(mister_dog, Pet)
True
>>> isinstance(mister_dog, Dog)
True
```

Because `mister_pet` is a `Pet`, but not a `Dog`, we can't call
`chasesCats` on it because the `Pet` class has no `chasesCats`
method. We can, however, call `chasesCats` on `mister_dog`, because it
is defined for the `Dog` class. Conversely, we *can* call the
`getName` method on both `mister_pet` and `mister_dog` because they
are both instances of `Pet`, even though `getName` is not explicitly
defined in the `Dog` class.

```python
>>> mister_pet.chasesCats()
Traceback (most recent call last):
  File "", line 1, in 
AttributeError: 'Pet' object has no attribute 'chasesCats'
>>> mister_dog.chasesCats()
True
>>> mister_pet.getName()
'Mister'
>>> mister_dog.getName()
'Mister'
```

##### Cats and Dogs

Now let's create some cats and dogs.

```python
>>> from pets import Cat, Dog
>>> fido = Dog("Fido", True)
>>> rover = Dog("Rover", False)
>>> mittens = Cat("Mittens", True)
>>> fluffy = Cat("Fluffy", False)
>>> print fido
Fido is a Dog
>>> print rover
Rover is a Dog
>>> print mittens
Mittens is a Cat
>>> print fluffy
Fluffy is a Cat
>>> print "%s chases cats: %s" % (fido.getName(), fido.chasesCats())
Fido chases cats: True
>>> print "%s chases cats: %s" % (rover.getName(), rover.chasesCats())
Rover chases cats: False
>>> print "%s hates dogs: %s" % (mittens.getName(), mittens.hatesDogs())
Mittens hates dogs: True
>>> print "%s hates dogs: %s" % (fluffy.getName(), fluffy.hatesDogs())
Fluffy hates dogs: False
```

### The End

Hopefully this was helpful in explaining what classes are, why we
would want to use them, and how to subclass classes to create multiple
layers of structure. For a more in-depth explanation of classes, you
can look at the [official Python documentation][3], or feel free to
ask me any questions you might have. I would also be happy to more
posts on other programming concepts -- I'm open to suggestions!

 [3]: http://docs.python.org/tutorial/classes.html
