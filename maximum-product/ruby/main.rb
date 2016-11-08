#!/usr/bin/env ruby

=begin

Write a program that given a sequence of integers, returns the product
of a contiguous subsequence that is maximum.

Example 1. Consider sequence 2, 3, -2, 4. Your program should return
6.  The subsequence that gives the product is 2, 3.

Example 2. Consider sequence 1, 2, -4, 1, 3, -2, 3, -1.  Your program
should return 144.  The subsequence that gives the product is
1, 2, -4, 1, 3, -2, 3.

Example 3. Consider sequence 0, 1, 2, 0. Your program should return
2. Subsequence is 1, 2.

=end

def max x, y
  return x if x > y
  return y
end

def max_prod l
  np = 1
  s = 1
  m = 0
  l.each do |e|
    if e == 0
      np = 1
      s = 1
    elsif e < 0 and np == 1
      np = s * e
      s = 1
    else
      s *= e
      if s > 0
        p = s
      else
        p = np * s
      end
      m = max m, p
    end
  end
  return m
end

test_cases = [
  [ 0, [0] ],
  [ 0, [-1] ],
  [ 0, [-1, 0, -2] ],
  [ 2, [-1, -2] ],
  [ 6, [-1, -2, -3] ],
  [ 2, [-1, -2, 0, -3] ],
  [ 6, [2, 3, -2, 4] ],
  [ 4, [1, 3, -2, 4] ],
  [ 72, [-2, 2, 3, -1, 2, 3, -1] ],
  [ 144, [1, 2, -4, 1, 3, -2, 3, -1] ],
  [ 2, [0, 1, 2, 0] ],
  [ 6, [2, 3, 0, 1, 2, -2, 4] ],
  [ 3, [2, -3, 1, 0, 2, -1, 3 ] ],
  [ 216, [3, -1, 2, 3, -1, 2, -1, 2, -1, 3] ],
  [ 18, [3, -1, 2, 3, -1, 0, 2, -1, 2, -1, 3] ],
  [ 12, [3, -1, 0, 2, 3, -1, 0, 2, -1, 2, -1, 3] ],
  [ 180, [6, -3, -10, 0, 2] ],
  [ 60, [-1, -3, -10, 0, 60] ],
  [ 80, [-2, -3, 0, -2, -40] ]
]

test_cases.each do |max, seq|
  [seq, seq.reverse].each do |seq|
    mp = max_prod seq
    if mp == max
      print "PASS"
    else
      print "FAIL (#{mp})"
    end
    puts " max_prod #{seq} = #{max}"
  end
end
