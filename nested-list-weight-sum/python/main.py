#!/usr/bin/env python

def nlws(l, d):
    acc = 0
    for e in l:
        if type(e) is list:
            acc += nlws(e, d + 1)
        else:
            acc += e * d
    return acc

test_cases = [
    [ [[1,1],2,[1,1]], 10 ]
]

for tc in test_cases:
    l, exp = tc
    s = nlws(l, 1)
    if exp == s:
        print 'PASS',
    else:
        print 'FAIL',
    print "nlws %s = %s" % (l, exp)
