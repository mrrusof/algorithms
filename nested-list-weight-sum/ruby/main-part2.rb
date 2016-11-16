#!/usr/bin/env ruby

=begin

Given a nested list of integers, return the sum of all integers in the
list weighted by their depth.

Each element is either an integer, or a list -- whose elements may
also be integers or other lists.

Different from the previous question where weight is increasing from
root to leaf, now the weight is defined from bottom up. i.e., the leaf
level integers have weight 1, and the root level integers have the
largest weight.

Example 1: Given the list [[1,1],2,[1,1]], return 8. (four 1's at
depth 1, one 2 at depth 2)

Example 2: Given the list [1,[4,[6]]], return 17. (one 1 at depth 3,
one 4 at depth 2, and one 6 at depth 1; 1*3 + 4*2 + 6*1 = 17)

=end

def max_depth a, d
  if a.is_a? Array
    return a.map{ |e| 1 + max_depth(e, d) }.max
  else
    return 0
  end
end

def nlws a, d
  a.reduce(0) do |acc, e|
    if e.is_a? Array
      acc + nlws(e, d - 1)
    else
      acc + e * d
    end
  end
end

def nested_list_weight_sum a
  d = max_depth a, 0
  return nlws a, d
end

[ [[[1,1],2,[1,1]], 8],
  [[1,[4,[6]]], 17]
].each do |a, exp|
  act = nested_list_weight_sum a
  if exp == act
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " nlws #{a} = #{act}"
end
