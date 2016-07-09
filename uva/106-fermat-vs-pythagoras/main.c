#include <stdio.h>

#define Si(i) scanf("%d", &i)

/*
  Input:  10
  Output: 1 4

  Explanation:

  Consider equation x^2 + y^2 = z^2 and constraints 0 < x,y,z <= 10.
  Consider the problem of searching solution values (x,y,z).
  Example:
    z          x   y
    1 ->   1 = 0 + 1 Not a solution
    2 ->   4 = No satisfying values x and y
                     4 - 1 = 3
 .  3 ->   9 = No satisfying values x and y
                     9 - 4 = 5
 .  4 ->  16 = No satisfying values x and y
                     16 - 9 = 7
                     16 - 4 = 12
 .  5 ->  25 = 9 + 16 = 16 + 9
                     25 - 16 = 9
 .  6 ->  36 = No satisfying values x and y
    7 ->  49 = No satisfying values x and y
                     49 - 36 = 13
                     49 - 25 = 24
                     49 - 16 = 33
 .  8 ->  64 = No satisfying values x and y 
                     64 - 49 = 15
                     64 - 36 = 28
                     64 - 16 = 48
    9 ->  81 = No satisfying values x and y 
                     81 - 64 = 7
                     81 - 49 = 32
                     81 - 36 = 45
 . 10 -> 100 = 36 + 64 = 64 + 36
                     100 - 81 = 19
                     100 - 64 = 36

  Solution is such that x,y < z.
  Reason is that x^2 + y^2 = z^2 and 0 < x,y.

  Solution where x => y corresponds to solution x <= y.

  Candidate values are x <= y < z < 10

  Given candidate y and z, corresponding x is given by following condition.
  x^2 = z^2 - y^2

  To search for a solution do the following.
  1. Select 0 < z <= 10.
  2. Select 0 < y < z s.t. z^2 - y^2 <= y^2.
  3. If x s.t. x \in Z and x^2 = z^2 - y^2 exists, x, y, z is solution.

-----

  When x^2 < y^2, then x < y.

  The reason is that the function is monotonic
  "The value to the right is always greater than the value to the left."

  When x < y, then x^2 < y^2
  When x^2 >= y^2, then x >= y.
  When x^2 > y^2, then x > y.
    Because x != y.
    When x = y then x * x = y * y.
  When x^2 < y^2, then x < y.

----

  How do you know if x and y are relative primes?

  Numbers x and y are relative primes when they have a common factor greater than 1.
  That is, when x = z * x' and y = z * y'.

  For example: 9 and 12 have common factor 3.

   9 .........
  12 ............

  Number 12 consists of 12 units.
  We may group those units in groups of the same size.
  The number of groups corresponds to a factor of 12.
  For example, 12 = 4 + 4 + 4 = 3 * 4.
  The minimum number of groups we can divide 12 in is 1.
  The maximum number of groups we can divide 12 in is 12.
   1 ............
   2 ...... ......
   3 .... .... ....
   4 ... ... ... ...
   6 .. .. .. .. .. ..
  12 . . . . . . . . . . . .

  For 9, the minimum number of groups we can divide 9 in is 1.
  For 9, the maximum number of groups we can divide 9 in is 9.
   1 .........
   3 ... ... ...
   9 . . . . . . . . .

  To find common factor 3 of 9 and 12, do the following.

  1. Pick 1 < z < 9 / 2.
  2. Check that 9 % z == 0 and 12 % z == 0.

  9 determines the upper limit because it is the smallest of 9 and 12.
  Because 9 is smallest, the range of candidate factors is smaller for 9 than for 12.
  The range of candidate factors for 9 is 1 to 9 / 2.
 */

#define MAX 1000000

int main() {
  int n;
  int x, y, z;
  int l, u;
  while(Si(n) != EOF) {
    for(z = 2; z <= n; z++) {
      for(y = z - 1; z*z - y*y <= y*y; y--) {
	l = 1;
	u = y;
	while(l <= u) {
	  x = (u + l) / 2;
	  if(x*x == z*z - y*y) {
	    printf("%d, %d, %d\n", x, y, z);
	    break;
	  } else if(x*x < z*z - y*y)
	    l = x + 1;
	  else if(x*x > z*z - y*y)
	    u = x - 1;
	}
      }
    }
  }
  return 0;
}
