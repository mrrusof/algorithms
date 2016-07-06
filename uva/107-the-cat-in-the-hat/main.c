#include <stdio.h>

/*

  Height of initial cat is 216.
  Amount of worker cats is 125.
  
  Therefore:

  Amount of non-worker cats is 31.
  Height of stack of cats 671.

  Explanation:

  For every non-worker cat, there is the same amount of helpers and we do not know that amount.
  Let N be the amount of helpers.
  Amount N determines the amount of helpers in each level.
  For level L, that amount is N^L.
  For example, for N = 2, the amount of cats in levels 1 and 2 is the following.
  The formula N^L also works for level 0 and always gives 1.

  2^0 = 1
  |  2^1 = 2
  |  | 2^2 = 4
  |  | |
  |  | v
  |  |
  |  v * ...
  |   /
  |  *   
  v / \
   /   * ...
  *
   \   * ...
    \ /
     *
      \
       * ...

  When we are given an amount of worker cats M, that amount is a power of N.
  The exponent of N corresponds to the depth D of the tree and we do not know the depth.
  Thus, N^D = M.
  There may be more than one N and D that satisfies the equation, for example for M = 64:
  N = 2
  D = 6
  N^D = 64
  and
  N = 8
  D = 2
  N^D = 64  

  Given N and D, the amount of non-worker cats N^0 + N^1 + N^2 + ... + N^(D-1).
  For example for N=5 and D=3 the amount is 31 = 1 + 5 + 25.

  Given N and depth D, the height of each cat in level L is (N + 1)^(D - L).
  For example, when N=2 and D=2, we have 

       * <-- 1
      /
     * <---- 3
    / \
   /   *
  *  <------ 9
   \   *
    \ /
     *
      \
       *

  Given that the number of cats per level is N^L, the height of all cats one on top of the other is N^0 * (N + 1)^(D - 0) + N^1 * (N + 1)^(D - 1) + N^2 * (N + 1)^(D - 2) + ... + N^(D-1) * (N + 1)^1 + N^D * (N + 1)^0.
  For example, for N=5 and D=3, the height 671 is given by the formula in the following way.

    1 * 6^3 + 5 * 6^2 + 25 * 6 + 125 * 1
  = 216     + 180     + 150    + 125
  = 671

  The first term of the summation is the height of the initial cat, so N and D also satisfy (N + 1)^D = H.

  For D, there are three cases.
  Either D=0, D=1 or D>1.
  When D=0, H=1 and M=1.
  When D=1, H = M + 1.
  When D>1, 2 < N < sqrt(M).
*/

/*
   1   2   4  8 16 32 64
     243  81 27  9  3  1

   1 8 64
  81 9  1

  Constraints:

  N^D = M
  (N + 1)^D = H

 */

#define Si(n) scanf("%d", &n)

int main() {
  int m, h;
  int n, nn, hh;
  int nw, th;
  while(1) {
    Si(h);
    Si(m);
    if(h == 0 && m == 0)
      break;
    if(h == m + 1) {
      printf("1 %d\n", h + m);
      continue;
    }
    if(h == 1 && m == 1) {
      printf("0 1\n");
      continue;
    }
    for(n = 1; n*n <= m; n++) {
      if(h % (n + 1) != 0 || m % n != 0)
	continue;
      nw = 0;
      th = h;
      nn = 1;
      hh = h;
      for(; hh > 1;) {
	nw += nn;
	nn *= n;
	hh /= n + 1;
	th += nn * hh;
      }
      if(hh == 1 && nn == m)
	break;
    }
    printf("%d %d\n", nw, th);
  }
  return 0;
}
