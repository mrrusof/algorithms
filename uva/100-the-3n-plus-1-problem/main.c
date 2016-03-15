#include <stdio.h>

#define MAX_INPUT 1000000
#define MAX(x,y) x > y ? x : y
#define MIN(x,y) x < y ? x : y
#define Si(n) scanf("%d", &n)

int lengths[MAX_INPUT];

int collatz_len(const int n) {
  int len;
  if(n < MAX_INPUT && lengths[n] > 0)
    return lengths[n];
  if(n & 1)
    len = collatz_len(3*n + 1) + 1;
  else
    len = collatz_len(n >> 1) + 1;
  if(n < MAX_INPUT)
    lengths[n] = len;
  return len;
}

int main() {
  int i, j, ii, jj, max;
  lengths[1] = 1;
  for(i = 2; i<MAX_INPUT; i++) lengths[i] = 0;
  while(Si(i) != EOF) {
    Si(j);
    ii = MIN(i, j);
    jj = MAX(i, j);
    for(max = 0; ii<=jj; ii++)
      max = MAX(max, collatz_len(ii));
    printf("%d %d %d\n", i, j, max);
  }
  return 0;
}
