#include <stdio.h>

#define DEBUG 1

#define MAX_DIM 10
#define MAX_DIM_META (MAX_DIM + 1)
#define MAX_BOX 30

#define Si(i) scanf("%d", &i)

void print_box(int *b, int d) {
  int i;
  printf("(%3d)", b[MAX_DIM] + 1);
  for(i = 0; i < d; i++)
    printf(" %3d", b[i]);
}

int box_fits(int *x, int *y, int d) {
  int i;
  for(i = 0; i < d; i++) {
    if(x[i] >= y[i]) return 0;
  }
  return 1;
}

int le_box(int *x, int *y, int d) {
  int i;
  for(i = 0; i < d; i++) {
    if(x[i] < y[i]) return 1;
    else if(x[i] > y[i]) return 0;
  }
  return 1;
}

void copy_box(int *from, int *to, int d) {
  int i;
  for(i = 0; i < d; i++)
    to[i] = from[i];
  to[MAX_DIM] = from[MAX_DIM];
}

void merge_sort_boxes(int a[MAX_BOX][MAX_DIM_META], int tmp[MAX_BOX][MAX_DIM_META], int n, int d) {
  int m, i, j, k;
  if(n <= 1) return;
  m = n / 2;
  merge_sort_boxes(a, tmp, m, d);
  merge_sort_boxes(&a[m], tmp, n - m, d);
  for(i = k = 0, j = m; k < n; k++)
    if(i < m && j < n)
      if(le_box(a[i], a[j], d))
	 copy_box(a[i++], tmp[k], d);
      else
	 copy_box(a[j++], tmp[k], d);
    else if(i < m)
      copy_box(a[i++], tmp[k], d);
    else
      copy_box(a[j++], tmp[k], d);
  for(k = 0; k < n; k++)
    copy_box(tmp[k], a[k], d);
}

void merge_sort(int *a, int *tmp, int n) {
  int m, i, j, k;
  if(n <= 1) return;
  m = n / 2;
  merge_sort(a, tmp, m);
  merge_sort(a + m, tmp, n - m);
  for(i = k = 0, j = m; k < n; k++)
    if(i < m && j < n)
      if(a[i] <= a[j])
	tmp[k] = a[i++];
      else
	tmp[k] = a[j++];
    else if(i < m)
      tmp[k] = a[i++];
    else
      tmp[k] = a[j++];
  tmp[MAX_DIM] = a[MAX_DIM];
  copy_box(tmp, a, n);
}

int main() {
  int n, d, i, j;
  int box[MAX_BOX][MAX_DIM_META];
  int tmp[MAX_BOX][MAX_DIM_META];
  while(Si(n) != EOF) {
    Si(d);
#if DEBUG
    printf("problem\n");
    printf("%d %d\n", n, d);
#endif
    for(i = 0; i < n; i++) {
      box[i][MAX_DIM] = i;
      for(j = 0; j < d; j++) {
	Si(box[i][j]);
      }
      merge_sort(box[i], tmp[0], d);
#if DEBUG
      print_box(box[i], d);
      printf("\n");
#endif
    }
    merge_sort_boxes(box, tmp, n, d);
#if DEBUG
    printf("sorted\n");
    for(i = 0; i < n; i++) {
      print_box(box[i], d);
      printf("\n");
    }
#endif

  int longest_here[MAX_BOX][MAX_BOX];
  int longest_here_len[MAX_BOX];
  int max_len, max_i;

    for(i = 0; i < n; i++)
      longest_here_len[i] = 0;
    for(i = 0; i < n; i++)
      for(j = 0; j < n; j++)
	longest_here[i][j] = -1;

    longest_here_len[0] = 1;
    longest_here[0][0] = 0;
    for(i = 1; i < n; i++) {
      max_len = 0;
      for(j = 0; j < i; j++)
	if(box_fits(box[j], box[i], d) && longest_here_len[j] > max_len) {
	  max_i = j;
	  max_len = longest_here_len[j];
	}
      for(j = 0; j < max_len; j++) {
	longest_here[i][j] = longest_here[max_i][j];
      }
      longest_here[i][max_len] = i;
      longest_here_len[i] = max_len + 1;
    }

#ifdef DEBUG
    int k;
    printf("longest here\n");
    for(i = 0; i < n; i++) {
      if(longest_here[0][i] >= 0) {
	print_box(box[longest_here[0][i]], d);
      } else {
	printf("(XXX) XXX");
	for(k = 1; k < d; k++)
	  printf(" XXX");
      }
      for(j = 1; j < n; j++) {
	printf("\t");
	if(longest_here[j][i] >= 0) {
	  print_box(box[longest_here[j][i]], d);
	} else {
	printf("(XXX) XXX");
	for(k = 1; k < d; k++)
	  printf(" XXX");
	}
      }
      printf("\n");
    }
    printf("solution\n");
#endif

    max_len = longest_here_len[0];
    max_i = 0;
    for(i = 1; i < n; i++) {
      if(max_len < longest_here_len[i]) {
	max_len = longest_here_len[i];
	max_i = i;
      }
    }

    printf("%d\n", max_len);
    printf("%d", box[longest_here[max_i][0]][MAX_DIM] + 1);
    for(j = 1; j < max_len; j++)
      printf(" %d", box[longest_here[max_i][j]][MAX_DIM] + 1);
    printf("\n");
  }
  return 0;
}
