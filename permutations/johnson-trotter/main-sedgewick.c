#include <stdio.h>

#define Ss(s) scanf("%s", s)

int count = 0;
void print_swap(int i, int n) {
  int j;
  printf("%4d ", count++);
  for(j = 0; j < n - 1; j++)
    if(j == i)
      printf("|--");
    else
      printf("|  ");
  printf("|");
}

void swap_with_next(char *s, int i) {
  char t = s[i];
  s[i] = s[i + 1];
  s[i + 1] = t;
}

void JohnsonTrotterIterative(char *s, int n) {
  int i;
  int x;
  int k;
  int c[n];
  int d[n];
  for(i = 1; i < n; i++) {
    c[i] = 0;
    d[i] = 0;
  }
  c[0] = -1;
  print_swap(-1, n);
  printf(" %s\n", s);
  while(1) {
    i = n - 1;
    x = 0;
    for(; c[i] == i; i--) {
      if(!d[i])
	x++;
      d[i] = !d[i];
      c[i] = 0;
    }
    if(i == 0)
      break;
    if(d[i])
      k = c[i] + x;
    else
      k = (i - 1) - c[i] + x;
    swap_with_next(s, k);
    print_swap(k, n);
    printf(" %s\n", s);
    c[i]++;
  }
}

int main() {
  char *s;
  int slen;
  Ss(s);
  for(slen = 0; s[slen] != '\0'; slen++);
  JohnsonTrotterIterative(s, slen);
  return 0;
}
