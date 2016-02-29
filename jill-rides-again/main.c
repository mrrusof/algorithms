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


void solve(const int r, const int n[], const int s) {
  int i = 0;
  int len = s - 1;

  printf(" r  |  a  |  ai |  aj | sep | sepi| sepj|  b  |  bi |  bj\n");

  // Ignore negative prefix.
  while(i<len && n[i]<0) {
    printf("%3d |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0 |   0\n", n[i]);
    i++;
  }

  // Route has no nice parts if we reached the end.
  if(i == len) {
    printf("Route %d has no nice parts\n", r);
    return;
  }

  // Route has a nice part.

  int a, ai, aj;
  int b, bj;
  int sep, sepi, sepj_bi;
  a = aj = b = bj = sep = sepi = sepj_bi = 0;
  ai = i + 1;
  for(; i<len; i++) {
    if(n[i] > 0) {
      if(sep == 0) {
	// Set or extend a.
	a += n[i];
	aj = i + 2;
      } else {
	// Set or extend b.
	b += n[i];
	bj = i + 2;
      }
    } else {
      if(sep == 0) {
	// Set sep.
	sep = n[i];
	sepi = i + 1;
	sepj_bi = i + 2;
      } else {
	if(b == 0) {
	  // Extend sep.
	  sep += n[i];
	  sepj_bi = i + 2;
	} else {
	  // Decide if we keep a -> sep -> b, just a, or just b.
	  if(a >= -sep && b >= -sep) {
	    // We may keep segment a -> sep -> b.

	    if(a2j == sepi) {
	      // Segments a and sep are adjacent.

	      // Keep a -> sep -> b.
	      a = a + sep + b;
	      aj = bj;
	    } else {
	      // Segments a and sep are not adjacent.

	      if(b > a) {
		// Keep b
		a = b;
		ai = sepj_bi;
		aj = bj;
	      } else {
		if(a < b) {
		  // Keep a
		} else {
		  // 
		}
	      }
	    }
	  } else {
	      if(b > a) {
		// Keep b
		a = b;
		ai = sepj_bi;
		aj = bj;
	      } else {
		// Keep a
	      }	      
	  }

	  // Set sep and reset b.
	  sep = n[i];
	  sepi = i + 1;	  
	  b = 0;
	  sepj_bi = i + 2;
	  bj = 0;
	}
      }
    }

    printf("%3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d\n",
	   n[i], a, ai, aj, sep, sepi, sepj_bi, b, sepj_bi, bj);
  }

    
  // If segment b is set, decide if we keep a -> sep -> b, just a, or just b.
  if(b > 0) {
    if(a >= -sep && b >= -sep) {
      // We may keep segment a -> sep -> b.

      if(aj == sepi) {
	// Segments a and sep are adjacent.

	// Keep a -> sep -> b.
	a = a + sep + b;
	aj = bj;
      } else {
	// Segments a and sep are not adjacent.

	if(b > a) {
	  // Keep b
	  a = b;
	  ai = sepj_bi;
	  aj = bj;
	} else {
	  // Keep a
	}
      }
    } else {
      if(b > a) {
	// Keep b
	a = b;
	ai = sepj_bi;
	aj = bj;
      } else {
	// Keep a
      }	      
    }
  }

  printf("end | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d\n",
	 a, ai, aj, sep, sepi, sepj_bi, b, sepj_bi, bj);

  printf("The nicest part of route %d is between stops %d and %d\n", r, ai, aj);
}

int main() {
  int r = 1;
  int s = 10;
  int n[] = {4, -5, 4, -3, 4, 4, -4, 4, -5};
  solve(r, n, s-1);

  return 0;
}
