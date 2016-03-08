#include <stdio.h>

int main() {
  int b, r = 0, s, i, max_here, max_sum, n;
  int max_i, max_j, i_here;
  scanf("%d", &b);
  while(r++ < b) {
    scanf("%d", &s);
    max_j = max_i = i_here = 0;
    for(max_sum = max_here = i = 0; i < s - 1; i++) {
      scanf("%d", &n);
      max_here += n;
      if(max_here < 0) {
        max_here = 0;
        i_here = i + 1;
      }
      if(max_here > max_sum || (max_here == max_sum && i - i_here > max_j - max_i)) {
        max_sum = max_here;
        max_i = i_here;
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
