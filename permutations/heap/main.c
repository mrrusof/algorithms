#include <stdio.h>

#define Ss(s) scanf("%s", s)

#define MAX_LEN 1000

int count;

void print_swap(int a, int b, int n) {
  int i;
  printf("%5d ", count++);
  for(i = 0; i < n - 1; i++)
    if(a == i)
      printf("|--");
    else if(a < i && i < b)
      printf("---");
    else
      printf("|  ");
  printf("|");
}

void swap(char *s, int a, int b) {
  char t = s[a];
  s[a] = s[b];
  s[b] = t;
}

void h(char *s, int n, int len) {
  int i;
  for(i = 0; ; i++) {
    if(n > 2)
      h(s, n - 1, len);
    if(i == n - 1)
      break;
    if(n % 2 == 0) {
      swap(s, i, n - 1);
      print_swap(i, n - 1, len);
    } else {
      swap(s, 0, n - 1);
      print_swap(0, n - 1, len);
    }
    printf(" %s N = %5d\n", s, n);
  }
}

void heap(char *s, int len) {
  if(len < 2) {
    printf("The only permutation is %s\n", s);
    return;
  }
  count = 1;
  print_swap(-1, -1, len);
  printf(" %s\n", s);
  h(s, len, len);
}

int main() {
  char s[MAX_LEN];
  int len;
  Ss(s);
  for(len = 0; s[len] != '\0'; len++);
  heap(s, len);
  return 0;
}
