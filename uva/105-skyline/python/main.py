#!/usr/bin/env python

import re

'''
soln: 1 2     3 0
in:       2 3     4 0
---------------------
      1 2 2 3     4 0

loc: 1   3
in:    2

A = [ 1, 3 ]
      0  1
N = 2
------------
I = 0

'''

def print_solution(loc, hei):
#    print 'soln =',
    for i in range(0, len(loc)):
        print loc[i], hei[i],
    print
    # print '      ',
    # for i in range(0, len(loc)):
    #     print i, ' ',
    # print

def find_curr_loc(loc, l):
    lo = 0
    hi = len(loc)
    while lo < hi:
        m = (hi + lo) / 2
        if loc[m] == l:
            return m
        elif loc[m] < l:
            lo = m + 1
        else:
            hi = m
    return lo - 1

def main():
    with open('/dev/stdin', 'rt') as f:
        l, h, r = map(int, re.split(r' +', f.readline().rstrip()))
        loc = [l, r]
        hei = [h, 0]
#        print_solution(loc, hei)
        while True:
            line = f.readline()
            if not line: break
            l, h, r = map(int, re.split(r' +', line.rstrip()))
#            print 'l, h, r =', l, h, r
#            print 'deal with left side:'
            i = find_curr_loc(loc, l)
#            print 'i =', i
            # Three cases.
            # 1. Left side is before any location.
            if i == -1:
                # Left side is a new location.
#                print 'Left side is a new location before any location.'
                i = 0
                prev_hei = 0
                loc.insert(i, l)
                hei.insert(i, h)
            # 2. Left side is at some location.
            elif loc[i] == l:
                prev_hei = hei[i]
                # Two cases.
                # 1. Left side is taller than location.
                if hei[i] < h:
                    # Left side bumps height of location.
#                    print 'Left side bumps height of location.'
                    hei[i] = h
                # 2. Left side is shorter or equal than location.
#                else:
                    # Do nothing.
#                    print 'Do nothing.'
            # 3. Left side is after some location.
            else:
                prev_hei = hei[i]
                # Two cases.
                # 1. Left side is taller than current height.
                if hei[i] < h:
                    # Left side is a new location
#                    print 'Left side is a new location.'
                    i += 1
                    loc.insert(i, l)
                    hei.insert(i, h)
                # 2. Left side is shorter or equal than current height.
#                else:
                    # Do nothing.
#                    print 'Do nothing.'
#            print_solution(loc, hei)
            # Consider each location before the right side.
#            print 'Consider each location before the right side.'
            i += 1
            while i < len(loc) and loc[i] < r:
                # Four cases.
                # 1. Change in height starts and remains above base line.
                if prev_hei >= h and hei[i] >= h:
                    # Preserve the location by skipping it.
#                    print 'Preserve the location by skipping it.'
                    prev_hei = hei[i]
                    i += 1
                # 2. Change in height starts and remains below base line.
                elif h >= prev_hei and h >= hei[i]:
                    # Remove location
#                    print 'Remove location.'
                    prev_hei = hei[i]
                    loc = loc[:i] + loc[i+1:]
                    hei = hei[:i] + hei[i+1:]
                # 3. Change in height crosses base line downwards.
                elif prev_hei > h and h > hei[i]:
                    # Base line is new height of location.
#                    print 'Base line is new height of location.'
                    prev_hei = hei[i]
                    hei[i] = h
                    i += 1
                # 4. Change in height crosses base line upwards.
                else:
                    # Preserve the location by skipping it.
#                    print 'Preserve the location by skipping it.'
                    prev_hei = hei[i]
                    i += 1
#                print_solution(loc, hei)
            # Consider the right side.
#            print 'Consider the right side.'
            # Two cases.
            # 1. Right side is after all locations.
            if i == len(loc):
                # Right side is a new location.
#                print 'Right side is a new location.'
                loc.append(r)
                hei.append(0)
            # 2. Right side is at some location.
            # elif loc[i] == r:
                # Do nothing.
            # 3. Right side is before some location.
            elif r < loc[i]:
#                print 'h =', h
#                print 'prev_hei =', prev_hei
                # Two cases.
                # 1. Right side is below or at current height.
                #if prev_hei >= h:
                    # Do nothing.
                # 2. Right side is above current height.
                if h > prev_hei:
                    # Right side is new location that goes down to current height.
                    loc.insert(i, r)
                    hei.insert(i, prev_hei)
#            print_solution(loc, hei)
        print_solution(loc, hei)

main()
