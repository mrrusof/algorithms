# Problem

Given a binary search tree, print all possible arrays that produce the
tree.  An array produces a tree by inserting the array's elements one
by one into the tree.  The elements are taken from the array from left
to right.

**Example**

Consider the following binary search tree.

```
   4
  / \
 2   9
```

Its corresponding arrays are the following.

```
[4, 9, 2]
[4, 2, 9]
```

**Input.**
The input file consists of positive integer `N` on the first line followed by `N` test cases.  The first line of any given test case consists of a pair of positive integers `M` and `R` separated by a single space.  Integer `M` indicates the number of edges in the binary search tree and `R` is the root of the tree.  The `M` lines that remain in the test case consist of pairs of positive integers `P` and `C` corresponding to an edge that goes from parent node `P` to child node `C`.  The following input file corresponds to the example.

```
1
2 4
4 2
4 9
```

**Output.**
The output consists of all possible arrays for each test case.  The arrays that correspond to a given test case must appear in lexicographical order.  Each array must appear on a single line.  To print an array, print the elements separated by space.  For example, the corresponding is the output for the previous input.

```
4 2 9
4 9 2
```
