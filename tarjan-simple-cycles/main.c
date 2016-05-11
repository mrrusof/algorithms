#include <stdio.h>
#include <stdlib.h>
#include <sys/queue.h>

#define Si(n) scanf("%d", &n)

#define DEBUG 0

int **edge;
int *banned;
int n;
int s;
struct sitem {
  int n;
  SLIST_ENTRY(sitem) prev;
};
SLIST_HEAD(stack, sitem);
struct stack path = SLIST_HEAD_INITIALIZER(path);
struct stack banned_stack = SLIST_HEAD_INITIALIZER(banned_stack);

int reserve_mem() {
  int i;
  edge = (int **)malloc(sizeof(int *) * n);
  if(edge == NULL) return 1;
  for(i = 0; i < n; i++) {
    edge[i] = (int *)malloc(sizeof(int) * n);
    if(edge[i] == NULL) return 1;
  }
  banned = (int *)malloc(sizeof(int) * n);
  if(banned == NULL) return 1;
  return 0;
}

void free_mem() {
  free(edge);
  free(banned);
}

void print_path() {
  int i;
  struct sitem *si;
  si = SLIST_FIRST(&path);
  if(si != NULL ) printf("%d", si->n + 1);
  for(si = SLIST_NEXT(si, prev); si != NULL; si = SLIST_NEXT(si, prev)) {
    printf(", %d", si->n + 1);
  }
  printf("\n");
}

void push(struct stack *s, int n) {
  struct sitem *si = malloc(sizeof(struct sitem));
  if(si == NULL) {
    printf("Error reserving memory\n");
    free_mem();
    exit(1);
  }
  si->n = n;
  SLIST_INSERT_HEAD(s, si, prev);
}

int peek(struct stack *s) {
  struct sitem *si = SLIST_FIRST(s);
  return si->n;
}

int pop(struct stack *s) {
  int n;
  struct sitem *si = SLIST_FIRST(s);
  SLIST_REMOVE_HEAD(s, prev);
  n = si->n;
  free(si);
  return n;
}

int backtrack(int v) {
  int w;
  struct sitem *si;
  push(&path, v);
  push(&banned_stack, v);
  banned[v] = 1;
  int found_cycle = 0;
#if DEBUG
  printf("v = %d\n", v);
  printf("s = %d\n", s);
#endif
  for(w = s; w < n; w++) {
#if DEBUG
    printf("w = %d\n", w);
#endif
    if(!edge[v][w]) continue;
    if(w == s) {
      print_path();
      found_cycle = 1;
    } else if(!banned[w]) {
      found_cycle = backtrack(w) || found_cycle;
    }
  }
  if(found_cycle) {
    while(peek(&banned_stack) != v) {
      w = pop(&banned_stack);
      banned[w] = 0;
    }
    pop(&banned_stack);
    banned[v] = 0;
  }
  pop(&path);
  return found_cycle;
}

int main() {
  int a, b, v;
  Si(n);
  if(reserve_mem()) {
    printf("Error reserving memory.\n");
    return 1;
  }
  for(a = 0; a < n; a++)
    for(b = 0; b < n; b++) {
      edge[a][b] = 0;
    }
  while(Si(a) != EOF) {
    Si(b);
#if DEBUG
    printf("a, b = %d, %d\n", a, b);
#endif
    a--;
    b--;
    if(a > n || b > n) {
      printf("Index out of bounds\n");
      free_mem();
      return 1;
    }
    edge[a][b] = 1;
  }
  for(v = 0; v < n; v++)
    banned[v] = 0;
  for(s = 0; s < n; s++) {
    backtrack(s);
    while(!SLIST_EMPTY(&banned_stack)) {
      v = pop(&banned_stack);
      banned[v] = 0;
    }
  }
  free_mem();
  return 0;
}
