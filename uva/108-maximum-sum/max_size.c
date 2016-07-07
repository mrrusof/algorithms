#include <stdio.h>

#define Si(n) scanf("%d", &n)

int main() {
  int n;
  int i, j;
  int s;
  Si(n);
  s = 0;
  printf("%d\n", n);
  for(i = 0; i < n; i++) {
    for(j = 0; j < n; j++)
      printf("1 ");
    printf("\n");
  }
  return 0;
}
