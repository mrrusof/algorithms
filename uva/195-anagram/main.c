#include <stdio.h>
#include <stdlib.h>

#define DEBUG 0
#define MAX_LEN 1000

#define Si(i) scanf("%d", &i)
#define Ss(s) scanf("%s", s)
#define UPCASE(c, u) if(c >= 'a') u = c - ('a' - 'A'); else u = c;

typedef struct letter {
  char letter;
  struct letter *next;
} letter;

char t[MAX_LEN];

int le_char(char a, char b) {
  char A, B;
  UPCASE(a, A);
  UPCASE(b, B);
  if(A < B) return 1;
  if(A == B)
    if(a < b)
      return 1;
  return 0;
}

void mergesort_chars(char *a, int n) {
  int i, j, k;
  int m = n / 2;
  if(n <= 1) return;
  mergesort_chars(a, m);
  mergesort_chars(a + m, n - m);
  for(i = k = 0, j = m; k < n; k++)
    if(i < m && j < n)
      if(le_char(a[i], a[j]))
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

void print_anagrams(letter *first, int l) {
  letter *prev;
  letter *curr;
  int i;
  if(first == NULL) {
    for(i = 0; i < l; i++)
      printf("%c", t[i]);
    printf("\n");
    return;
  }
  t[l] = first->letter;
  print_anagrams(first->next, l+1);
  prev = first;
  curr = first->next;
  while(curr != NULL) {
    if(prev->letter != curr->letter) {
      t[l] = curr->letter;
      prev->next = curr->next;
      print_anagrams(first, l+1);
      prev->next = curr;
    }
    prev = curr;
    curr = curr->next;
  }
}

int main() {
  int n, i, s_len;
  char s[MAX_LEN];
  letter *first;
  letter *prev;
  letter *curr;
  Si(n);
  while(n-- > 0) {
    Ss(s);
    for(s_len = 0; s[s_len] != 0; s_len++);
    mergesort_chars(s, s_len);
#if DEBUG
    printf("original %s\n", s);
    printf("length %d\n", s_len);
    printf("sorted %s\n", s);
#endif
    first = (letter *)malloc(sizeof(letter));
    first->letter = s[0];
    first->next = NULL;
    prev = first;
    for(i = 1; i < s_len; i++) {
      curr = (letter *)malloc(sizeof(letter));
      curr->letter = s[i];
      curr->next = NULL;
      prev->next = curr;
      prev = curr;
    }
#if DEBUG
    printf("struct ");
    curr = first;
    while(curr != NULL) {
      printf("%c", curr->letter);
      curr = curr->next;
    }
    printf("\n");
#endif
    print_anagrams(first, 0);
    curr = first;
    while(curr != NULL) {
      prev = curr;
      free(prev);
      curr = curr->next;
    }
  }
  return 0;
}
