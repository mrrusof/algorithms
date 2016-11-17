#!/usr/bin/env python

def depth(l):
    d = 1
    for e in l:
        if type(e) == list:
            d = max(d, depth(e) + 1)
    return d

def do_et(l, d):
    acc = 0
    for e in l:
        if type(e) == list:
            acc += do_et(e, d - 1)
        else:
            acc += e * d
    return acc

def nlws(l):
    d = depth(l)
    return do_et(l, d)

test_cases = [
    [[[1,1],2,[1,1]], 8],
    [[1,[4,[6]]], 17]
]

for tc in test_cases:
    l, exp = tc
    act = nlws(l)
    if exp == act:
        print 'PASS',
    else:
        print 'FAIL',
    print 'nlws(%s) = %s' % (l, act)
