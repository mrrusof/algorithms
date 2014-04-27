/*
A[0] = -7   A[1] =  1   A[2] = 5
A[3] =  2   A[4] = -4   A[5] = 3
A[6] =  0

-7 1 5 2 -4 3 0

-7
5 2 -4 3 0

-7 1
2 -4 3 0

-7 1 5
-4 3 0

-7 1 5 2
3 0

i = 6
-7 1 5 2 -4
0
 
*/

#include <iostream>

using namespace std;

int solution(int A[], int N) {
  long long left = 0;
  long long right = 0;
  int i;

  if (N == 0) return -1;
  
  for(i = 1; i < N; i++)
    right += (long long)A[i];

  for(i = 0; i < N-1; i++) {
    if (left == right) return i;
    left += (long long)A[i];
    right -= (long long)A[i+1];
  }
  
  if (left == right) return i;
  return -1;
}

int main(int n, char **arg) {
  int A[0];
  int r = solution(A, 0);
  cout<<"solution = "<<r<<endl;
  return 0;
}
