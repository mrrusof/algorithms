#!/usr/bin/env python

'''
move a onto b

Example:

  2   5
  0   4
  1   3
-----------
0 1 2 3 4 5

move 4 onto 1

stack of 4: 3
stack of 1: 1

put back 5
put back 2, 0

      4
0 1 2 3   5
-----------
0 1 2 3 4 5

pile 4 over 1

  4
0 1 2 3   5
-----------
0 1 2 3 4 5
'''

'''
move a over b

Example:

  2   5
  0   4
  1   3
-----------
0 1 2 3 4 5

move 4 over 1

stack of 4: 3
stack of 1: 1

put back 5

  2
  0   4
  1   3   5
-----------
0 1 2 3 4 5

pile 4 over 1

  4
  2
  0
  1   3   5
-----------
0 1 2 3 4 5

'''

'''
pile a onto b

Example:

  2   5
  0   4
  1   3
-----------
0 1 2 3 4 5

pile 4 onto 1

stack of 4: 3
stack of 1: 1

put back 2, 0

      5
      4
0 1 2 3
-----------
0 1 2 3 4 5

pile 4 over 1

  5
  4
0 1 2 3
-----------
0 1 2 3 4 5
'''

'''
pile a over b

Example:

  2   5
  0   4
  1   3
-----------
0 1 2 3 4 5

pile 4 over 1

stack of 4: 3
stack of 1: 1

top of stack 1: 2

set next 3 to null
set next 2 to 4
set prev 4 to 2

  2   5
  0   4
  1   3
-----------
0 1 2 3 4 5
'''

import re

B = []

def stack_of(a):
    c = B[a]
    while True:
        n = c['next']
        if n == None: break
        c = n
    return c['label']

def put_back(a):
    c = B[a]
    while True:
        n = c['next']
        if n == None: break
        n['home'] = True
        c = n

def pile_over(a, b):
    aa = B[a]
    sb = B[stack_of(b)]
    # unstack aa
    if aa['prev']:
        aa['prev']['next'] = None
    # stack aa over sb
    sb['next'] = aa
    aa['prev'] = sb

def print_stack(c):
    while True:
        print c['label'],
        n = c['next']
        if n == None: break
        c = n

def print_table():
    for b in B:
        print "%d:" % b['label'],
        if b['prev'] == None:
            print_stack(b)
        print

def main():
    with open ('/dev/stdin', 'rt') as f:
        n = int(f.readline().rstrip())
#        print 'n =', n
        for i in range(0, n):
            B.append({'label': i, 'next': None, 'prev': None})
        while True:
            line = f.readline().rstrip()
#            print 'line =', line
            if line.strip() == 'quit':
                break
            v, a, p, b = re.split(r' +', line)
            a = int(a)
            b = int(b)
            # is this a valid command?
            if stack_of(a) == stack_of(b):
                # ignore the command
                continue
            if v == 'move':
                put_back(a)
            if p == 'onto':
                put_back(b)
            pile_over(a, b)
#            print_table()
        print_table()

main()
