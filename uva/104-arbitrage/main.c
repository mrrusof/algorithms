#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

#define DEBUG 0

#define Si(n) scanf("%d", &n)
#define Sf(n) scanf("%f", &n)

#define MAX_DIM 20
#define MIN_PROFIT 1.01

float edge[MAX_DIM][MAX_DIM];
int visited[MAX_DIM];
int node_count, first;
float outgoing_overestimated_profit[MAX_DIM];
float incoming_overestimated_profit[MAX_DIM];

int find_shortest(int curr,
		  float rate,
		  float untraversed_profit_rates,
		  int prefix_len,
		  int **suffix) {

  int i;
  int next;
  int next_prefix_len = prefix_len + 1;
  int candidate_len;
  int **candidate_suffix;
  int shortest_len;

#if DEBUG
  printf("first, curr, rate, u_p_r, prefix_len = %d, %d, %f, %f, %d\n", first, curr, rate, untraversed_profit_rates, prefix_len);
  printf("already visited\n");
  for(i = 0; i < node_count; i++)
    printf("%2d | ", i);
  printf("\n");
  for(i = 0; i < node_count; i++)
    printf("%2d | ", visited[i]);
  printf("\n");
#endif

  if(rate * edge[curr][first] >= MIN_PROFIT) {
#if DEBUG
    printf("found candidate with length %d and rate %f\n", next_prefix_len, rate * edge[curr][first]);
#endif
    *suffix = (int *) malloc(next_prefix_len * sizeof(int));
    (*suffix)[prefix_len] = first;
    return next_prefix_len;
  }

  *suffix = NULL;
  candidate_suffix = (int **) malloc(sizeof(int **));
  shortest_len = INT_MAX;

  for(next = 0; next < node_count; next++) {
    if(next == curr || visited[next]) continue;
    float forfeited_profit = outgoing_overestimated_profit[curr] * incoming_overestimated_profit[next];
    float rate_for_next = rate * edge[curr][next];
    float untraversed_profit_rates_for_next = untraversed_profit_rates / forfeited_profit;
    float overestimated_profit = rate_for_next * untraversed_profit_rates_for_next;
    if(overestimated_profit < MIN_PROFIT) continue;
#if DEBUG
    printf("from, visit = %d, %d\n", curr, next);
#endif
    visited[next] = 1;
    candidate_len = find_shortest(next,
				  rate_for_next,
				  untraversed_profit_rates_for_next,
				  next_prefix_len,
				  candidate_suffix);
    visited[next] = 0;
    if(candidate_len < shortest_len) {
      shortest_len = candidate_len;
      free(*suffix);
      *suffix = *candidate_suffix;
      (*suffix)[prefix_len] = next;
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

  int i, j;
  int profitable[MAX_DIM][2];
  int profitable_count;
  float untraversed_profit_rates;
  int second;
  int candidate_len;
  int **candidate = (int **) malloc(sizeof(int **));
  int shortest_len;
  int *shortest;

  while(Si(node_count) != EOF) {

    /* Set initial state for given input. */
    profitable_count = 0;
    untraversed_profit_rates = 1.0;
    shortest_len = INT_MAX;
    for(i = 0; i < node_count; i++) {
      outgoing_overestimated_profit[i] = 1;
      incoming_overestimated_profit[i] = 1;
    }
      

    /* Read edges, collect profitable, and overestimate outgoing/incoming profit. */
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
	    if(outgoing_overestimated_profit[i] < edge[i][j])
	      outgoing_overestimated_profit[i] = edge[i][j];
	    if(incoming_overestimated_profit[j] < edge[i][j])
	      incoming_overestimated_profit[j] = edge[i][j];
	  }
	}

    for(i = 0; i < node_count; i++) {
      untraversed_profit_rates *= outgoing_overestimated_profit[i];
      untraversed_profit_rates *= incoming_overestimated_profit[i];
    }

#if DEBUG
    /* Print edges. */
    print_edges(edge, node_count);
    printf("\n");

    /* Print profitable edges. */
    for(i = 0; i < profitable_count; i++)
      printf("%d -- %f --> %d\n", profitable[i][0], edge[profitable[i][0]][profitable[i][1]], profitable[i][1]);

    /* Print overestimated profits. */
    for(i = 0; i < node_count; i++) {
      if(outgoing_overestimated_profit[i] > 1)
	printf("%d-- %f -->\n", i, outgoing_overestimated_profit[i]);
    }
    for(i = 0; i < node_count; i++) {
      if(incoming_overestimated_profit[i] > 1)
	printf("-- %f --> %d\n", incoming_overestimated_profit[i], i);
    }
#endif

    /* Find shortest profitable sequence. */
    for(i = 0; i < profitable_count; i++) {
      for(j = 0; j < node_count; j++)
	visited[j] = 0;
      first = profitable[i][0];
      second = profitable[i][1];
      visited[first] = 1;
      visited[second] = 1;
      float forfeited_profit = outgoing_overestimated_profit[first] * incoming_overestimated_profit[second];
      float untraversed_profit_rates_for_second = untraversed_profit_rates / forfeited_profit;
      candidate_len = find_shortest(second,
				    edge[first][second],
				    untraversed_profit_rates_for_second,
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
