#include <stdio.h>

#define V 20
#define MIN_PROFIT 1.01

#define Si(n) scanf("%d", &n)
#define Sf(n) scanf("%f", &n)

void print_path(int s, int t, int l, int succ[V+1][V][V]) {
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

void R(int n, float rate[V][V], float benefit[V+1][V][V], int succ[V+1][V][V]) {
  int l, i, j, k;
  set_to_zero(n, benefit[0]);
  for(i = 0; i < n; i++)
    benefit[0][i][i] = 1;
  set_to_zero(n, benefit[1]);
  for(l = 2; l <= n; l++) {
    set_to_zero(n, benefit[l]);
    for(i = 0; i < n; i++)
      for(j = i + 1; j < n; j++) {
	for(k = i; k < n; k++)
	  if(benefit[l - 1][j][i] < rate[j][k] * benefit[l - 2][k][i]) {
	    benefit[l - 1][j][i] = rate[j][k] * benefit[l - 2][k][i];
	    succ[l - 1][j][i] = k;
	  }
	if(benefit[l][i][i] < rate[i][j] * benefit[l - 1][j][i]) {
	  benefit[l][i][i] = rate[i][j] * benefit[l - 1][j][i];
	  succ[l][i][i] = j;
	}
	if(benefit[l][i][i] >= MIN_PROFIT) {
	  print_path(i, i, l, succ);
	  return;
	}
      }
  }
  printf("no arbitrage sequence exists\n");
}

int main() {
  int n, i, j;
  float r;
  float rate[V][V];
  float benefit[V+1][V][V];
  int succ[V+1][V][V];
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
    R(n, rate, benefit, succ);
  }
  return 0;
}
