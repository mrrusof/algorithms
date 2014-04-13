#!/usr/bin/env python

g = {(1,2),
     (2,3),
     (3,1),
     (3,4),
     (1,4),
     (4,5),
     (1,5),
     (2,5),
     (2,10),
     (5,6),
     (6,7),
     (4,6),
     (4,7),
     (6,8),
     (8,9),
     (5,8),
     (8,10),
     (9,10),
     (7,9),
     (7,8),
     (5,10)};
t = {(1,2),
     (1,3),
     (3,4),
     (5,6),
     (6,7),
     (6,8),
     (8,9),
     (5,10)};

def mst(t, g):
    return tree(t) and vertices(t) == vertices(g)

def tree(t):
    return not any(path(v, v, t) for v in vertices(t))

def vertices(g):
    return vs(g.copy())
def vs(g):
    if g:
        e = g.pop()
        return vertices(g) | set(e)
    else:
        return set()
    
def path(a, b, g):
    return (a, b) in g or \
           (b, a) in g or \
           any(x == a and path(y, b, g - {(x,y)}) for (x, y) in g) or \
           any(y == a and path(x, b, g - {(x,y)}) for (x, y) in g)

if mst(t, g):
    print("T is a mst of G!")
