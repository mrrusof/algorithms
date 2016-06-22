#include <stdio.h>

#define MAX_LEN 30

#define Ss(s) scanf("%s", s)

#define MIN(x,y) ( x < y ? x : y )

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

void swap_chars(char *s, int i, int j) {
  char t = s[i];
  s[i] = s[j];
  s[j] = t;
}

void swap_ints(int *s, int i, int j) {
  int t = s[i];
  s[i] = s[j];
  s[j] = t;
}

void johnson_mark_rules(char *s, int n) {
  print_swap(-1, n);
  printf(" %s\n", s);

  int e;
  int i[n];
  int o[n];
  int d[n];
  for(e = 0; e < n; e++) {
    i[e] = e;
    o[e] = e;
    d[e] = -1;
  }
  while(1) {
    for(e = n - 1; 0 < e; e--)
      if(0 <= i[e] + d[e] && i[e] + d[e] <= n - 1 && e > o[i[e] + d[e]])
	break;
    if(e == 0)
      return;
    swap_chars(s, i[e], i[e] + d[e]);
    swap_ints(o, i[e], i[e] + d[e]);
    swap_ints(i, e, o[i[e]]);
    print_swap(MIN(i[e], i[e] - d[e]), n);
    printf(" %s e = %d\n", s, e + 1);
    for(e += 1; e < n; e++)
      d[e] = -d[e];
  }
}

int main() {
  int slen;
  char s[MAX_LEN];
  Ss(s);
  for(slen = 0; s[slen] != '\0'; slen++);
  johnson_mark_rules(s, slen);
  return 0;
}
