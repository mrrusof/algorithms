#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

#define DEBUG 1

#define Si(n) scanf("%d", &n)
#define Sf(n) scanf("%f", &n)

#define MAX_DIM 20
#define MIN_PROFIT 1.01

int find_shortest(float edge[MAX_DIM][MAX_DIM],
		  int node_count,
		  int visited[MAX_DIM],
		  int start,
		  int curr,
		  float rate,
		  int prefix_len,
		  int **suffix) {

  int i;
  int prefix_len_incr = prefix_len + 1;
  int candidate_len;
  int **candidate_suffix;
  int shortest_len;

#if DEBUG
  printf("start, curr, rate, prefix_len = %d, %d, %f, %d\n", start, curr, rate, prefix_len);
  printf("already visited\n");
  for(i = 0; i < node_count; i++)
    printf("%2d | ", i);
  printf("\n");
  for(i = 0; i < node_count; i++)
    printf("%2d | ", visited[i]);
  printf("\n");
#endif

  if(rate * edge[curr][start] >= MIN_PROFIT) {
#if DEBUG
    printf("found candidate with length %d and rate %f\n", prefix_len_incr, rate * edge[curr][start]);
#endif
    *suffix = (int *) malloc(prefix_len_incr * sizeof(int));
    (*suffix)[prefix_len] = start;
    return prefix_len_incr;
  }

  *suffix = NULL;
  candidate_suffix = (int **) malloc(sizeof(int **));
  shortest_len = INT_MAX;

  for(i = 0; i < node_count; i++) {
    if(i != curr && !visited[i]) {
#if DEBUG
      printf("from, visit = %d, %d\n", curr, i);
#endif
      visited[i] = 1;
      candidate_len = find_shortest(edge,
				    node_count,
				    visited,
				    start,
				    i,
				    rate * edge[curr][i],
				    prefix_len_incr,
				    candidate_suffix);
      visited[i] = 0;
      if(candidate_len < shortest_len) {
  	shortest_len = candidate_len;
	free(*suffix);
	*suffix = *candidate_suffix;
	(*suffix)[prefix_len] = i;
      }
    }
  }

  free(candidate_suffix);
  return shortest_len;
}

void print_edges(float edge[MAX_DIM][MAX_DIM], int n) {
  int i, j;
  for(i = 0; i < n; i++) {
    printf("%04.5f", edge[i][0]);
    for(j = 1; j < n; j++)
      printf("\t%04.5f", edge[i][j]);
    printf("\n");
  }
}

int main() {

  int node_count;
  int i, j;
  float edge[MAX_DIM][MAX_DIM];
  int profitable_count;
  int profitable[MAX_DIM][2];
  int visited[MAX_DIM];
  int first, second;
  int candidate_len;
  int **candidate = (int **) malloc(sizeof(int **));
  int shortest_len;
  int *shortest;

  while(Si(node_count) != EOF) {

    profitable_count = 0;
    shortest_len = INT_MAX;

    /* Read edges and collect profitable. */
    for(i = 0; i < node_count; i++)
      for(j = 0; j < node_count; j++)
	if(i == j)
	  edge[i][j] = 0;
	else {
	  Sf(edge[i][j]);
	  if(edge[i][j] > 1) {
	    profitable[profitable_count][0] = i;
	    profitable[profitable_count][1] = j;
	    profitable_count++;
	  }
	}

#if DEBUG
    /* Print edges. */
    print_edges(edge, node_count);
    printf("\n");

    /* Print profitable edges. */
    for(i = 0; i < profitable_count; i++)
      printf("%d -- %f --> %d\n", profitable[i][0], edge[profitable[i][0]][profitable[i][1]], profitable[i][1]);
#endif

    /* Find shortest profitable sequence. */
    for(i = 0; i < profitable_count; i++) {
      for(j = 0; j < node_count; j++)
	visited[j] = 0;
      first = profitable[i][0];
      second = profitable[i][1];
      visited[first] = 1;
      visited[second] = 1;
      candidate_len = find_shortest(edge,
				    node_count,
				    visited,
				    first,
				    second,
				    edge[first][second],
				    2,
				    candidate);
      if(candidate_len < shortest_len) {
	shortest_len = candidate_len;
	free(shortest);
	shortest = *candidate;
	shortest[0] = first;
	shortest[1] = second;
      }
    }

    /* Print shortest profitable sequence. */
    if(shortest_len != INT_MAX) {
      printf("%d", shortest[0] + 1);
      for(i = 1; i < shortest_len; i++)
	printf(" %d", shortest[i] + 1);
      printf("\n");
    } else
      printf("no arbitrage sequence exists\n");
  }
  free(candidate);
  free(shortest);
  return 0;
}
