#include <stdio.h>
#include <stdlib.h>

#define MAX 25

typedef struct block {
  struct block *above;
  struct block *below;
  int stack;
  int v;
} block;

struct block *table[MAX];

struct block *top(struct block *a) {
  while(a->above != NULL) a = a->above;
  return a;
}

void set_stack(struct block *a, int stack) {
  while(a != NULL) {
    a->stack = stack;
    a = a->above;
  }
}

void over(struct block *a, struct block *b) {
  struct block *top_b = top(b);
  if(a->below != NULL) a->below->above = NULL;
  else table[a->v] = NULL;
  top_b->above = a;
  a->below = top_b;
}

void put_back(struct block *a) {
  struct block *b;
  while(a->above != NULL) {
    b = a->above;
    a->above = NULL;
    b->below = NULL;
    b->stack = b->v;
    table[b->v] = b;
    a = b;
  }
}

void onto(struct block *a, struct block *b) {
  put_back(b);
  over(a, b);
}

void print_table(int n) {
  struct block *a;
  int i;
  for(i = 0; i < n; i++) {
    printf("%d:", i);
    for(a = table[i]; a != NULL; a = a->above)  {
      printf(" %d", a->v);
    }
    printf("\n");
  }
}

/* #define DEBUG 1 */
#define Si(a) scanf("%d", &a)
#define Ss(a) scanf("%s", a)

int main() {
  int n, i, v;
  struct block *blocks[MAX];
  struct block *a, *b;

  for(i = 0; i < MAX; i++)
    table[i] = blocks[i] = NULL;

  Si(n);

  for(i = 0; i < n; i++) {
    table[i] = blocks[i] = (block *)malloc(sizeof(block));
    blocks[i]->above = NULL;
    blocks[i]->below = NULL;
    blocks[i]->stack = i;
    blocks[i]->v = i;
  }

  char verb[4];
  char prep[4];
  while(1 == 1) {
    Ss(verb);

    if(verb[0] == 'q') break;

    Si(v);
    a = blocks[v];
    Ss(prep);
    Si(v);
    b = blocks[v];

    if(a->stack == b->stack) continue;

    if(verb[0] == 'm') {
#ifdef DEBUG
      printf("move %d ", a->v);
#endif
      put_back(a);
    }
#ifdef DEBUG
    else if(verb[0] == 'p') {
      printf("pile %d ", b->v);
    }
#endif

    set_stack(a, b->stack);

    if(prep[1] == 'n') {
#ifdef DEBUG
      printf("onto %d\n", b->v);
#endif
      onto(a, b);
    } else {
#ifdef DEBUG
      printf("over %d\n", b->v);
#endif
      over(a, b);
    }

#ifdef DEBUG
    print_table(n);
#endif
  }

  print_table(n);

  for(i = 0; i < n; i++)
    free(blocks[i]);

  return 0;
}
