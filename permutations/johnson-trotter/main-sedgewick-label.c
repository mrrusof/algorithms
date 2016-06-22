#include <stdio.h>

#define Si(i) scanf("%d", &i)

void label(n) {
  int i;
  int c[n];
  for(i = 1; i < n; i++)
    c[i] = 0;
  c[0] = -1;
  while(1) {
    for(i = n - 1; c[i] == i; i--)
      c[i] = 0;
    if(i == 0)
      break;
    printf("%d ", i + 1);
    c[i]++;
  }
  printf("\n");
}

int main() {
  int n;
  Si(n);
  label(n);
  return 0;
}
