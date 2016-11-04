# The Pattern Matching Problem

## Input

A set of words and a set of patterns.  Each word and each pattern is
given in a line by itself.  Words and patterns are separated by
character `#`.  In patterns, the character period `.` matches any
character.  The input is terminated by EOF.

## Output

For each pattern, write in a single line the pattern, a space, and
true if the pattern matches a word or false if it does not.  Output
patterns in the order you read them.

## Example

### Input

```asciidoc
coin
coins
does
dork
why
work
#
coin
coins
c
co
coi
coins
coins.
.coins
does
d
do
doe
.oes
d.es
do.s
doe.
w..
w...
w....
```

### Output

```asciidoc
coin true
coins true
c false
co false
coi false
coins true
coins. false
.coins false
does true
d false
do false
doe false
.oes true
d.es true
do.s true
doe. true
w.. true
w... true
w.... false
```
