You are given a work list that must be processed in the
given order in such a way that no two identical items are processed
within a given _cooldown period_.  Compute the amount of time that
takes processing the work list.

Processing each item takes one time unit and the cooldown period is
given in time units.  When a given item is within the cooldown of
another identical item, do nothing until the cooldown period elapses.

Consider work list `AABACBC` and cooldown period of 2 time units.  The
processing of the work list is the following.

```
 work list:  A        A  B     A  C  B     C
processing:  A  _  _  A  B  _  A  C  B  _  C
      time:  1  2  3  4  5  6  7  8  9 10 11
```
