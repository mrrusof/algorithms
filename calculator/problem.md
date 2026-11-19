# Problem

Make a program that evaluates arithmetic expressions like the
following.

- `(12 / 6) (2 * 3) + 3`  --> `15`
- `30 / 6 * (2 + 3) + 10` --> `35`
- `((2 + 4) / 6) - 1`     --> `0`

Rules
- Numbers will always be integers.
- The value of expressions will always be integers and will always fit
  in 32 bit integer variables.
- `X ( Y )` means `X * Y`
- Operators `*` and `/` bind before `+` and `-`.
  - `1 + 2 * 3` -> `1 + (2 * 3)`
  - `1 * 2 + 3` -> `(1 * 2) + 3`
- Operators `*` and `/` (respectively `+` and `-`) associate to the
  left.
  - `1 + 2 - 3` -> `(1 + 2) - 3`
  - `4 / 2 * 3` -> `(4 / 2) * 3`

**Input.** The input will be given to your program via stdin.  The
  input consists of a number `N` followed by `N` lines, each line
  may or may not consist of an expression. Example:

```asciidoc
6
1 / 6 (2 + 3) + 3
1 / 6 * (2+ 3) + 10
1/6 * (2 +3)- 1
(1+2
110+*2
120*-2
```

**Output.** Your program will output its result via stdout.  The
  output consists of `N` lines, one for each input line consisting of
  the value of the expression, if any, or the text "parsing error" if
  the line is not an expression.. Example:

```asciidoc
4
11
0
parsing error
parsing error
parsing error
```


## Grammar

```asciidoc
N:  integers
♦:  binary operators *, /, +, -
E:  expressions
E': expressions without unary minus at the beginning

E  ::=  N
       -N
       E♦E'
       E♦(E)
       (E)

E' ::= N
       E'♦E'
       E'♦(E)
```
