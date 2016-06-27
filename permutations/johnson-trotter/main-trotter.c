#include <stdio.h>

#define Ss(s) scanf("%s", s)
#define MAX_LEN 30

int first;
int p[MAX_LEN + 1]; /* p[k] is position of k */
int d[MAX_LEN + 1]; /* d[k] is direction of k, d[k] = {1,0} is {right,left} */

void trotter(char *x, int n) { /* x = " hola" */
  /* Variables not in the original algorithm. */
  int i;
  int nn = n;

  int k;
  int q;
  char t;

  if(first) {
  INITIALIZE:
    for(k = 2; k <= n; k++) {
      p[k] = 0;
      d[k] = 1;
    }
    first = 0;
  }

  k = 0;

 INDEX:
  q = p[n] + d[n];
  p[n] = q;
  if(q == n) {
    d[n] = -1;
    goto LOOP;
  }
  if(q != 0)
    goto TRANSPOSE;
  d[n] = 1;
  k++;

 LOOP:
  if(n > 2) {
    n--;
    goto INDEX;
  }

 FINAL_EXIT:
  q = 1;
  first = 1;

 TRANSPOSE:
  q = q + k - 1; /* Adjust index by subtracting 1 */
  t = x[q];
  x[q] = x[q + 1];
  x[q + 1] = t;

  /* Code not in the original algorithm */
  for(i = 2; i <= nn; i++) {
    printf("%5d  ", p[i]);
  }
  printf("%5d  %5d  ", k, q);
}

int main() {
  int slen;
  char s[MAX_LEN];
  Ss(s);
  for(slen = 0; s[slen] != '\0'; slen++);

  for(first = 2; first <= slen; first++)
    printf("p[%2d]  ", first);
  printf("    k      q\n");

  first = 1;
  trotter(s, slen);
  printf("%s\n", s);
  while(first == 0) {
    trotter(s, slen);
    printf("%s\n", s);
  }
  return 0;
}
