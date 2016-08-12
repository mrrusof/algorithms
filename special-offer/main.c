#include <stdio.h>

#define Si(i) scanf("%d", &i)
#define MAXLEN 100000
#define DEBUG 1

int t[MAXLEN];
void merge_sort(int *a, int n) {
  int m = n / 2;
  int i = 0;
  int j = m;
  int k = 0;
  if(n <= 1) return;
  merge_sort(a, m);
  merge_sort(a + m, n - m);
  while(k < n)
    if(i < m && j < n)
      if(a[i] <= a[j])
        t[k++] = a[i++];
      else
        t[k++] = a[j++];
    else if(i < m)
      t[k++] = a[i++];
    else
      t[k++] = a[j++];
  for(i = 0; i < n; i++)
    a[i] = t[i];
}

int check(int *C, int n, int *S, int m) {
  if(n < m)
    return 0;
  int i = 0;
  int j = 0;
  while(j < m)
    if(C[i] < S[j])
      i++;
    else if(C[i] == S[j]) {
      i++;
      j++;
    } else // C[i] > S[j]
      return 0;
  return 1;
}

void print(int *a, int n) {
  int i;
  for(i = 0; i < n - 1; i++)
    printf("%d ", a[i]);
  printf("%d\n", a[n-1]);
}

int main() {
  int i;
  int j;
  int n;
  int m;
  int C[MAXLEN];
  int S[MAXLEN];
  Si(i);
  while(i-- > 0) {
    Si(n);
    for(j = 0; j < n; j++)
      Si(C[j]);
    if(DEBUG) {
      printf("C: ");
      print(C, n);
    }
    merge_sort(C, n);
    if(DEBUG) {
      printf("C: ");
      print(C, n);
    }
    Si(m);
    for(j = 0; j < m; j++)
      Si(S[j]);
    if(DEBUG) {
      printf("S: ");
      print(S, m);
    }
    merge_sort(S, m);
    if(DEBUG) {
      printf("S: ");
      print(S, m);
    }
    if(check(C, n, S, m))
      printf("yes\n");
    else
      printf("no\n");
  }
  return 0;
}
