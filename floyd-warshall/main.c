#include <stdio.h>
#include <limits.h>

#define Si(n) scanf("%d", &n);

#define V 20
#define WOW_THIS_IS_LARGE (INT_MAX / 2)

int min(int x, int y) {
  if(x > y) return y;
  return x;
}

int main() {
  int n, i, j, w, k;
  int dist[V + 1][V][V];
  Si(n);
  for(i = 0; i < n; i++)
    for(j = 0; j < n; j++) {
      if(i == j)
	dist[0][i][j] = WOW_THIS_IS_LARGE;
      else {
	Si(w);
	if(w == 0)
	  dist[0][i][j] = WOW_THIS_IS_LARGE;
	else
	  dist[0][i][j] = w;
      }
    }
  for(k = 1; k <= n; k++)
    for(i = 0; i < n; i++)
      for(j = 0; j < n; j++)
	dist[k][i][j] = min(dist[k - 1][i][j], dist[k - 1][i][k - 1] + dist[k - 1][k - 1][j]);
  for(k = 0; k <= n; k++) {
    printf("     ");
    for(j = 1; j <= n; j++)
      printf("%3d ", j);
    printf("\n    ");
    for(j = 1; j <= n; j++)
      printf("----");
    printf("\n");
    for(i = 0; i < n; i++) {
      printf("%3d| ", i + 1);
      for(j = 0; j < n; j++) {
	if(dist[k][i][j] == WOW_THIS_IS_LARGE)
	  printf("  . ");
	else
	  printf("%3d ", dist[k][i][j]);
    }
      printf("\n");
    }
    printf("\n");
  }
  return 0;
}
