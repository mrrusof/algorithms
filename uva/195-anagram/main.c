#include <stdio.h>
#include <stdlib.h>

#define DEBUG 0
#define MAX_LEN 1000

#define Si(i) scanf("%d", &i)
#define Ss(s) scanf("%s", s)
#define UPCASE(c, u) if(c <= 'a') u = c - ('a' - 'A'); else u = c;

typedef struct letter {
  char letter;
  struct letter *next;
} letter;

char p[MAX_LEN];

letter *create_linked_list(char *s, int s_len) {
  int i;
  letter *first;
  letter *prev;
  letter *curr;
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
  return first;
}

void destroy_linked_list(letter *curr) {
  letter *prev;
  while(curr != NULL) {
    prev = curr;
    free(prev);
    curr = curr->next;
  }
}

int le_char(char a, char b) {
  char A, B;
  UPCASE(a, A);
  UPCASE(b, B);
  if(A == B) return a <= b;
  return A <= B;
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
	p[k] = a[i++];
      else
	p[k] = a[j++];
    else if(i < m)
      p[k] = a[i++];
    else
      p[k] = a[j++];
  for(k = 0; k < n; k++)
    a[k] = p[k];
}

void print_anagrams(letter *first, int l) {
  letter *prev;
  letter *curr;
  int i;
  if(first == NULL) {
    p[l] = '\0';
    printf("%s\n", p);
    return;
  }
  p[l] = first->letter;
  print_anagrams(first->next, l+1);
  prev = first;
  curr = first->next;
  while(curr != NULL) {
    if(prev->letter != curr->letter) {
      p[l] = curr->letter;
      prev->next = curr->next;
      print_anagrams(first, l+1);
      prev->next = curr;
    }
    prev = curr;
    curr = curr->next;
  }
}

int main() {
  int n, s_len;
  char s[MAX_LEN];
  letter *first;
  Si(n);
  while(n-- > 0) {
    Ss(s);
    for(s_len = 0; s[s_len] != '\0'; s_len++);
    mergesort_chars(s, s_len);
    first = create_linked_list(s, s_len);
    print_anagrams(first, 0);
    destroy_linked_list(first);
  }
  return 0;
}
