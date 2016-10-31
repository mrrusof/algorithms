#include <stdio.h>

/*
Solution is a sequence of changes in height such that
1. A given height is the height of the tallest building for the corresponding interval.

  \empty
  (1, 11, 5)
  -----------
  1, 11, 5, 0

  1, 11,       5, 0
         2, 6,       7, 0
  -----------------------
  1, 11,       5, 6, 7, 0

  1, 11,            7, 0
         2, 6, 5, 11
  -----------------------
  1, 11,       5, 6, 7, 0

  1, 11,        5, 6, 7, 0
         3, 13,             9, 0 
  ------------------------------
  1, 11, 3, 13,             9, 0

  1, 11,        5, 6,       7, 0
         3, 13,       6, 0
  ------------------------------
  1, 11, 3, 13,       6, 6, 7, 0
  
*/

#define Si(n) scanf("%d", &n)
#define MAX 10000

int main() {
  int l, h, r;
  int hh[MAX];
  int suffix[MAX];
  int sl;
  int rev_suffix[MAX];
  int rsl;
  int ph;
  int ch;

  Si(l);
  Si(h);
  Si(r);

  hh[l] = h;
  hh[r] = 0;
  sl = 2;
  suffix[0] = r;
  suffix[1] = l;
  
  while(Si(l) != EOF) {
    Si(h);
    Si(r);
    ch = ph;
    for(; sl > 0 && suffix[sl - 1] < l; sl--) {
      printf("%d %d ", suffix[sl - 1], hh[suffix[sl - 1]]);
      ph = ch = hh[suffix[sl - 1]];
    }
    if(sl > 0 && suffix[sl - 1] == l) {
      ch = hh[l];
      if(hh[l] < h)
	hh[l] = h;
    }
    
    rsl = 0;
    if(ch < h) {
      for(; sl > 0 && suffix[sl - 1] <= r; sl--)
	ch = hh[suffix[sl - 1]];
      hh[r] = ch;
      suffix[sl++] = r;
      hh[l] = h;
      suffix[sl++] = l;
    } else { /* h <= ch */
      for(; sl > 0 && suffix[sl - 1] < r && hh[suffix[sl - 1]] > h; sl--)
	rev_suffix[rsl++] = suffix[sl - 1];
      if(sl > 0 && suffix[sl - 1] < r) {
	rev_suffix[rsl++] = suffix[--sl];
	ch = hh[suffix[sl]];
	hh[suffix[sl]] = h;
	for(; sl > 0 && suffix[sl - 1] <= r; sl--)
	  ch = hh[suffix[sl - 1]];
	hh[r] = ch;
	suffix[sl++] = r;
      }
      for(; rsl > 0;)
	suffix[sl++] = rev_suffix[--rsl];
    }
  }
  for(; sl > 1; sl--)
    printf("%d %d ", suffix[sl - 1], hh[suffix[sl - 1]]);
  printf("%d %d\n", suffix[0], hh[suffix[0]]);
  return 0;
}
