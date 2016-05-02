#include <stdio.h>
#include <limits.h>

#define DEBUG 0
#define FRESH -2
#define NOTHING 0

#define Si(n) scanf("%d", &n)
#define Sf(n) scanf("%f", &n)

#define MAX_DIM 20
#define MIN_PROFIT 1.01

float edge[MAX_DIM][MAX_DIM];
int node_count;
int paths[MAX_DIM][MAX_DIM][MAX_DIM + 1];
float rates[MAX_DIM][MAX_DIM][MAX_DIM + 1];

/* Any of the most profitable paths of length `l` from `a` to `b`. */
void f(int a, int b, int l) {
  int i;
  float rate;
  if(paths[a][b][l] != FRESH) return;
  if(l == 1) {
    if(a == b) {
      paths[a][b][l] = NOTHING;
      rates[a][b][l] = NOTHING;
    } else {
      paths[a][b][l] = b;
      rates[a][b][l] = edge[a][b];
    }
    return;
  }
  rates[a][b][l] = NOTHING;
  paths[a][b][l] = NOTHING;
  for(i = 0; i < node_count; i++) {
    f(i, b, l - 1);
    if(a == i) continue;
    rate = edge[a][i] * rates[i][b][l - 1];
    if(rates[a][b][l] < rate) {
      rates[a][b][l] = rate;
      paths[a][b][l] = i;
    }
  }
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

  int i, j, k;

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
	for(k = 0; k < node_count; k++) {
	  paths[i][j][k] = FRESH;
	  rates[i][j][k] = FRESH;
	}

    /* Consider cycles in ascending length. */
    int stop = 0;
    for(i = 2; i <= node_count && stop == 0; i++) {
      for(j = 0; j < node_count && stop == 0; j++) {
#if DEBUG
	printf("stop = %d\n", stop);
	printf("f(%d, %d, %d)\n", j, j, i);
#endif
	f(j, j, i);
	if(rates[j][j][i] >= MIN_PROFIT)
	  stop = 1;
      }
    }

    /* Print answer. */
    if(stop) {
      int pivot = j - 1;
      int len = i - 1;
      int curr = pivot;
      while(len > 0) {
	printf("%d ", curr + 1);
	curr = paths[curr][pivot][len--];
      }
      printf("%d\n", pivot + 1);
    } else {
      printf("no arbitrage sequence exists\n");
    }

  }

  return 0;
}
