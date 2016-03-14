#include <stdio.h>

#define MAX_INPUT 1000000
#define MAX(x,y) x > y ? x : y
#define MIN(x,y) x < y ? x : y
#define Si(n) scanf("%d", &n)

unsigned int lengths[MAX_INPUT];

int collatz(unsigned int n) {
  int len = 0;
  while(n >= MAX_INPUT) {
    if(n & 1)
      n = 3*n + 1;
    else
      n = n >> 1;
    len++;
  }
  if(lengths[n] > 0)
    return lengths[n] + len;
  if(n & 1)
    lengths[n] = collatz(3*n + 1) + 1;
  else
    lengths[n] = collatz(n >> 1) + 1;
  return lengths[n] + len;
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
