#!/usr/bin/env python

import re

'''
There are 3 bins and three kinds of bottles (brown, green, and clear).
Thus, there are 6 candidate configurations.

BCG
BGC
CBG
CGB
GBC
GCB
'''

# ic: initial configuration
# tc: target configuration
def cost(ic, tc):
    cost  = ic[3 + tc[0]] + ic[6 + tc[0]]
    cost += ic[tc[1]]     + ic[6 + tc[1]]
    cost += ic[tc[2]]     + ic[3 + tc[2]]
    return cost

def min(x, y):
    return x if x < y else y

B = 0
G = 1
C = 2
confs = [ [B, C, G],
          [B, G, C],
          [C, B, G],
          [C, G, B],
          [G, B, C],
          [G, C, B] ]
labels = [ 'BCG',
           'BGC',
           'CBG',
           'CGB',
           'GBC',
           'GCB' ]


def main():
    with open('/dev/stdin', 'rt') as f:
        while True:
            line = f.readline().rstrip()
            if not line: break
            # ic matches (B G C | B G C | B G C)
            ic = map(int, re.split(r' +', line))
            # mc: minimum cost
            mc = cost(ic, confs[0])
#            print 'mc0 =', mc
            fc = 0
            for i in range(1, 6):
#                print 'i =', i
#                print 'confs[%d] =' % i, confs[i]
#                print 'cost(ic, confs[%d]) =' % i, cost(ic, confs[i])
                # cc: current cost
                cc = cost(ic, confs[i])
                if cc < mc:
                    mc = cc
                    # fc: final configuration
                    fc = i
#                print 'mc%d =' % i, mc
            print labels[fc], mc

main()
