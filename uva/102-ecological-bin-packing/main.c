#include <stdio.h>
#include <limits.h>

/*#define DEBUG 1 */

#define MAX_COLOR 3
#define CONFIGS 6
#define B 0
#define G 1
#define C 2

#define Si(i) scanf("%d", &i)

int main() {
  int bin, color, i, curr, min, min_i;
  int b[MAX_COLOR][MAX_COLOR];
  int config_indices[CONFIGS][MAX_COLOR] = {
    {B, C, G},
    {B, G, C},
    {C, B, G},
    {C, G, B},
    {G, B, C},
    {G, C, B}
  };
  char config_labels[CONFIGS][MAX_COLOR] = {
    {'B', 'C', 'G'},
    {'B', 'G', 'C'},
    {'C', 'B', 'G'},
    {'C', 'G', 'B'},
    {'G', 'B', 'C'},
    {'G', 'C', 'B'}
  };

  while(Si(i) != EOF) {
    b[0][0] = i;
    for(color = 1; color < MAX_COLOR; color++) {
      Si(i);
      b[0][color] = i;
    }
    for(bin = 1; bin < MAX_COLOR; bin++)
      for(color = 0; color < MAX_COLOR; color++) {
	Si(i);
	b[bin][color] = i;
      }
#if DEBUG
    printf("     1          2          3\n");
    printf("-------------------------------\n");
    printf("  B  G  C |  B  G  C |  B  G  C\n");
    printf("-------------------------------\n");
    for(bin = 0; bin < MAX_COLOR; bin++) {
      for(color = 0; color < MAX_COLOR; color++)
	printf(" %2d", b[bin][color]);
      printf("  ");
    }
    printf("\n");
#endif

  /*
    B: 0
    G: 1
    C: 2
   */

  /*
  BCG
  curr = 0;
  curr += b[1][B] + b[2][B];
  curr += b[0][C] + b[2][C];
  curr += b[0][G] + b[1][G];

  BGC
  curr = 0;
  curr += b[1][B] + b[2][B];
  curr += b[0][G] + b[2][G];
  curr += b[0][C] + b[1][C];

  CBG
  curr = 0;
  curr += b[1][C] + b[2][C];
  curr += b[0][B] + b[2][B];
  curr += b[0][G] + b[1][G];

  CGB
  curr = 0;
  curr += b[1][C] + b[2][C];
  curr += b[0][B] + b[2][B];
  curr += b[0][G] + b[1][G];
  */

    min = INT_MAX;
    for(i = 0; i < CONFIGS; i++) {
      curr  = b[1][config_indices[i][0]] + b[2][config_indices[i][0]];
      curr += b[0][config_indices[i][1]] + b[2][config_indices[i][1]];
      curr += b[0][config_indices[i][2]] + b[1][config_indices[i][2]];
      if(curr < min) {
	min_i = i;
	min = curr;
      }
    }

    printf("%c%c%c %d\n",
	   config_labels[min_i][0],
	   config_labels[min_i][1],
	   config_labels[min_i][2],
	   min);
  }

  return 0;
}
