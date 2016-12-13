#!/usr/bin/env ruby

=begin

Given a square matrix of integers, find the maximum sum of elements on
the way from the top-left cell to the bottom-right cell.
From a given cell, you may only move to the cell to the right or the
cell below.

Example. The answer for the following matrix is 29.

1 2 3
4 5 6
7 8 9

=end

def traverse m
  n = m.length - 1
  (0..n).each do |i|
    (0..n).each do |j|
      u = if i > 0 then m[i-1][j] else 0 end
      l = if j > 0 then m[i][j-1] else 0 end
      m[i][j] = [u, l].max + m[i][j]
    end
  end
  return m[-1][-1]
end

[ [[[1,2,3],[4,5,6],[7,8,9]], 29],
  [[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], 73],
  [[[1,2,3,4],[5,6,7,50],[9,10,11,12],[13,14,15,16]], 97],
  [[[10,-4,3],[5,2,6],[-1,7,9]], 33]
].each do |m, exp|
  act = traverse m
  if exp == act
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " traverse [#{m[0]}, ...] = #{act}"
end
