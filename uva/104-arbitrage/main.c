#include <stdio.h>
#include <limits.h>

#define DEBUG 0
#define FRESH -1
#define NOTHING 0

#define Si(n) scanf("%d", &n)
#define Sf(n) scanf("%f", &n)

#define MAX_DIM 20
#define MIN_PROFIT 1.01

float edge[MAX_DIM][MAX_DIM];
int node_count;
int paths[MAX_DIM][MAX_DIM][MAX_DIM + 1];
float rates[MAX_DIM][MAX_DIM][MAX_DIM + 1];

/* Any of the most profitable paths of length `l` from `a` to `t` that we have not considered. */
void f(int a, int r, int l) {
#if DEBUG
  int i;
  for(i = 0; i < node_count - l; i++)
    printf(" ");
  printf("f(%d, %d, %d) =\n", a, r, l);
#endif
  int b;
  float rate;
  if(paths[a][r][l] != FRESH) {
#if DEBUG
    for(i = 0; i < node_count - l; i++)
      printf(" ");
    printf("%f\n", rates[a][r][l]);
#endif
    return;
  }
  if(l == 1) {
    if(edge[a][r] == NOTHING) {
      paths[a][r][1] = NOTHING;
      rates[a][r][1] = NOTHING;
    } else {
      paths[a][r][1] = r;
      rates[a][r][1] = edge[a][r];
    }
#if DEBUG
  for(i = 0; i < node_count - l; i++)
    printf(" ");
  printf("%f (new)\n", rates[a][r][l]);
#endif
    return;
  }
  rates[a][r][l] = NOTHING;
  paths[a][r][l] = NOTHING;
  for(b = r; b < node_count; b++) {
    if(a == b) continue;
    f(b, r, l - 1);
    rate = edge[a][b] * rates[b][r][l - 1];
    if(rates[a][r][l] < rate) {
      rates[a][r][l] = rate;
      paths[a][r][l] = b;
    }
  }
#if DEBUG
  for(i = 0; i < node_count - l; i++)
    printf(" ");
  printf("%f (new)\n", rates[a][r][l]);
#endif
}

void print_edges(float edge[MAX_DIM][MAX_DIM], int n) {
  int i, j;
  for(i = 0; i < n; i++) {
    printf("%9.5f", edge[i][0]);
    for(j = 1; j < n; j++)
      printf("\t%9.5f", edge[i][j]);
    printf("\n");
  }
}

int main() {

  int i, j, l;

  while(Si(node_count) != EOF) {

    /* Read edges. */
    for(i = 0; i < node_count; i++)
      for(j = 0; j < node_count; j++)
	if(i == j)
	  edge[i][j] = NOTHING;
	else
	  Sf(edge[i][j]);

#if DEBUG
    /* Print edges. */
    print_edges(edge, node_count);
    printf("\n");
#endif

    /* Reset paths and rates. */
    for(i = 0; i < node_count; i++)
      for(j = 0; j < node_count; j++)
	for(l = 0; l <= node_count; l++) {
	  paths[i][j][l] = FRESH;
	  rates[i][j][l] = FRESH;
	}

    /* Consider cycles in ascending length. */
    int stop = 0;
    int r;
    for(l = 2; l <= node_count && stop == 0; l++) {
#if DEBUG
      printf("l = %d\n", l);
#endif
      for(r = 0; r < node_count - l + 1 && stop == 0; r++) {
#if DEBUG
	printf("r = %d\n", r);
	printf("node_count = %d\n", node_count);
	printf("node_count - l = %d\n", node_count - l);
	printf("node_count - l + 1 = %d\n", node_count - l + 1);
#endif
	f(r, r, l);
	if(rates[r][r][l] >= MIN_PROFIT)
	  stop = 1;
#if DEBUG
	printf("stop = %d\n", stop);
#endif
      }
    }

    /* Print answer. */
    if(stop) {
      int first = r - 1;
      int len = l - 1;
      int curr = first;
      while(len > 0) {
	printf("%d ", curr + 1);
	curr = paths[curr][first][len--];
      }
      printf("%d\n", first + 1);
    } else {
      printf("no arbitrage sequence exists\n");
    }

  }

  return 0;
}
