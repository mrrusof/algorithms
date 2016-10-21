#!/usr/bin/env python

# For the set of natural numbers between X and Y inclusive, report the
# longest collatz sequence.

import re

def min(x,y):
    if x < y:
        return x
    else:
        return y

def max(x,y):
    if x < y:
        return y
    else:
        return x

def collatz_len(n):
    if n == 1:
        return 1
    elif n & 1 == 1:
        return collatz_len(3*n+1) + 1
    else:
        return collatz_len(n/2) + 1

with open('/dev/stdin', 'rt') as f:
    line = f.readline()
    while line:
        i, j = map(int, re.split(r' +', line))
        ii = min(i,j)
        jj = max(i,j)
        m = 0
        while ii <= jj:
            m = max(m, collatz_len(ii))
            ii += 1
        print i, j, m
        line = f.readline()
