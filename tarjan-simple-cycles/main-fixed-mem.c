#include <stdio.h>

#define Si(n) scanf("%d", &n)

#define DEBUG 0
#define VERTICES 20


int edge[VERTICES][VERTICES];
typedef struct {
  int l;
  int v[VERTICES];
} stack;
stack path;
stack banned_stack;
int banned[VERTICES];
int n, s;

void push(stack *s, int n) {
  s->v[s->l++] = n;
}

int pop(stack *s) {
  return s->v[--s->l];
}

int peek(stack *s) {
  return s->v[s->l - 1];
}

int empty(stack *s) {
  if(s->l > 0) return 0;
  return 1;
}

void print_path() {
  int i;
  if(!empty(&path)) printf("%d", path.v[0] + 1);
  for(i = 1; i < path.l; i++)
    printf(" %d", path.v[i] + 1);
  printf("\n");
}

int backtrack(int v) {
  int w, found_cycle = 0;
  push(&path, v);
  push(&banned_stack, v);
  banned[v] = 1;
  for(w = s; w < n; w++) {
    if(!edge[v][w]) continue;
    if(w == s) {
      print_path();
      found_cycle = 1;
    } else if(!banned[w])
      found_cycle = backtrack(w) || found_cycle;
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
  int a, b;
  Si(n);
  while(Si(a) != EOF) {
    Si(b);
    edge[a - 1][b - 1] = 1;
  }
  for(a = 0; a < n; a++)
    banned[a] = 0;
  for(s = 0; s < n; s++) {
    backtrack(s);
    while(!empty(&banned_stack)) {
      a = pop(&banned_stack);
      banned[a] = 0;
    }
  }
  return 0;
}
