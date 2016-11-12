#!/usr/bin/env ruby

=begin

There are a row of n houses, each house can be painted with one of the
three colors: red, blue or green. The cost of painting each house with
a certain color is different. You have to paint all the houses such
that no two adjacent houses have the same color.

The cost of painting each house with a certain color is represented by
a n x 3 cost matrix. For example, costs[0][0] is the cost of painting
house 0 with color red; costs[1][2] is the cost of painting house 1
with color green, and so on... Find the minimum cost to paint all
houses.

=end

def mc_ph cm
  ac = [0,0,0]
  cm.each do |cv|
    ac = cv.each_with_index.map do |c, i|
      c + ac.each_with_index.select{ |_, j| j != i }.map{ |c, _| c }.min
    end
  end
  return ac.min
end

[ [ 4, [ [1,2,3], [3,2,1], [2,1,3], [3,2,1] ] ],
  [ 3, [ [1,2,3], [1,3,3] ] ],
  [ 2, [ [1,2,3], [1,1,3] ] ]
].each do |exp, cm|
  act = mc_ph(cm)
  if exp == act
    puts "PASS mc_ph #{cm} = #{exp}"
  else
    puts "FAIL mc_ph #{cm} = #{act} (#{exp})"
  end

end
