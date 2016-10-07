#include <stdio.h>

#define MAX_LEN 1000000
#define Si(i) scanf("%d", &i)

int alg_g(int *A, int len) {
  int min = len > 0 ? A[0] : 0;
  int max = 0;
  for(int i = 0; i < len; i++)
    if(A[i] < min)
      min = A[i];
    else if(A[i] - min > max)
      max = A[i] - min;
  return max;
}

int main() {
  int A[MAX_LEN];
  int len = 0;
  int n;
  while(Si(n) != EOF)
    A[len++] = n;
  printf("%d\n", alg_g(A, len));
  return 0;
}
