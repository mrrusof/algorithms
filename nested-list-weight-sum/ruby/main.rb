#!/usr/bin/env ruby

=begin

Given a nested list of integers, return the sum of all integers in the list weighted by their depth.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

Example 1:
Given the list [[1,1],2,[1,1]], return 10. (four 1's at depth 2, one 2 at depth 1)

=end

def nlw l, d
  l.reduce(0) do |acc, e|
    if e.is_a? Array
      acc + nlw(e, d + 1)
    else
      acc + e * d
    end
  end
end

[ [ [[1,1],2,[1,1,]], 10 ]
].each do |l, exp|
  if exp == nlw(l, 1)
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " nlw #{l} = #{exp}"
end
