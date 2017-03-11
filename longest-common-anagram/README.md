# Problem

[Inspired by this problem statement](https://www.urionlinejudge.com.br/judge/en/problems/view/1503).

Given a set of strings, find the length of a longest common
anagram.

For example, the length of a longest common anagram for the
following strings is 4 because a longest common anagram is `kikj`.

```
ijkik
kkjki
kljkikiijk
```

**Input.**
The input file consists of one or more cases.  Each case consists of a
number `n` on a single line followed by `n` lines, each consisting of
a word.  Each word consists of lowercase ascii letters from `a` to
`z`.  The input is terminated by EOF.  The following is a sample input
file.

```
3
ijkik
kkjki
kljkikiijk
```

**Output.**
The output file consists of one line per case, each consisting of a
single integer that indicates the length of the longest common
anagram for the case.
The following is the output file that corresponds to the sample input
file.

```
4
```

# Solution

Consider the count of letters for each word.

```
Word       | i | j | k | l
---------------------------
ijkik      | 2 | 1 | 2 | 0
kkjki      | 1 | 1 | 3 | 0
kljkikiijk | 3 | 2 | 4 | 1
```

A longest common anagram consists only of letters appearing in the
words.  For each letter, a longest common anagram has as many
instances of the letter as the minimum count amongst the words.
Consider the minimum count of letters amongst the words.

```
Word       | i | j | k | l
---------------------------
ijkik      | 2 | 1 | 2 | 0
kkjki      | 1 | 1 | 3 | 0
kljkikiijk | 3 | 2 | 4 | 1
           ----------------
             1   1   2   0  <-- minimum count of each letter
```

Given the minimum count of letters, we know that a longest common
anagram consists of one `i`, one `j`, and two `k`, thus giving a
grand total of 4 letters.
