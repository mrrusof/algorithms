#include <stdio.h>
#include <limits.h>

#define VERTICES 6

int main() {
  int e[VERTICES][VERTICES] = { { -1,  7,  9, -1, -1, 14 },
				{  7, -1, 10, 15, -1, -1 },
				{  9, 10, -1, 11, -1,  2 },
				{ -1, 15, 11, -1,  6, -1 },
				{ -1, -1, -1,  6, -1,  9 },
				{ 14, -1,  2, -1,  9, -1 } };
  int orig = 0;
  int dest = 4;
  int curr = orig;
  int dist[VERTICES];
  int visited[VERTICES];
  int i;
  int cost;
  for(i = 0; i < VERTICES; i++)
    dist[i] = INT_MAX;
  dist[orig] = 0;
  for(i = 0; i < VERTICES; i++)
    visited[i] = 0;
  while(1) {
    /* If the current node is the destination, we are done. */
    if(curr == dest) break;
    /* Given that we selected the current node, its distance may not change. */
    visited[curr] = 1;
    /* The current node may change the distance to its neighbors, so we update distances. */
    for(i = 0; i < VERTICES; i++)
      if(e[curr][i] != -1 && dist[curr] + e[curr][i] < dist[i])
        dist[i] = dist[curr] + e[curr][i];
    /* Select the next node. The next node is a node that we have not visited and has the smallest cost. */
    for(cost = INT_MAX, i = 0; i < VERTICES; i++)
      if(visited[i] == 0 && dist[i] < cost) {
        cost = dist[i];
        curr = i;
      }
  }
  printf("The distance between origin %d and destination %d is %d\n", orig+1, dest+1, dist[dest]);
  return 0;
}
