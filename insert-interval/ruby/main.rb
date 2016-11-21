#!/usr/bin/env ruby

=begin

Given a set of non-overlapping intervals, insert a new interval into
the intervals (merge if necessary).

You may assume that the intervals were initially sorted according to
their start positions.

Example 1: Given intervals [1,3],[6,9], insert and merge [2,5] in as
[1,5],[6,9].

Example 2: Given [1,2],[3,5],[6,7],[8,10],[12,16], insert and merge
[4,9] in as [1,2],[3,10],[12,16].

This is because the new interval [4,9] overlaps with
[3,5],[6,7],[8,10].

=end

def insert_interval ii, a
  ee = ii.reduce([]) { |acc, i| acc + i }
  l, r = a
  o = []
  i = 0
  while i < ee.length and ee[i] < l
    o << ee[i]
    i += 1
  end
  if i % 2 == 0
    o << l
  end
  while i < ee.length and ee[i] <= r
    i += 1
  end
  if i % 2 == 0
    o << r
  end
  while i < ee.length
    o << ee[i]
    i += 1
  end
  ii = []
  i = 0
  while i < o.length
    ii << [o[i], o[i+1]]
    i += 2
  end
  return ii
end

# For online judge
#
# def insert ii, a
#   ii = ii.map { |i| [i.start, i.end] }
#   ii = insert_interval ii, [a.start, a.end]
#   return ii.map { |i| Interval.new i[0], i[1] }
# end

[ [ [ [1,3],[6,9] ],
    [2,5],
    [ [1,5],[6,9] ] ],
  [ [ [1,3],[6,9] ],
    [1,5],
    [ [1,5],[6,9] ] ],
  [ [ [1,2],[3,5],[6,7],[8,10],[12,16] ],
    [4,9],
    [ [1,2],[3,10],[12,16] ] ]
].each do |ii, a, exp|
  act = insert_interval ii, a
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " insert_interval #{ii} = #{act}"
end
