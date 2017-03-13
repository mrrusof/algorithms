# Problem

Given a string, find all dominant palindromes.  For a given string, a
dominant palindrome is a palindrome ocurring in the string that is
longer than 1 letter and is not a substring of another palindrome in
the string.

For example, for string `abcbabb`, there are three such
palindromes as follows.

```
abcbabb
-----
   ---
     --
```

# Solution

Given a string of length `n`, the proposed solution takes `O(n)` time
and space.

We illustrate our solution on the following string `s`.

```
  s: abcbabb
pos: 0123456
```

We determine the dominant palindromes from left to right in two steps.
We determine the longest palindrome greater than one character for
each position and then discard palindromes that are subsumed.

For string `s`, the longest palindromes are the following.  For
position 3 the longest palindrome is `bcb`, for position 4 is `abcba`,
for position 5 is `bab`, and for position 6 is `bb`.

For string `s`, there is only one subsumed palindrome.  That
palindrome is the one for position 3 and the dominant palindrome is
the one for position 4.

To determine longest palindromes we apply the following rules.

When there is a palindrome for a position, the longest palindrome is
either a continuation of a previous longest palindrome or a new
palindrome.  For example, for position 3 the longest palindrome `bcb`
is new because the characters in positions 1 and 3 are the
same. Another example, for position 4 the longest palindrome `abcba`
is a continuation of the palindrome for position 3 because the
characters in positions 0 and 4 are the same.

When there is no palindrome, neither condition is true.
For example, for position 2 there is no palindrome because there is no
palindrome for position 1 and the characters in positions 0 and 2 are
different.

When a position corresponds to a new palindrome, the reason is that
either the character two positions before is the same or the character
in the previous position is the same.  For example, position 3 is a
new palindrome because the character two positions before is the
same.  Another example, position 6 is a new palindrome because the
previous character is the same.

When the apply the rules for longest palindromes to each position, we
annotate the position with the start position of the longest
palindrome if any, like so.

```
    s: abcbabb
  pos: 0123456
start: ___1035
```

Given the list of start positions, we determine the dominant
palindromes by moving from left to right on the list, dropping any
previous start position that is greater than the current start
position because those are subsumed, like so.


```
       s: abcbabb
     pos: 0123456
   start: ___1035
dominant: ____035
```

Given that a previous palindrome can only be subsumed when we
determine a longest palindrome, we drop subsumed palindromes as we
determine palindromes in the following way.

When we continue a palindrome, we drop the start position for the
previous position because we just subsumed the longest palindrome for
the previous position.  For example, for position 4 we continue the
palindrome for position 3, and so we drop the start position for
position 3.

When we find a new longest palindrome of length 2, there is nothing to
drop, because any palindrome for the previous position starts before
the previous position.  For example, for position 6, the palindrome
for position 5 starts in position 3.

When we find a new longest palindrome of length 3 at position `i`, we
drop the previous start position when that start position is `i - 2`.
For example, consider the start and dominant positions of string
`aaa`.

```
       s: aaa
     pos: 012
   start: _00
dominant: __0
```
