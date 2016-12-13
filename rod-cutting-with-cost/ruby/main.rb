#!/usr/bin/env ruby

# Ex. 15.1-3: Consider a fixed cost for all cuts.

def bottom_up_cut_rod n, p, c
  r = [0]
  (1..n).each do |l|
    r << ((1..l-1).map { |i| p[i-1] + r[l-i] - c} << p[l-1]).max
  end
  return r[n]
end

p = [1,5,8,9,10,17,17,20,24,30]
[ [1, 1, 1],
  [2, 1, 5],
  [3, 1, 8],
  [4, 1, 9],
  [5, 1, 12],
  [6, 1, 17],
  [7, 1, 17],
  [8, 1, 21],
  [9, 1, 24],
  [10, 1, 30],
].each do |n, c, exp|
  act = bottom_up_cut_rod n, p, c
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " bottom_up_cut_rod #{n} = #{act} (#{exp})"
end
