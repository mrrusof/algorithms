#include <stdio.h>
#include <errno.h>

#define Si(n) scanf("%d", &n)

int there_is_a_path;

#define TREE 0
#define EMPTY_TREE 1

int do_et(int s, int acc) {
  int n;
  int l;
  int r;
  int how_many_integers_did_I_read;

  scanf(" ");
  how_many_integers_did_I_read = scanf("(%d", &n);
  if(how_many_integers_did_I_read == 0) {
    scanf(" ");
    scanf(")");
    return EMPTY_TREE;
  }

  l = do_et(s, acc + n);
  r = do_et(s, acc + n);
  scanf(" ");
  scanf(")");
  if(l == EMPTY_TREE && r == EMPTY_TREE && acc + n == s)
    there_is_a_path = 1;
  return TREE;
}

int is_there_a_path_that_sums_to_s(int s) {
  there_is_a_path = 0;
  do_et(s, 0);
  return there_is_a_path;
}

int main() {
  int s;
  while(Si(s) != EOF) {
    scanf(" ");
    if(is_there_a_path_that_sums_to_s(s))
      printf("yes\n");
    else
      printf("no\n");
  }
  return 0;
}
