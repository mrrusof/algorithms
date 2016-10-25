#!/usr/bin/env python

import re

def quicksort(A):
    if len(A) <= 1: return A
    L = [ i for i in A[1:] if i <= A[0] ]
    R = [ i for i in A[1:] if i >  A[0] ]
    return quicksort(L) + [A[0]] + quicksort(R)

def cmp_block(a, b, l):
    for i in range(0, l):
        if a[i] - b[0] != 0:
            return a[i] - b[0]
    return 0

def insert_sorted(A, b, d):
    lo = 0
    hi = len(A)
    while lo < hi:
        m = (hi + lo) / 2
        if cmp_block(A[m], b, d) < 0:
            lo = m + 1
        else:
            hi = m
    A.insert(lo, b)

def fits(a, b, l):
    for i in range(0, l):
        if a[i] >= b[i]:
            return False
    return True

def main():
    with open('/dev/stdin', 'rt') as f:
        n = 0
        while True:
            line = f.readline().rstrip()
            if not line: break
            n, d = map(int, re.split(r' +', line))
#            print 'n, d =', n, d
            # B: blocks
            B = []
            # Preprocessing: read, sort dimensions, and sort boxes.
            for i in range(1, n + 1):
                b = quicksort(map(int, re.split(r' +', f.readline())))
                b.append(i)
#                print ' b =', b
                insert_sorted(B, b, d)
#            for i in range(0, len(B)):
#                print ' B[%d] =' % (i+1), B[i]
            # nxt: next block in the stack
            nxt = [ None for i in range(0, len(B)) ]
            # slen: stack length
            slen = [ 1  for i in range(0, len(B)) ]
            # Stack the boxes
            for i in range(len(B) - 1, -1, -1):
                for j in range(i + 1, len(B)):
                    # If it fits and it's longer...
#                    print '(%d) %s < (%d) %s and longer =' % (i, B[i][:-1], j, B[j][:-1]),
                    if fits(B[i], B[j], d) and slen[i] < slen[j] + 1:
                        # It stacks...
                        nxt[i] = j
                        slen[i] = slen[j] + 1
#                        print 'True'
#                    else:
#                        print 'False'
            # Pick the longest
            maxlen = 0
            first = None
            for i in range(0, len(B)):
                if maxlen < slen[i]:
                    maxlen = slen[i]
                    first = i
            # Print the longest stack
            print slen[first]
            c = first
            while True:
                print B[c][-1],
                n = nxt[c]
                if not n: break
                c = n
            print
main()
