#!/usr/bin/env ruby

=begin

Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.

**Hint**

Consider the following cases.

1. Points are repeated.
2. Delta x is zero.
3. You are given no points.
4. You are given one point.

=end

def mpoal pp
  m = if pp.length > 0 then 1 else 0 end
  pp.each_with_index do |a, i|
    break if m >= pp.length - i
    buckets = {}
    max_bucket = 0
    count_a = 1
    pp[i+1..-1].each do |b|
      if b[0] - a[0] == 0
        slope = :inf
      else
        slope = (b[1].to_f - a[1]) / (b[0].to_f - a[0])
      end
      if a == b
        count_a += 1
      else
        buckets[slope] = 0 if not buckets.has_key?(slope)
        buckets[slope] += 1
        max_bucket = [max_bucket, buckets[slope]].max
      end
      m = [m, count_a + max_bucket].max
    end
  end
  return m
end

# For the blog
#
# def main
#   n = readline.to_i
#   pp = []
#   while n > 0
#     p = readline.strip.split(' ').map{ |c| c.to_i }
#     pp << p
#     n -= 1
#   end
#   puts mpoal(pp)
# end

# main

# For the judge.
#
# def max_points pp
#   return mpoal pp.map {|p| [p.x, p.y]}
# end

[ [ [ [1,2], [3,4] ],
    2 ],
  [ [ [1,1], [2,2], [3,3], [4,4], [4,1], [6,1], [6,3] ],
    4 ],
  [ [ [0,0], [0,0] ],
    2 ],
  [ [],
    0 ],
  [ [ [0,0],[1,1],[0,0] ],
    3 ],
  [ [ [84,250],[0,0],[1,0],[0,-70],[0,-70],[1,-1],[21,10],[42,90],[-42,-230] ],
    6 ],
  [ [ [0,-12],[5,2],[2,5],[0,-5],[1,5],[2,-2],[5,-4],[3,4],[-2,4],[-1,4],[0,-5],[0,-8],[-2,-1],[0,-11],[0,-9] ],
    6 ]
].each do |pp, exp|
  act = mpoal pp
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " max_points #{pp} = #{act}"
end
