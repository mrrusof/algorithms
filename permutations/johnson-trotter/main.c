#include <stdio.h>

int swap_count;

void print_swap(int i, int n) {
  int k;
  printf("%3d ", ++swap_count);
  for(k = 0; k < n-1; k++) {
    if(k == i)
      printf("|<-->");
    else
      printf("|    ");
  }
  printf("|");
}

void adjacent_swap(char *a) {
  char t = *a;
  *a = *(a + 1);
  *(a + 1) = t;
}

/*
  1                     ABCD
  2 .<-->.    .    .    BACD    L = 4   a = 0   b = 1
  3 .    .<-->.    .    BCAD    L = 4   a = 1   b = 2
  4 .    .    .<-->.    BCDA    L = 4   a = 2   b = 3
  5 .<-->.    .    .    CBDA    L = 3   a = 0   b = 1
  6 .    .    .<-->.    CBAD    L = 4   a = 2   b = 3
  7 .    .<-->.    .    CABD    L = 4   a = 1   b = 2
  8 .<-->.    .    .    ACBD    L = 4   a = 0   b = 1
  9 .    .    .<-->.    ACDB    L = 3   a = 2   b = 3
 10 .<-->.    .    .    CADB    L = 4   a = 0   b = 1
 11 .    .<-->.    .    CDAB    L = 4   a = 1   b = 2
 12 .    .    .<-->.    CDBA    L = 4   a = 2   b = 3
 13 .<-->.    .    .    DCBA    L = 2   a = 0   b = 1
 14 .    .    .<-->.    DCAB    L = 4   a = 2   b = 3
 15 .    .<-->.    .    DACB    L = 4   a = 1   b = 2
 16 .<-->.    .    .    ADCB    L = 4   a = 0   b = 1
 17 .    .    .<-->.    ADBC    L = 3   a = 2   b = 3
 18 .<-->.    .    .    DABC    L = 4   a = 0   b = 1
 19 .    .<-->.    .    DBAC    L = 4   a = 1   b = 2
 20 .    .    .<-->.    DBCA    L = 4   a = 2   b = 3
 21 .<-->.    .    .    BDCA    L = 3   a = 0   b = 1
 22 .    .    .<-->.    BDAC    L = 4   a = 2   b = 3
 23 .    .<-->.    .    BADC    L = 4   a = 1   b = 2
 24 .<-->.    .    .    ABDC    L = 4   a = 0   b = 1
*/

void johnson_trotter(char *s, int l, int n, int *d) {
  int i, a, offset = 0;
  for(i = 0; i < l - 1; i++) {
    if(l < n) {
      johnson_trotter(s, l + 1, n, d);
      if(d[n - 1] == -1)
	offset = 0;
      else
	offset = 1;
    }
    if(d[l - 1] == 1)
      a = offset + i;
    else
      a = offset + l - 2 - i;
    adjacent_swap(s + a);
    print_swap(a, n);
    printf(" %s\tL = %d\ta = %d\tb = %d\n", s, l, a, a + 1);
  }
  if(l < n)
    johnson_trotter(s, l + 1, n, d);
  d[l - 1] *= -1;
}

#define N 6

int main() {
  int i;
  char s[N+1] = "ABCDEF";
  int d[N];
  for(i = 0; i < N; i++)
    d[i] = 1;
  printf("  1 ");
  for(i = 0; i < N-1; i++)
    printf("|    ");
  printf("| %s\n", s);
  swap_count = 1;
  johnson_trotter(s, 2, N, d);
  return 0;
}
