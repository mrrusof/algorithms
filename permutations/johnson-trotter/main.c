#include <stdio.h>

void print_swap(int i, int n) {
  int k;
  for(k = 0; k < n-1; k++) {
    if(k == i)
      printf(".<-->");
    else
      printf(".    ");
  }
  printf(".");
}

void adjacent_swap(char *a) {
  char t = *a;
  *a = *(a + 1);
  *(a + 1) = t;
}

void johnson_trotter(char *s, int n, int l, int d) {
  int i, a, dd = d;
  for(i = 0; i < l-1; i++) {
    if(l < n)
      johnson_trotter(s, n, l+1, dd);
    if(dd == 1)
      if(d == 1)
	a = i;
      else
	a = l - 1 - i;
    else
      if(d == 1)
	a = n - l + i;
      else
	a = n - 1 - i;
    dd = -dd;
    adjacent_swap(s + a);
    print_swap(a, n);
    printf("\t%s\tL = %d\ta = %d\tb = %d\n", s, l, a, a + 1);
  }
  if(l < n)
    johnson_trotter(s, n, l+1, dd);
}

#define N 4

int main() {
  int k;
  char s[N+1] = "ABCD";
  for(k = 0; k < N-1; k++)
    printf("      ");
  printf("\t%s\n", s);
  johnson_trotter(s, N, 2, 1);
  return 0;
}
