#include <stdio.h>

/*
  Example

  program sort(input,output);
  var
  a,b,c : integer;
  begin
    readln(a,b,c);
    if a < b then
      if b < c then
        writeln(a,b,c)
      else if a < c then
        writeln(a,c,b)
      else
        writeln(c,a,b)
    else
      if a < c then
        writeln(b,a,c)
      else if b < c then
        writeln(b,c,a)
      else
        writeln(c,b,a)
  end.

  Permutations that correspond to the example.

  a b c
  a c b
  c a b
  b a c
  b c a
  c b a

  My output.

  program sort(input,output);
  var
  a,b,c : integer;
  begin
    readln(a,b,c);
    if a < b then
      if b < c then
        writeln(a,b,c)
      else if a < c
        writeln(a,c,b)
      else
        writeln(c,a,b)
    else
      if c < b then
        writeln(c,b,a)
      else if c < a then
        writeln(b,c,a)
      else
        writeln(b,a,c)
  end.

  Permutations that correspond to my output.

  a b c
  a c b
  c a b
  c b a
  b c a
  b a c

  The sequence of permutations that correspond to my output is a Johnson-Trotter sequence.

 */

#define Si(n) scanf("%d", &n)
#define MAX 8

int D[MAX];

void swap_with_next(char *s, int i) {
  char t = s[i];
  s[i] = s[i + 1];
  s[i + 1] = t;
}

void print_vars(char *vars, int n) {
  int i;
  printf("%c", vars[0]);
  for(i = 1; i < n; i++)
    printf(",%c", vars[i]);
}

void writeln(char *vars, int n) {
  printf("    writeln(");
  print_vars(vars, n);
  printf(")\n");
}

int jt(char *vars, int l, int n) {
  int i;
  int o = 0;
  if(l < n)
    o = jt(vars, l + 1, n);
  if(D[l]) {
    for(i = l - 1; 0 < i; i--) {
      swap_with_next(vars, o + i - 1);
      writeln(vars, n);
      if(l < n)
	o = jt(vars, l + 1, n);
    }
    o++;
  } else {
    for(i = 0; i < l - 1; i++) {
      swap_with_next(vars, o + i);
      writeln(vars, n);
      if(l < n)
	o = jt(vars, l + 1, n);
    }
  }
  D[l] = !D[l];
  return o;
}

void johnson_trotter(char *_vars, int n) {
  int i;
  char vars[MAX + 1];
  for(i = 0; i < MAX; i++)
    D[i] = 1;
  for(i = 0; i < n; i++)
    vars[i] = _vars[i];
  vars[n] = '\0';
  writeln(vars, n);
  jt(vars, 2, n);
}

int main() {
  char * vars = "abcdefgh";
  int m;
  int n;
  int i;
  Si(m);
  while(m-- > 0) {
    Si(n);
    printf("program sort(input,output);\nvar\n");
    print_vars(vars, n);
    printf(" : integer;\nbegin\n  readln(");
    print_vars(vars, n);
    printf(");\n");
    johnson_trotter(vars, n);
    printf("end.\n");
  }
  return 0;
}
