#include <stdio.h>

#define Si(i) scanf("%d", &i)
#define MAX_NODES 1000000

int move_up(int n, int steps, int *p) {
  while(steps > 0) {
    n = p[n];
    steps--;
  }
  return n;
}

int depth(int n, int *p) {
  int i = 0;
  while(p[n] != -1) {
    n = p[n];
    i++;
  }
  return i;
}

int most_recent_common_ancestor(int a, int b, int *p) {
  int da = depth(a, p);
  int db = depth(b, p);
  int diff;
  if(da < db) {
    diff = db - da;
    b = move_up(b, diff, p);
  } else {
    diff = da - db;
    a = move_up(a, diff, p);
  }
  while(a != b) {
    a = p[a];
    b = p[b];
  }
  return a;
}

int main() {
  int p[MAX_NODES];
  for(int i = 0; i < MAX_NODES; i++)
    p[i] = -1;
  int x, y, n, a, b;
  Si(x);
  Si(y);
  Si(n);

  while(n > 0) {
    Si(a);
    Si(b);
    p[b] = a;
    n--;
  }
  printf("%d\n", most_recent_common_ancestor(x, y, p));
  return 0;
}
