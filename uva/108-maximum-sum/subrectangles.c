#include <stdio.h>

#define Si(n) scanf("%d", &n)

int main() {
  int n;
  int i, j;
  int s;
  Si(n);
  s = 0;
  for(i = 0; i < n; i++)
    for(j = 0; j < n; j++)
      s += (n - i) * (n - j);
  printf("Number of sub-rectangles for square matrix %dx%d is %d\n", n, n, s);
  return 0;
}
