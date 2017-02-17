# [Read this in the blog](http://ruslanledesma.com/2017/02/16/count-pair-with-difference.html)

# Problem

Given a list of integers, count the pairs where the difference equals a given integer `d`.

Consider the list `1 3 5 2 4` and `d` = 2. The count of pairs is 3 and
the pairs are `1, 3`, `2, 4`, and `3, 5`.

# Solution

The proposed solution is `O(n log n)`.

To count the pairs in `1 3 5 2 4` that are at difference 2, consider
the sorted set and the three pairs in the set.

```
1 2 3 4 5
A   A
  B   B
    C   C
```

To count those pairs, consider each integer `n` from left to right and
look for `n - d` to the left of `n`. For example, consider the way we
find pair `A`.  For the first integer `1`, there is nothing on the left,
so there is no pair.

```
1 2 3 4 5
^
```

For the second integer `2`, only integer `1` is to the left. Because
`0` is not to the left, there is no pair.

```
1 2 3 4 5
. ^
```

For the third integer `3`, integers `1` and `2` are to the
left. Because `1` is to the left, we find our first pair, which
we tag with label `A`.

```
1 2 3 4 5
.   ^
A   A
```

When we look for a corresponding integer to the left, it suffices to
consider the integers between the last integer to the left that we
considered and the current integer (marked with `^`).  For example,
consider the way we find pair `B` after we found `A`.  We consider the
fourth integer `4` and we look for `2` to the left.  Because we
already considered `1`, we look for `2` between `1` and `4`. When we
find `2`, we stop there and find our second pair `B`.

```
1 2 3 4 5
  .   ^
A   A
  B   B
```

Another example that it suffices to consider integers between the last
integer to the left and the current integer is when we find pair `C`.
In this case, the current integer is `5` and we look for `3` between
integers `2` and `5`. When we find `3` we find pair `C`.

```
1 2 3 4 5
    .   ^
A   A
  B   B
    C   C
```
