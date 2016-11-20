#!/usr/bin/env ruby

=begin

Given a collection of intervals, merge all overlapping intervals.

For example,
Given [1,3],[2,6],[8,10],[15,18],
return [1,6],[8,10],[15,18].

=end

def leq aa, bb
  aa.each_with_index do |a, i|
    if a < bb[i]
      return true
    elsif a > bb[i]
      return false
    end
  end
  return true
end

def sort_intervals ii
  return if ii.length <= 1
  m = ii.length / 2
  left = ii[0..m-1]
  right = ii[m..-1]
  sort_intervals left
  sort_intervals right
  k = i = j = 0
  while k < ii.length
    if i < m and j < ii.length - m
      if leq left[i], right[j]
        ii[k] = left[i]
        k += 1
        i += 1
      else
        ii[k] = right[j]
        k += 1
        j += 1
      end
    elsif i < m
      ii[k] = left[i]
      k += 1
      i += 1
    else
      ii[k] = right[j]
      k += 1
      j += 1
    end
  end
end

def merge_intervals ii
  ii = ii.dup
  return ii if ii.length <= 1
  sort_intervals ii
  return ii[1..-1].reduce([ii.first]) do |acc, b|
    a = acc[-1]
    if b[0] <= a[1]
      if a[1] < b[1]
        a[1] = b[1]
      end
      acc
    else
      acc << b
    end
  end
end

# For the judge
#
# def merge ii
#   ii = ii.map { |i| [i.start, i.end] }
#   ii = merge_intervals ii
#   return ii.map { |i| Interval.new i[0], i[1] }
# end

[ [ [ [1,3],[2,6],[8,10],[15,18] ],
    [ [1,6],[8,10],[15,18] ] ],
  [ [ [8,10],[2,6],[15,18],[1,3] ],
    [ [1,6],[8,10],[15,18] ] ],
  [ [ [1,4],[1,4] ],
    [ [1,4] ] ]
].each do |ii, exp|
  act = merge_intervals ii
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " merge_intervals #{ii} = #{act}"
end

