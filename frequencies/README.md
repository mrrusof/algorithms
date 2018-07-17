Given a large list of words, find the frequency of a given word.
Take into consideration that you may be asked subsequently for the
frequency of other words.

Candidate approaches:
- By hash/dictionary.  Time is O(n*m) where n is length of list and m
  is length of longest word.
- By trie. Time is O(n*m) too.
