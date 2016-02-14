/*
# Problem

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

#include <vector>

using namespace std;

/*
# Solution

Given a sequence of coins, the adjacency of the sequence either
changes or remains the same when we flip a coin because we either
gain pairs, lose pairs, or keep the same amount of pairs.  Consider
the following sequence and the delta adjacency when we flip each
coin.
```
Index  | Coin | Delta adjacency
-------------------------------
0      | 1    | -1
1      | 1    |  0
2      | 0    |  2
3      | 1    |  2
4      | 0    |  0
5      | 0    |  0
6      | 1    |  0
7      | 1    | -1
```
The adjacency for the sequence is 3.  If we flip the first or last
coin, we lose one pair and the adjacency becomes 2.  If we flip
coin 2 or 3, we gained two pairs and the adjacency becomes 5.
Flipping one of the other coins destroys a pair and creates another
pair, so the adjacency does not change if we flip any of them.

When we can gain coins, we choose to flip a coin that causes the
biggest gain.  When we cannot gain coins, we choose to flip a coin
that causes the smallest loss. That way we get the maximum number of
pairs possible.  For the sequence, we flip coin 2, which gives the
maximum possible adjacency 5.  Coin 3 is an alternative.

# Implementation

When the given sequence consists of one coin we return 0.  For this
case, 0 is always the right answer because adjacency is 0 and remains 0
after flipping the coin.

When the sequence has more coins, we compute the adjacency of the
sequence, compute the maximum delta adjacency, and return the sum
of these two values.

We compute the adjacency of the sequence by counting adjacent pairs.
We count adjacent pairs by iterating the sequence and inspecting the
current coin and the previous.  At each iteration, the current and
previous coins either form a pair or not.  Each time the current coin
and the previous show the same side, we count one pair.  Our
implementation is the following.
```
 */
int adjacency(const vector<int> &A) {
  int adjacency = 0;
  int previous = -1;
  for(int i = 0; i < A.size(); i++) {
    if(previous == A[i]) adjacency++;
    previous = A[i];
  }
  return adjacency;
}
/*
```

We compute the maximum delta adjacency by computing the delta
adjacency for each coin and keeping the maximum.  For the first and
last coins, we apply the following rule and keep the maximum.
```
The first or last coin
| Adjacent coin
|/      Delta adjacency
||     /
||     |
vv     v

00 -> -1
01 ->  1
10 ->  1
11 -> -1
```
When there are coins in the middle, we apply the following rule to
each coin and update the maximum delta.
```
Coin to the left
| A coin in the middle
|/ Coin to the right
||/      Delta adjacency
|||     /
|||     |
vvv     v

000 -> -2
001 ->  0
010 ->  2
011 ->  0
100 ->  0
101 ->  2
110 ->  0
111 -> -2
```
Our implementation is the following.
```
*/
int max(int x, int y) {
  if(x < y) return y;
  return x;
}

int maximum_delta_adjacency(const vector<int> &A) {
  int maximum;
  int last_position = A.size() - 1;
  maximum = A[0] == A[1] ? -1 : 1;
  maximum = max(A[last_position] == A[last_position-1] ? -1 : 1, maximum);
  int middle[2][2][2] = {{{-2, 0}, {2, 0}}, {{0, 2}, {0, -2}}};
  for(int i = 1; i < last_position; i++) {
    maximum = max(middle[A[i-1]][A[i]][A[i+1]], maximum);
  }
  return maximum;
}
/*
```

The last touch is adding the adjacency and the maximum delta
adjacency in function `solution` as follows.
 */

int solution(const vector<int> &A) {
  if(A.size() == 1) return 0;
  return adjacency(A) + maximum_delta_adjacency(A);
}

/*

We illustrate usage of `solution` in the following program.

 */

#include <iostream>

void print_vector(const vector<int> &A) {
  cout << A[0];
  for(int i = 1; i < A.size(); i++)
    cout << ", " << A[i];
  cout << "\n";
}

int main() {
  int vA[] = {0};
  vector<int> A(&vA[0], &vA[0]+1);
  print_vector(A);
  cout << "Maximum possible adjacency is " << solution(A) << ".\n";
  int vB[] = {0, 0};
  vector<int> B(&vB[0], &vB[0]+2);
  print_vector(B);
  cout << "Maximum possible adjacency is " << solution(B) << ".\n";
  int vC[] = {0, 1};
  vector<int> C(&vC[0], &vC[0]+2);
  print_vector(C);
  cout << "Maximum possible adjacency is " << solution(C) << ".\n";
  int vD[] = {0, 1, 0, 1, 0, 0, 1, 0};
  vector<int> D(&vD[0], &vD[0]+8);
  print_vector(D);
  cout << "Maximum possible adjacency is " << solution(D) << ".\n";
  int vE[] = {1, 1, 0, 1, 0, 0, 1, 1};
  vector<int> E(&vE[0], &vE[0]+8);
  print_vector(E);
  cout << "Maximum possible adjacency is " << solution(E) << ".\n";



  return 0;
}
