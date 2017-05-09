# List To Tree

A functional programming approach for converting a list into a binary tree.
Haskell library doesn't seem to have such a function or I'm just bad at searching.
Anyways, this peace of code have certain functions operating on list and trees.

# Idea!
The idea for this code was obtained, while doing a project on _program synthesis_.
We required a function which can tell us whether a list is a _substructure_ of another or not and if it is, then get the appropriate set of _selectors_ to obtain it.

## Substructure

What does substructure means ?
Well, we know that internally, and hopefully, lists in Haskell are represented using '_cons - nil_'
constructors in the form of a tree.
Example:
 List [1,2,3] is represented as
      
      :
     / \
    1   :
       / \
      2   :
         / \
        3   []

Here, ":" represents _cons_ constructor and "[ ]" represents _nil_ constructor of list data type.
Now,
 Sub-structure of this lists are those lists which are part of this tree, and are tree by themselves, and those are:
 [1,2,3], [2,3], [3] and [ ], and associated their selectors are ```id```, ```tail.id```, ```tail.tail.id``` and ```tail.tail.tail.id``` respectively.
