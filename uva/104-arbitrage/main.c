#include <stdio.h>

#define V 20
#define MIN_PROFIT 1.01

#define Si(n) scanf("%d", &n)
#define Sf(n) scanf("%f", &n)

void print_path(int s, int t, int l, int succ[V][V][V]) {
  if(l == 0)
    printf("%d\n", s + 1);
  else {
    printf("%d ", s + 1);
    print_path(succ[l][s][t], t, l - 1, succ);
  }
}

void set_to_zero(int n, float m[V][V]) {
  int i, j;
  for(i = 0; i < n; i++)
    for(j = 0; j < n; j++)
      m[i][j] = 0;
}

void S(int n, float rate[V][V]) {
  float benefit[V][V][V];
  int succ[V][V][V];
  int l, i, j, k;
  for(i = 0; i < n; i++)
    for(j = 0; j < n; j++)
      benefit[1][i][j] = rate[i][j];
  for(l = 2; l <= n; l++) {
    set_to_zero(n, benefit[l]);
    for(i = 0; i < n; i++)
      for(j = 0; j < n; j++)
	for(k = 0; k < n; k++) {
	  if(benefit[l][i][j] < rate[i][k] * benefit[l - 1][k][j]) {
	    benefit[l][i][j] = rate[i][k] * benefit[l - 1][k][j];
	    succ[l][j][i] = k;
	    if(i == j && benefit[l][i][j] >= MIN_PROFIT) {
	      print_path(i, i, l, succ);
	      return;
	    }
	  }
	}
  }
  printf("no arbitrage sequence exists\n");
}

int main() {
  int n, i, j;
  float r;
  float rate[V][V];
  while(Si(n) != EOF) {
    for(i = 0; i < n; i++)
      for(j = 0; j < n; j++) {
	if(i == j) {
	  rate[i][i] = 0;
	  continue;
	}
	Sf(r);
	rate[i][j] = r;
      }
    S(n, rate);
  }
  return 0;
}
