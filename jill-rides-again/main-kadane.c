#include <stdio.h>

int main() {
  int b, r = 0, s, i, curr_sum, curr_i, max_sum, max_i, max_j, n;
  scanf("%d", &b);
  while(r++ < b) {
    scanf("%d", &s);
    for(max_j = max_i = max_sum = curr_i = curr_sum = i = 0; i < s - 1; i++) {
      scanf("%d", &n);
      curr_sum += n;
      if(curr_sum < 0) {
	curr_sum = 0;
	curr_i = i + 1;
      }
      if(curr_sum > max_sum || (curr_sum == max_sum && i - curr_i > max_j - max_i)) {
	max_sum = curr_sum;
	max_i = curr_i;
	max_j = i;
      }
    }
    if(max_sum == 0) {
      printf("Route %d has no nice parts\n", r);
    } else {
      printf("The nicest part of route %d is between stops %d and %d\n", r, max_i+1, max_j+2);
    }
  }
  return 0;
}
