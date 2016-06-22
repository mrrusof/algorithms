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

void johnson_original(char *s, int n) {
  int j;
  int i;
  int c[n + 1];
  int ank;
  int bnk;
  int sn;
  for(i = 1; i <= n; i++)
    c[i] = 0;
  c[1] = 1;
  print_swap(-1, n);
  printf(" %s\n", s);
  while(1) {
    i = n;
    for(; c[i] == i - 1; i--)
      c[i] = 0;
    c[i]++;
    if(i == 1)
      break;
    if((c[i - 1] + (i - 1) * c[i - 2]) % 2 == 0)
      ank = i - c[i];
    else
      ank = c[i];
    if(i == n)
      bnk = 0;
    else if(i == n - 1) {
      if((c[n - 1] + (n - 1) * c[n - 2]) % 2 == 0)
	bnk = 0;
      else
	bnk = 1;
    } else if(i % 2 == 0) {
      if(c[i] % 2 == 0)
	bnk = 0;
      else
	bnk = 2;
    } else {
      if((c[i] + c[i - 1]) % 2 == 0)
	bnk = 0;
      else
	bnk = 1;
    }
    sn = ank + bnk - 1; /* Adjust index by subtracting 1. */
    swap_with_next(s, sn);
    print_swap(sn, n);
    printf(" %s\n", s);
  }
}

int main() {
  char *s;
  int slen;
  Ss(s);
  for(slen = 0; s[slen] != '\0'; slen++);
  johnson_original(s, slen);
  return 0;
}
