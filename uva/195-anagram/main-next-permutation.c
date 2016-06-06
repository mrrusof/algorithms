#include <stdio.h>

#define MAX_LEN 1000

#define Si(n) scanf("%d", &n)
#define Ss(s) scanf("%s", s)
#define UPCASE(c, u) if('a' <= c) u = c - ('a' - 'A'); else u = c;

char t[MAX_LEN];

int l_char(char a, char b) {
  char A, B;
  UPCASE(a, A);
  UPCASE(b, B);
  if(A == B) return a < b;
  return A < B;
}

void mergesort_chars(char *a, int n) {
  int i, j, k;
  int m = n / 2;
  if(n < 2) return;
  mergesort_chars(a, m);
  mergesort_chars(a + m, n - m);
  for(i = k = 0, j = m; k < n; k++)
    if(i < m && j < n)
      if(l_char(a[i], a[j]))
	t[k] = a[i++];
      else
	t[k] = a[j++];
    else if(i < m)
      t[k] = a[i++];
    else
      t[k] = a[j++];
  for(k = 0; k < n; k++)
    a[k] = t[k];
}

void swap(char *a, char *b) {
  char t = *a;
  *a = *b;
  *b = t;
}

void reverse(char *first, char *end) {
  char *last = end - 1;
  while(first < last)
    swap(first++, last--);
}

int next_permutation(char *first, char *end) {
  char *i, *ii, *j;
  if(first == end)
    return 0;
  if(first + 1 == end)
    return 0;
  i = end - 1;
  while(1) {
    ii = i;
    i--;
    if(l_char(*i, *ii)) {
      j = end - 1;
      while(!(l_char(*i, *j))) j--;
      swap(i, j);
      reverse(i + 1, end);
      return 1;
    }
    if(first == i)
      return 0;
  }
}

int main() {
  int n, s_len;
  char s[MAX_LEN], *end;
  Si(n);
  while(n-- > 0) {
    Ss(s);
    for(s_len = 0; s[s_len] != '\0'; s_len++);
    mergesort_chars(s, s_len);
    printf("%s\n", s);
    end = s + s_len;
    while(next_permutation(s, end))
      printf("%s\n", s);      
  }
  return 0;
}
  
