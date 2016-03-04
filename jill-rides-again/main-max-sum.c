#include <stdio.h>

int main() {
  int b, r = 0, s, i, curr_sum, max_sum, n;
  scanf("%d", &b);
  while(r++ < b) {
    scanf("%d", &s);
    for(max_sum = curr_sum = i = 0; i < s - 1; i++) {
      scanf("%d", &n);
      curr_sum += n;
      if(curr_sum < 0) curr_sum = 0;
      if(curr_sum > max_sum) max_sum = curr_sum;
    }
    if(max_sum == 0) {
      printf("Route %d has no nice parts\n", r);
    } else {
      printf("The nicest part of route %d has niceness %d\n", r, max_sum);
    }
  }
}
