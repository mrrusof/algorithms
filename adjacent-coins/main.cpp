/*

Consider N coins aligned in a row. Each coin is showing either heads
or tails. The adjacency of these coins is the number of adjacent pairs
of coins with the same side facing up.

Write a function:
int solution(const vector<int> &A);
that, given a non-empty zero-indexed array A consisting of N integers
representing the coins, returns the maximum possible adjacency that
can be obtained by reversing exactly one coin (that is, one of the
coins must be reversed). Consecutive elements of array A represent
consecutive coins in the row. Array A contains only 0s and/or 1s:

0 represents a coin with heads facing up;
1 represents a coin with tails facing up.

For example, given array A consisting of eight numbers, such that:
  A[0] = 1  
  A[1] = 1  
  A[2] = 0
  A[3] = 1  
  A[4] = 0  
  A[5] = 0
  A[6] = 1
  A[7] = 1
----------------
Don't destroy these
(0,1)
(4,5)
(6,7)
---------------
Flip the rest...



  
------------------
  A[0] = 1  
  A[1] = 1  
  A[2] = 1
  A[3] = 1  
  A[4] = 0  
  A[5] = 0
  A[6] = 1
  A[7] = 1

the function should return 5. The initial adjacency is 3, as there are
three pairs of adjacent coins with the same side facing up, namely (0,
1), (4, 5) and (6, 7). After reversing the coin represented by A[2],
the adjacency equals 5, as there are five pairs of adjacent coins with
the same side facing up, namely: (0, 1), (1, 2), (2, 3), (4, 5) and
(6, 7), and it is not possible to obtain a higher adjacency.

The same adjacency can be obtained by reversing the coin represented
by A[3].

Assume that:

N is an integer within the range [1..100,000];
each element of array A is an integer within the range [0..1].

Complexity:
expected worst-case time complexity is O(N);
expected worst-case space complexity is O(1), beyond input storage
(not counting the storage required for input arguments). 
 */


/*
Example: Any coin will do
  A[0] = 0  
  A[1] = 0  
  A[2] = 0
  A[3] = 0 
  A[4] = 0
  
Example: Coin 2 is the one
  A[0] = 0  
  A[1] = 0
  A[2] = 1 <-
  A[3] = 0 
  A[4] = 0

  A[0] = 0
  A[1] = 0
  A[2] = 1
  A[3] = 1
  A[4] = 1

P: flip a face next to different face
Q: flip a face between different faces
  
  A[0] = 0
  A[1] = 0 P
  A[2] = 1 Q <
  A[4] = 0

  A[0] = 0
  A[1] = 0 P
  A[2] = 1 P

P -> Same number of pairs
Q -> 2 more pairs
  
 */


  
// you can also use includes, for example:
#include <vector>

using namespace std;
  
int solution(const vector<int> &A) {
  if (A.size() < 2) return 0;
  int pairs = 0;
  int condition = 0; /* 0 -> Neither P nor Q, 1 -> \exists C : P(C), 2 -> \exists C : Q(C)  */
  for(int i = 1; i < A.size(); i++) {
    if (A[i-1] == A[i]) pairs++;
    if (A[i-1] != A[i]) {
      if (condition == 0) condition = 1;
      else if (i+1 < A.size() && A[i] != A[i+1]) condition = 2;
    }
  }
  if (condition == 0) return pairs - 1;
  else if (condition == 1) return pairs;
  else if (condition == 2) return pairs+2;
}
