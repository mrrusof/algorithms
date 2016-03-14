#include <stdio.h>

#define MAX_INPUT 1000000
#define MAX(x,y) x > y ? x : y
#define MIN(x,y) x < y ? x : y
#define Si(n) scanf("%d", &n)

unsigned short int lengths[MAX_INPUT];

int collatz(const unsigned int n) {
  unsigned short int len;
  if(n < MAX_INPUT && lengths[n] > 0)
    return lengths[n];
  if(n == 1)
    return 1;
  if(n & 1)
    len = collatz(3*n + 1) + 1;
  else
    len = collatz(n >> 1) + 1;
  if(n < MAX_INPUT)
    lengths[n] = len;
  return len;
}

int main() {
  unsigned int i, j, ii, jj, max;
  for(i = 0; i<MAX_INPUT; i++) lengths[i] = 0;
  while(Si(i) != EOF) {
    Si(j);
    ii = MIN(i, j);
    jj = MAX(i, j);
    for(max = 0; ii<=jj; ii++)
      max = MAX(max, collatz(ii));
    printf("%d %d %d\n", i, j, max);
  }
  return 0;
}
