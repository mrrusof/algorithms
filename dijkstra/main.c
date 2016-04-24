#include <stdio.h>
#include <limits.h>

int main() {
  int e[6][5] = { {   7,   9,  -1,  -1,  14 },
		  {   7,  10,  15,  -1,  -1 },
		  {   9,  10,  11,  -1,   2 },
		  {  -1,  15,  11,   6,  -1 },
		  {  -1,  -1,  -1,   6,   9 },
		  {  14,  -1,   2,  -1,   9 } };
  int v = 6;
  int i, j;
  for(i = 0; i < v; i++) {
    for(j = 0; j < v - 1; j++) {
      if(i == j)
	printf("  . ");
      printf("%3d ", e[i][j]);
    }
    printf("\n");
  }

  int init = 0;                      /* initial node is node 0 */
  int curr = init;                   /* the initial node is the current node */
  int dest = 4;
  int vis[] = { 0, 0, 0, 0, 0, 0 }; /* set of visited nodes */
  int dis[v];                        /* distances to the initial node */
  for(i = 0; i < v; i++) dis[i] = INT_MAX;
  dis[0] = 0;

  while(1) {
    /* Stop if the current node is the destination node */
    if(curr == dest) break;
    /* For the current node, consider each of its unvisited neighbors. */
    for(i = 0; i < v - 1; i++) {
      if(e[curr][i] == -1) continue;
      /* calculate its tentative distance */
      if(i < curr) {
	if(dis[curr] + e[curr][i] < dis[i])
	  dis[i] = dis[curr] + e[curr][i];
      } else
	if(dis[curr] + e[curr][i] < dis[i + 1])
	  dis[i + 1] = dis[curr] + e[curr][i];
    }
    /* Mark the current node as visited */
    vis[curr] = 1;
    /* Select the unvisited node that has the shortest distance. */
    for(i = 0, j = INT_MAX; i < v; i++)
      if(vis[i] == 0 && dis[i] <= j) {
	curr = i;
	j = dis[i];
      }
  }
  printf("The distance from %d to %d is %d.\n", init+1, dest+1, dis[dest]);
  return 0;
}
