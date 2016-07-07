#include <stdio.h>

#define Si(n) scanf("%d", &n)

#define MAX 100

int main() {
  int n;
  int input[MAX][MAX];
  int i, j;
  int sum[MAX][MAX];
  int ii, jj, row_sum, max;
  Si(n);
  for(i = 0; i < n; i++)
    for(j = 0; j < n; j++)
      Si(input[i][j]);
  max = 0;
  for(i = 0; i < n; i++)
    for(j = 0; j < n; j++) {
      sum[i][j] = input[i][j];
      if(sum[i][j] > max)
	max = sum[i][j];
      for(jj = j+1; jj < n; jj++) {
	sum[i][jj] = sum[i][jj-1] + input[i][jj];
	if(sum[i][jj] > max)
	  max = sum[i][jj];
      }
      for(ii = i+1; ii < n; ii++) {
	row_sum = input[ii][j];
	sum[ii][j] = sum[ii-1][j] + row_sum;
	if(sum[ii][j] > max)
	  max = sum[ii][j];
	for(jj = j+1; jj < n; jj++) {
	  row_sum += input[ii][jj];
	  sum[ii][jj] = sum[ii-1][jj] + row_sum;
	  if(sum[ii][jj] > max)
	    max = sum[ii][jj];
	}
      }
    }
  printf("%d\n", max);
  return 0;
}
