#include <stdio.h>

#define Ss(s) scanf("%s", s)

#define MAX_LEN 1000

int count;

void print_swap(int i, int n) {
  int j;
  printf("%05d ", count++);
  for(j = 0; j < n - 1; j++)
    if(i == j)
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

void jt(char *s, int n, int l, int *p, int *o);

void step(char *s, int n, int l, int *p, int *o,int i) {
  if(l < n)
    jt(s, n, l + 1, p, o);
  swap_w_next(s, o[l - 1] + i);
  print_swap(o[l - 1] + i, n);
  printf(" %s\tL = %5d\ta = %5d\tb = %5d\n", s, l, o[l - 1] + i, o[l - 1] + i + 1);
}

void jt(char *s, int n, int l, int *p, int *o) {
  int i;
  if(p[l - 1])
    for(i = 0; i < l - 1; i++)
      step(s, n, l, p, o, i);
  else
    for(i = l - 2; 0 <= i; i--)
      step(s, n, l, p, o, i);
  if(l < n)
    jt(s, n, l + 1, p, o);
  if(l == n)
    o[n - 1] = 0;
  if(p[l - 1])
    o[l - 2] = o[l - 1];
  else
    o[l - 2] = o[l - 1] + 1;
  p[l - 1] = !p[l - 1];
}

void johnson_trotter(char *s, int len) {
  int i, p[len], o[len];
  if(len < 2)
    printf("The only permutation is %s", s);
  else {
    count = 1;
    print_swap(-1, len);
    printf(" %s\n", s);
    for(i = 0; i < len; i++)
      p[i] = 1;
    jt(s, len, 2, p, o);
  }
}

int main() {
  int len;
  char s[MAX_LEN];
  Ss(s);
  for(len = 0; s[len] != '\0'; len++);
  printf("\n");
  johnson_trotter(s, len);
  return 0;
}
