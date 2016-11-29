#!/usr/bin/env ruby

=begin

Merge k sorted linked lists and return it as one sorted list. Analyze
and describe its complexity.

=end

# I claim that complexity is O(n log k)
# where n is the length of the output
# and k is the number of lists given.
def merge_k_sorted_lists ll
  return [] if ll.length == 0
  return ll.first if ll.length == 1
  m = ll.length / 2 - 1
  l = merge_k_sorted_lists ll[0..m]
  r = merge_k_sorted_lists ll[m+1..-1]
  i = j = 0
  o = []
  while i < l.length or j < r.length
    if i < l.length and j < r.length
      if l[i] <= r[j]
        o << l[i]
        i += 1
      else
        o << r[j]
        j += 1
      end
    elsif i < l.length
      o << l[i]
      i += 1
    else
      o << r[j]
      j += 1
    end
  end
  return o
end

# For the online judge
#
# def merge_k_lists ll
#   ll = ll.map do |l|
#     o = []
#     curr = l
#     while curr != nil
#       o << curr.val
#       curr = curr.next
#     end
#     o
#   end
#   return merge_k_sorted_lists ll
# end

[ [[[1,2,4], [2,3,5]],[1,2,2,3,4,5]],
  [[[1,3,6],[2,5,8],[2,4,7]], [1,2,2,3,4,5,6,7,8]],
  [[[],[]], []],
  [[[],[1]], [1]]
].each do |ll, exp|
  act = merge_k_sorted_lists ll
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " merge_k_sorted_lists #{ll} = #{act}"
end
