# [Read this in the blog](http://ruslanledesma.com/2017/02/15/count-anagrams-in-string.html)

# Problem

Given a strings `s` and `p`, count the anagrams of `s` that occur in
`p`.

For example, given `s` = "hello" and `p` = "ellohello", the count of
anagrams is 5.

# Solution

Consider the 5 anagrams of `s` = "hello" that occur in `p` =
"ellohello".

```
ellohello
-----
 -----
  -----
   -----
    -----
```

Each anagram is a substring of `p` and has the frequency of
letters that `s` has (one "h", one "e", two "l", and one
"o"). Therefore, to count the anagrams in `p`, consider each substring
of `p` of length 5 and check that the frequency of letters is the
same as that of `s`.

To consider all substrings of length 5, it suffices to _place a
window of length 5 on the left of `p`_ (in other words, underline the
first 5 characters) and then move the window to the right one position
at a time.

To check the frequency of letters for every position of the window, do
the following. For the first position, determine how many letters of
`s` occur in the window. If that frequency is the same as the
frequency of letters in `s`, count one anagram. In the example,
the substring given by the first window (`elloh`) passes the check.
For the rest of the positions, decrement the counter for the letter
that exits the window through the left and increase the counter for
the letter that enters the window from the right. In the example, for
the second position of the window (`llohe`), decrement the counter for
`e` (because `e` exits the window through the left) and then increment
the counter for `e` (because another `e` enters the window from the
right).


Finally, to avoid iterating over the counters every time you do the
frequency check, give the counters the following meaning. Each counter
is not how many times a letter occurs in a given window, but how many
more occurrences of the letter you need to make an anagram. In the
example, for the first position of the window, the counter for each
letter of `s` is 0 because the first position is an anagram. Then,
have an additional counter for how many counters have reached
zero. Decrement that counter every time a letter that enters makes a
counter reach zero and increment the counter every time a letter that
exits makes a counter go above zero.
