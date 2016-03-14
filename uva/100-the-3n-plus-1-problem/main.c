#include <stdio.h>

#define MAX_INPUT 1000000
#define MAX(x,y) x > y ? x : y
#define MIN(x,y) x < y ? x : y
#define Si(n) scanf("%d", &n)

unsigned int lengths[MAX_INPUT];

int collatz(const unsigned int n) {
  if(n < MAX_INPUT) {
    if(lengths[n] > 0)
      return lengths[n];
    if(n & 1)
      lengths[n] = collatz(3*n + 1) + 1;
    else
      lengths[n] = collatz(n >> 1) + 1;
    return lengths[n];
  } else {
    if(n & 1)
      return collatz(3*n + 1) + 1;
    else
      return collatz(n >> 1) + 1;
  }
}

int main() {
  unsigned int i, j, ii, jj, max;
  lengths[1] = 1;
  for(i = 2; i < MAX_INPUT; i++) lengths[i] = 0;
  while(Si(i) != EOF) {
    Si(j);
    ii = MIN(i, j);
    jj = MAX(i, j);
    for(max = 0; ii <= jj; ii++)
      max = MAX(max, collatz(ii));
    printf("%d %d %d\n", i, j, max);
  }
  return 0;
}
