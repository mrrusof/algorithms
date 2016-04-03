#include <stdio.h>

#define DEBUG 0

#define MAX_DIM 10
#define MAX_BOX 30

#define Si(i) scanf("%d", &i)

typedef struct box {
  int d[MAX_DIM];
  int original_position;
} box;

void merge_sort_ints(int *a, int n) {
  int i, j, k;
  int m = n / 2;
  int tmp[n];
  if(n <= 1)
    return;
  merge_sort_ints(a, m);
  merge_sort_ints(a + m, n - m);
  for(k = i = 0, j = m; k < n; k++)
    if(i < m && j < n)
      if(a[i] <= a[j])
	tmp[k] = a[i++];
      else
	tmp[k] = a[j++];
    else if(i < m)
      tmp[k] = a[i++];
    else
      tmp[k] = a[j++];
  for(i = 0; i < n; i++)
    a[i] = tmp[i];
}

int le_box(box a, box b, int d) {
  int i;
  for(i = 0; i < d; i++) {
    if(a.d[i] < b.d[i])
      return 1;
    else if(a.d[i] > b.d[i])
      return 0;
  }
  return 1;
}

void copy_box(box *to, box *from, int d) {
  int i = 0;
  to->original_position = from->original_position;
  for(i = 0; i < d; i++)
    to->d[i] = from->d[i];
}

void merge_sort_boxes(box *a, int n, int d) {
  int i, j, k;
  int m = n / 2;
  box tmp[n];
  if(n <= 1)
    return;
  merge_sort_boxes(a, m, d);
  merge_sort_boxes(a + m, n - m, d);
  for(k = i = 0, j = m; k < n; k++)
    if(i < m && j < n)
      if(le_box(a[i], a[j], d))
	copy_box(tmp + k , a + i++, d);
      else
	copy_box(tmp + k, a + j++, d);
    else if(i < m)
      copy_box(tmp + k , a + i++, d);
    else
      copy_box(tmp + k, a + j++, d);
  for(i = 0; i < n; i++)
    copy_box(a + i, tmp + i, d);
}

int box_fits(box *this, box *into_this, int d) {
  int i;
  for(i = 0; i < d; i++)
    if(this->d[i] >= into_this->d[i])
      return 0;
  return 1;
}

void print_position(box b) {
  printf("(%3d) ", b.original_position);
}

void print_box(box b, int d) {
  int i;
  printf("(");
  printf("%3d", b.d[0]);
  for(i = 1; i < d; i++)
    printf(", %3d", b.d[i]);
  printf(")");
}

void print_blank_box(int d) {
  int i;
  printf("     ");
  for(i = 1; i < d; i++)
    printf("     ");
}

void print_sep_box(int d) {
  int i;
  printf("-----");
  for(i = 1; i < d; i++)
    printf("-----");
}

int main() {
  int n, d, i, j;
  box box[MAX_BOX];
  int longest_here_parent[MAX_BOX];
  int longest_here_length[MAX_BOX];
  int longest_last;
  int longest_length;
  int longest[MAX_BOX];
  while(Si(n) != EOF) {
    Si(d);
#if DEBUG
    printf("problem %d %d\n", n, d);
#endif
    for(i = 0; i < n; i++) {
      box[i].original_position = i + 1;
      for(j = 0; j < d; j++)
	Si(box[i].d[j]);
      merge_sort_ints(box[i].d, d);
    }
#if DEBUG
    printf("sorted dimensions\n");
    for(i = 0; i < n; i++) {
      print_position(box[i]);
      print_box(box[i], d);
      printf("\n");
    }
#endif
    merge_sort_boxes(box, n, d);
#if DEBUG
    printf("sorted boxes\n");
    for(i = 0; i < n; i++) {
      print_position(box[i]);
      print_box(box[i], d);
      printf("\n");
    }
#endif
    for(i = 0; i < n; i++) {
      longest_here_parent[i] = -1;
      longest_here_length[i] = 1;
    }
    longest_last = 0;
    longest_length = 1;
    for(i = 0; i < n; i++)
      for(j = 0; j < i; j++)
	if(box_fits(box + j, box + i, d) &&
	   longest_here_length[i] < longest_here_length[j] + 1) {
	  longest_here_parent[i] = j;
	  longest_here_length[i] = longest_here_length[j] + 1;
	  if(longest_length < longest_here_length[i]) {
	    longest_last = i;
	    longest_length = longest_here_length[i];
	  }
	}
#if DEBUG
    printf("longest here\n");
    int longest_table[MAX_BOX][MAX_BOX];
    for(i = 0; i < n; i++)
      for(j = 0; j < n; j++)
	longest_table[i][j] = -1;
    for(i = 0; i < n; i++) {
      j = i;
      while(longest_here_length[j] != 1) {
	longest_table[i][longest_here_length[j] - 1] = j;
	j = longest_here_parent[j];
      }
      longest_table[i][0] = j;
    }
    print_box(box[0], d);
    for(i = 1; i < n; i++) {
      printf(" | ");
      print_box(box[i], d);
    }
    printf("\n");
    print_sep_box(d);
    for(i = 1; i < n; i++) {
      printf("---");
      print_sep_box(d);
    }
    for(j = 0; j < n; j++) {
      printf("\n");
      if(longest_table[0][j] != -1)
	print_box(box[longest_table[0][j]], d);
      else
	print_blank_box(d);
      for(i = 1; i < n; i++) {
	printf(" | ");
	if(longest_table[i][j] != -1)
	  print_box(box[longest_table[i][j]], d);
	else
	  print_blank_box(d);
      }
    }
    printf("\n");
    printf("solution\n");
#endif
    for(i = longest_last, j = longest_length - 1; longest_here_length[i] != 1; j--) {
      longest[j] = i;
      i = longest_here_parent[i];
    }
    longest[j] = i;
    printf("%d\n", longest_length);
    printf("%d", box[longest[0]].original_position);
    for(i = 1; i < longest_length; i++)
      printf(" %d", box[longest[i]].original_position);
    printf("\n");
  }
  return 0;
}
