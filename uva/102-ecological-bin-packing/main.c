#include <stdio.h>

#define MAX_COLOR 3

#define B 0
#define G 1
#define C 2
#define Moves(x,y,z) curr = b[1][x] + b[2][x] + b[0][y] + b[2][y] + b[0][z] + b[1][z]
#define SelectMin(i) if(curr < min) { min_i = i; min = curr; }

#define Si(i) scanf("%d", &i)

int main() {
  int bin, color, n, curr, min, min_i;
  int b[MAX_COLOR][MAX_COLOR];
  char config_labels[][4] = {
    "BCG",
    "BGC",
    "CBG",
    "CGB",
    "GBC",
    "GCB"
  };

  while(Si(n) != EOF) {
    b[0][0] = n;
    for(color = 1; color < MAX_COLOR; color++) {
      Si(n);
      b[0][color] = n;
    }
    for(bin = 1; bin < MAX_COLOR; bin++)
      for(color = 0; color < MAX_COLOR; color++) {
	Si(n);
	b[bin][color] = n;
      }

    Moves(B, C, G);
    min = curr;
    min_i = 0;
    Moves(B, G, C);
    SelectMin(1);
    Moves(C, B, G);
    SelectMin(2);
    Moves(C, G, B);
    SelectMin(3);
    Moves(G, B, C);
    SelectMin(4);
    Moves(G, C, B);
    SelectMin(5);

    printf("%s %d\n", config_labels[min_i], min);
  }

  return 0;
}
