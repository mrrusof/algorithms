#include <stdio.h>

#define MAX_LEN 30

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

void swap_w_next(char *s, int i) {
  char t = s[i];
  s[i] = s[i + 1];
  s[i + 1] = t;
}

int jt(char *s, int l, int n, int *d) {
  int i;
  int o = 0;
  if(l < n)
    o = jt(s, l + 1, n, d);
  if(d[l])
    for(i = 0; i < l - 1; i++) {
      swap_w_next(s, o + i);
      print_swap(o + i, n);
      printf(" %s L = %2d\n", s, l);
      if(l < n)
	o = jt(s, l + 1, n, d);
    }
  else {
    for(i = l - 2; 0 <= i; i--) {
      swap_w_next(s, o + i);
      print_swap(o + i, n);
      printf(" %s L = %2d\n", s, l);
      if(l < n)
	o = jt(s, l + 1, n, d);
    }
    o++;
  }
  d[l] = !d[l];
  return o;
}

void johnson_trotter(char *s, int n) {
  int i;
  int d[MAX_LEN + 1];
  for(i = 0; i < MAX_LEN + 1; i++)
    d[i] = 0;
  print_swap(-1, n);
  printf(" %s\n", s);
  jt(s, 2, n, d);
}

int main() {
  char s[MAX_LEN];
  int slen;
  Ss(s);
  for(slen = 0; s[slen] != '\0'; slen++);
  johnson_trotter(s, slen);
  return 0;
}
