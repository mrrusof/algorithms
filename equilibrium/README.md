# Equilibrium index of an array

Given an array of integers, find an equilibrium index.

An equilibrium index of an array is an index such that the sum of
elements at lower indexes is equal to the sum of elements at higher
indexes. For example, in an array A:

```
       A: -7  1  5  2 -4  3  0
position:  0  1  2  3  4  5  6
```

Index 3 is an equilibrium index, because:

```
A[0] + A[1] + A[2] = A[4] + A[5] + A[6]
```

Index 6 is also an equilibrium index, because sum of zero elements is zero:

```
A[0] + A[1] + A[2] + A[3] + A[4] + A[5]=0
```

Index 7 is not an equilibrium index, because it is not a valid index of array A.

**Input.**

The input file consists of one or more arrays, each on a single line.
Each array consists of a sequence of integers, each pair separated by
a single space.  The input file is terminated by an EOF
character. Consider the following example.

```
-7  1  5  2 -4  3  0
```

**Output.**
The output file consists of an output line for each array in the
input. Each output line consists of an equilibrium index (if any) or
-1 when no equilibrium index exists. For example, the following output
corresponds to the previous example input.

```
6
```
