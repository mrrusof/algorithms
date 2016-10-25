#!/usr/bin/env python

import re

def main():
    with open('/dev/stdin', 'rt') as f:
        while True:
            line = f.readline()
            if not line: break
            n = int(line)
#            print 'n =', n
            # W: weights
            W = []
            # Read weights
            for i in range(0, n):
                row = map(float, re.split(r' +', f.readline()))
                row.insert(i, 0.0)
#                print ' row =', row
                W.append(row)
#            print 'W =', W
            R = do_et(W, n)
            if len(R):
                for r in R: print r,
                print
            else:
                print 'no arbitrage sequence exists'

def do_et(W, n):
    # P: maximum profit for each path of given length
    # P[0] = None because there are no paths of length 0.
    # P[1] = W because most profitable path of length 1 is corresp. edge.
    P = [None, W]

    '''
    P[1] = W

    P[2][a][b] = n, n is max profit in 2 steps from a to b
    also, n = P[1][a][c] + P[1][c][b] for some c

    Thus, for max profit in m + 1 steps from a to b:
    P[m + 1][a][b] = n = P[m][a][c] + P[1][c][b] for some c
    P[m + 1][a][b] = n = P[m][a][c] + W[c][b] for some c
    '''

    # S: successor currency in most profitable path of given length
    # S[1][a][b] = b because that's the succ currency in most profitable path of length 1 from a to b.
    S = [None, [ [ b for b in range(0, n) ] for a in range(0, n) ] ]

    # Construct most profitable paths of length 2, 3, ...
    for m in range(1, n):
        p = [ [ 0.0 for b in range(0, n) ] for a in range(0, n) ]
        s = [ [ None for b in range(0, n) ] for a in range(0, n) ]
#        print 'm =', m
        for a in range(0, n):
            for b in range(0, n):
                for c in range(0, n):
                    if p[a][b] < W[a][c] * P[m][c][b]:
                        p[a][b] = W[a][c] * P[m][c][b]
#                        print ' %d -> %d ~> %d = %f' % (a + 1, c + 1, b + 1, p[a][b])
                        s[a][b] = c
#                        print 'p[%d][%d] = %f: (p[%d][%d] > 1.01) == %s' % (a, b, p[a][b], a, b, (p[a][b] > 1.01))
                        if p[a][a] > 1.01:
                            # spp: a shortest profitable path
                            n = s[a][b]
                            spp = [a + 1, n + 1]
                            for i in range(m, 1, -1):
                                n = S[i][n][b]
                                spp.append(n + 1)
                            spp.append(b + 1)
                            return spp
        P.append(p)
        S.append(s)
    return []
            
main()
