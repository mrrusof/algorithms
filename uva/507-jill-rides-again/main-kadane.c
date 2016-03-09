#include <stdio.h>

int main() {
  int b, r = 0, s, i, max_here, max_sum, n;
  scanf("%d", &b);
  while(r++ < b) {
    scanf("%d", &s);
    for(max_sum = max_here = i = 0; i < s - 1; i++) {
      scanf("%d", &n);
      max_here += n;
      if(max_here < 0) {
        max_here = 0;
      }
      if(max_here > max_sum) {
        max_sum = max_here;
      }
    }
    if(max_sum == 0) {
      printf("Route %d has no nice parts\n", r);
    } else {
      printf("The nicest part of route %d has niceness %d\n", r, max_sum);
    }
  }
  return 0;
}
