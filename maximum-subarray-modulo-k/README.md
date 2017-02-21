# Problem

Given an array of non-negative integers and a positive integer `k`,
find the maximum amongst the sum of each subarray modulo `k`.
When no maximum exists, return -1.

**Example.**
Let `k` be 7 and the array the following.

```
3 3 9 9 5
```

The subarrays and their sums modulo 7 are the following.

```
3 3 9 9 5
| | | | |
V V V V V
3 3 2 2 5

3 3 9 9 5
---
 6 <------ maximum
  ---
   5
    ---
     4
      ---
       0

3 3 9 9 5
-----
  1
  -----
    0
    -----
      2

3 3 9 9 5
-------
   3
  -------
     5

3 3 9 9 5
---------
    1
```

The maximum is 6.

# Solution

The proposed solution is `O(kn)`.

The solution value is the maximum amongst the maximum arrays that end
in each position.
To illustrate how to compute the maximum value for a given position,
consider the following example.

**Example.**
Given array `A = [3 2 11]` and `k = 7`, compute the maximum array that
ends in the last position in the following way.

```
         . <- 16 % 7 = 2
         .
14       .
         * <- 13 % 7 = 6
         *
11       # <- 11 % 7 = 4
         #
         #
         #
7        #
         #
       . #
       . #
     . . #
     . * #
     . * #
     
  A: 3 2 11
pos: 0 1 2
     
     ---
      5
       -
       2
     ------
       2
       ----
         6
         __
         4

0 -> 6
1 -> 5
2 -> 4
3 -> 3
4 -> 2
5 -> 1
6 -> 0


```

- The maximum subarray that ends in position 2 has value 6, the
  maximum value any subarray can have given `k = 7`.
- 11 is part of the maximum subarray that ends in position 2.
- The maximum subarray that ends in position 2 consists of 11 and
  the subarray that ends in position 1 with value 2.
- For each position i, there are at most 7 different values (0 to 6)
  for arrays ending in position i.
  - For position 0, values of arrays ending there are 3.
  - For position 1, values of arrays ending there are the following.
    - 5 = 3 + 2
    - 2
  - For position 2, values of arrays ending there are the following.
    - 2 = 16 % 7 = (5 + 11) % 7 = (5 + 4) % 7 = 9 % 7
    - 6 = 13 % 7 = (2 + 11) % 7 = (2 + 4) % 7 = 6 % 7
    - 4 = 11 % 7
- For position 2, the maximum array that ends there is the maximum of
  the values of arrays ending there.


```
  A: 3 2 11
pos: 0 1 2
  0:
  1:
  2:   1 0
  3: 0   
  4:     2
  5:   0 
  6:     1

  0:  
  1:  
  2:  
  3: 0
  4:  
  5:  
  6:  

  0:  
  1:  
  2: 1
  3: 
  4:  
  5: 0 
  6:  

  0:  
  1:  
  2: 0
  3: 
  4: 2 
  5: 
  6: 1


2 0: 1
3 1:    
4 2:    
5 3: 0  
6 4:  
0 5:  
1 6:  

6 0: 1
0 1:    
1 2:    
2 3: 0  
3 4:  
4 5: 2
5 6:  



  A: 3 2 11
pos: 0 1 2

     3 5 2
       2 6
         4
```

**Other examples**

```
1 8 2
```


```
5 6
-
5
---
 4
  -
  6

6 % 7 = 6
9 % 7 = 2
     

7    
     #
     #
     #
   . #
   * #
 . * #
 1 2 6
 -----
   2
   ---
    1
     -
     6


 .    
 * * 
7* * 
 # # #
 # # #
 # # #
 # # #
 # # #
 # # #
 1 2 6
 -----
   2
   ---
    1
     -
     6


 .
 # #
7# #  
 # # 
 # # 
 # # 
 # # 
 * * *
 * * *
 1 6 2
 ---
  0
   -
   6
 -----
   2
   ---
    1
     -
     2

  
7    
   # 
   # 
   # 
   # 
   # *
 . # *
 1 6 2
 -----
   2
   ---
    1
     -
     2
```