#include <stdlib.h>
#include <stdio.h>

/* #define DEBUG 0 */

typedef struct segment {
  int value;
  int i;
  int j;
  struct segment* prev;
  struct segment* next;
} segment;

void print_route(struct segment* first) {
  struct segment *curr = first;
  while(curr != NULL){
    printf("%2d (%2d, %2d)\n", curr->value, curr->i, curr->j);
    curr = curr->next;
  }
  printf("\n");
}

void solve(const int r, const int s) {
  int n;
  int i = 0;
  int len = s - 1;
  struct segment* first;
  struct segment* curr;
  struct segment* prev;
  struct segment* next;
  struct segment* max;

#ifdef DEBUG
  printf("\n########################\n");
  printf("Route %d of length %d is the following\n", r, len);
#endif

  /* Ignore negative prefix. */
  while(i<len) {
    scanf("%d", &n);
#ifdef DEBUG
    printf(">%d\n", n);
#endif
    if(n > 0) break;
    i++;
  }
  
  /* Route has no nice parts if we reached the end. */
  if(i == len) {
    printf("Route %d has no nice parts\n", r);
    return;
  }

  /* Preprocess the route. */
  first = curr = (segment *)malloc(sizeof(segment));
  curr->value = n;
  curr->i = i + 1;
  curr->j = i + 2;
  curr->prev = NULL;
  curr->next = NULL;
  i++;
  while(i<len) {
    scanf("%d", &n);
#ifdef DEBUG
    printf("%d\n", n);
#endif
    if((curr->value > 0 && n > 0) || (curr->value < 0 && n < 0)) {
      curr->value += n;
      curr->j++;
    } else {
      prev = curr;
      curr = (segment *)malloc(sizeof(segment));
      prev->next = curr;
      curr->value = n;
      curr->i = i + 1;
      curr->j = i + 2;
      curr->prev = prev;
      curr->next = NULL;
    }
    i++;
  }

  /* Cut a negative tail. */
  if(curr->value < 0) {
    prev = curr->prev;
    prev->next = NULL;
    free(curr);
  }

#ifdef DEBUG
  /* Print preprocessed route. */
  printf("\nPreprocessed route\n");
  print_route(first);
#endif

  /* Visit each separator. */
  curr = first->next;
  while(curr != NULL) {
    if(curr->prev->value >= -curr->value && curr->next->value >= -curr->value) {
#ifdef DEBUG
      printf("Found pivot %d\n", curr->value);
      printf("curr->value = %d\n", curr->value);
      printf("curr->prev = %d\n", curr->prev->value);
      printf("curr->next = %d\n", curr->next->value);
      printf("curr->i = %d\n", curr->i);
      printf("curr->j = %d\n\n", curr->j);
#endif

      /* Join previous and next. */
      prev = curr->prev;
      next = curr->next;

      prev->value += curr->value + next->value;
      prev->j = next->j;
      prev->next = next->next;
      if(prev->next != NULL) prev->next->prev = prev;

      free(curr);
      free(next);
      curr = prev;

#ifdef DEBUG
      printf("New segment\n");
      printf("curr->value = %d\n", curr->value);
      if(curr->prev != NULL) printf("curr->prev = %d\n", curr->prev->value);
      else printf("curr->prev = NULL\n");
      if(curr->next != NULL) printf("curr->next = %d\n", curr->next->value);
      else printf("curr->next = NULL\n");
      printf("curr->i = %d\n", curr->i);
      printf("curr->j = %d\n\n", curr->j);

      printf("Current route\n");
      print_route(first);
#endif

      if(curr->prev != NULL) {
	curr = curr->prev;
      } else {
	curr = curr->next;
      }
    } else {
      curr = curr->next->next;
    }
  }

#ifdef DEBUG
  printf("Processed route\n");
  print_route(first);
#endif

  /* Select maximum */
  max = curr = first;
  while(curr != NULL) {
    if(curr->value > max->value) {
      max = curr;
    } else if(curr->value == max->value) {
      if(curr->j - curr->i > max->j - max->i) {
	max = curr;
      }
    }
    curr = curr->next;
  }

  /* Print result. */
  printf("The nicest part of route %d is between stops %d and %d\n", r, max->i, max->j);

  /* Free the route. */
  curr = first;
  while(curr != NULL) {
    prev = curr;
    curr = curr->next;
    free(prev);
  }
}

int main() {
  int b, r, s;
  scanf("%d", &b);
  r = 0;
  while(r++ < b) {
    scanf("%d", &s);
    solve(r, s);
  }
  return 0;
}
