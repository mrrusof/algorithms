Given a list of numbers as input:

25626 25757 24367 24267 16 100 2 7277

Output a delta encoding for the sequence.  In delta encoding, the
first element is reproduced as-is.  Each subsequent element is
represented as the numeric difference from the element before it.
E.g. for the sequence above, the delta encoding would be.

25626 131 -1390 -100 -24251 84 -98 7275

However, if a difference value does not fit in a single signed byte,
i.e. -127<=x<=127, then we would like to use an escape token, printing
it. This will denote that the value following the escape token is a full
four-byte difference value, rather than a one-byte difference value.
For this exercise use -128 as the escape token.

Given the escape token, the delta encoding for the list of numbers is
the following.

25626 -128 131 -128 -1390 -100 -128 -24251 84 -98 -128 7275
