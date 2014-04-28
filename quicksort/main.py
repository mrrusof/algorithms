#!/usr/bin/env python

import readline

def str_is_int(s):
    return s.isdigit() or (s.startswith('-') and s[1:].isdigit());

def quicksort(l):
    if len(l) <= 1: return l;
    left = [i for i in l[1:] if i <= l[0]];
    right = [i for i in l[1:] if i > l[0]];
    return (quicksort(left) + [l[0]] + quicksort(right));

def main():
    print "Input a sequence of numbers separated by comma: ";
    raw = raw_input();
    nums = raw.split(",");
    if any(not str_is_int(n) for n in nums):
        print "ERROR: input is not a sequence of numbers\n";
        exit(1);
    sorted = quicksort([int(n) for n in nums])
    for n in sorted: print("%d," % n),;

main();
