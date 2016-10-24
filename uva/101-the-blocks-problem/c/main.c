#include <stdio.h>
#include <stdlib.h>

#define Si(a) scanf("%d", &a)
#define Ss(a) scanf("%s", a)

#define MAX 25

typedef struct block {
  struct block *above;
  struct block *below;
  int table_loc;
  int value;
} block;

block *table[MAX];

void put_back(block *a) {
  block *b;
  while(a->above != NULL) {
    b = a->above;
    a->above = NULL;
    b->below = NULL;
    b->table_loc = b->value;
    table[b->value] = b;
    a = b;
  }
}

block *top(struct block *a) {
  while(a->above != NULL) a = a->above;
  return a;
}

void stack(block *a, block *b) {
  block *top_b = top(b);
  block *a_below = a->below;
  int table_loc = b->table_loc;

  /* Remove stack a from its current position. */
  if(a_below != NULL) a_below->above = NULL;
  else table[a->value] = NULL;

  /* Stack stack a onto the top of stack b. */
  top_b->above = a;
  a->below = top_b;

  /* Update stack reference for block a and blocks above a. */
  while(a != NULL) {
    a->table_loc = table_loc;
    a = a->above;
  }
}

void print_table(int n) {
  block *a;
  int i;
  for(i = 0; i < n; i++) {
    printf("%d:", i);
    for(a = table[i]; a != NULL; a = a->above)  {
      printf(" %d", a->value);
    }
    printf("\n");
  }
}

int main() {
  int n, i, v;
  char verb[4], prep[4];
  block *blocks[MAX];
  block *a, *b;

  for(i = 0; i < MAX; i++)
    table[i] = blocks[i] = NULL;

  /* Read number of blocks `n`. */
  Si(n);

  /* Initialize world with `n` blocks. */
  for(i = 0; i < n; i++) {
    table[i] = blocks[i] = (block *) malloc(sizeof(block));
    blocks[i]->above = NULL;
    blocks[i]->below = NULL;
    blocks[i]->table_loc = i;
    blocks[i]->value = i;
  }

  while(1) {

    /* Read the verb. */
    Ss(verb);

    /* Exit when verb is quit. */
    if(verb[0] == 'q') break;

    /* Read the object. */
    Si(v);
    a = blocks[v];
    
    /* Read the preposition. */
    Ss(prep);

    /* Read the complement. */
    Si(v);
    b = blocks[v];

    /* Ignore action if it is illegal. */
    if(a->table_loc == b->table_loc) continue;

    /* When verb is `move`, put back that are above the object `a`. */
    if(verb[0] == 'm') put_back(a);

    /* When preposition is `onto`, put back the blocks that are above the complement `b`. */
    if(prep[1] == 'n') put_back(b);

    /* Pile object `a` over complement `b`. */
    stack(a, b);
  }

  print_table(n);

  for(i = 0; i < n; i++)
    free(blocks[i]);

  return 0;
}
