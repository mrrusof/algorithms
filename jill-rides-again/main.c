#include <stdio.h>

/*
# Rules for bus routes of length 1

r = [n1]
n1 > 0
-----------------------------------------
The nicest part is between stops 1 and 2

r = [n1]
n1 < 0
-----------------------------------------
Route has no nice parts


## Example

Consider the route `2`.
The route determines one segment, segment `2`.
The sum of niceness for the segment is positive and thus the only maximal sum.
For that reason, segment `2` is the nicest part of the route.


# Rules for bus routes of length 2

r = [n1, n2]
n1 > 0
n2 > 0
-----------------------------------------
The nicest part is between stops 1 and 3

r = [n1, n2]
n1 > 0
n2 < 0
-----------------------------------------
The nicest part is between stops 1 and 2

r = [n1, n2]
n1 < 0
n2 > 0
-----------------------------------------
The nicest part is between stops 2 and 3

r = [n1, n2]
n1 < 0
n2 < 0
-----------------------------------------
Route has no nice parts


## Example

Consider the route `-1, 2`.
The route determines the following three segments.

```asciidoc
 r |  1 |  2
--------------
-1 | -1 |
 6 |  6 |  5
```

The sum of niceness for segment `6` is the only maximal sum.
Thus, segment `6` is the nicest part of the route.


# Rules for bus routes of length 3

r = [n1, n2, n3]
n1 > 0
n2 > 0
n3 > 0
-----------------------------------------
The nicest part is between stops 1 and 4

r = [n1, n2, n3]
n1 > 0
n2 > 0
n3 < 0
-----------------------------------------
The nicest part is between stops 1 and 3

1, -1, 1 -> 1 and 4
1, -1, 2 -> 1 and 4
1, -2, 1 -> 1 and 4
1, -2, 1 -> 1 and 4

1, -2, 6 -> 3 and 4
1, -1, 6 -> 1 and 4
2, -1, 6 -> 1 and 4

r = [n1, n2, n3]
n1 > 0
n2 < 0
n3 > 0
-----------------------------------------
The nicest part is between stops 3 and 4 <----????

r = [n1, n2, n3]
n1 > 0
n2 < 0
n3 < 0
-----------------------------------------
The nicest part is between stops 1 and 2

r = [n1, n2, n3]
n1 < 0
n2 > 0
n3 > 0
-----------------------------------------
The nicest part is between stops 2 and 4

r = [n1, n2, n3]
n1 < 0
n2 > 0
n3 < 0
-----------------------------------------
The nicest part is between stops 2 and 3

r = [n1, n2, n3]
n1 < 0
n2 < 0
n3 > 0
-----------------------------------------
The nicest part is between stops 3 and 4

r = [n1, n2, n3]
n1 < 0
n2 < 0
n3 < 0
-----------------------------------------
Route has no nice parts






The nicest part is between stops 3 and 9


     |  1 |  2 |  3 |  4 |
----------------------------------------
   4 | 
  -5 |
   4 |
  -3 |
   4 |
   4 |
  -4 |
   4 |
  -5 |
     |

 */


void solve() {

}

int main() {
  int s = 10;
  int n[] = {4, -5, 4, -3, 4, 4, -4, 4, -5};
  for(int i=0; i<s-1; i++) {
    printf("%2d\n", n[i]);
  }

  return 0;
}
