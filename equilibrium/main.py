'''
Find the equilibrium position of a given array.

-7 1 5 2 -4 3 0

[]
1 5 2 -4 3 0

-7
5 2 -4 3 0

-7 1
2 -4 3 0

-7 1 5
-4 3 0

-7 1 5 2
3 0
left  = 1
right = 3

i = 6
-7 1 5 2 -4
0
left  = -3
right =  0
'''

def solution(A):

    if len(A) == 0:
        return -1;

    left  = 0
    right = reduce(lambda x,y: x+y, A[1:], 0)

    if left == right: return 0;

    for i in range(1, len(A)):
        left += A[i-1];
        right -= A[i];
        if left == right:
            return i;

    return -1;
