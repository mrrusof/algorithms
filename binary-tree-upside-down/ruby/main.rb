#!/usr/bin/env ruby

=begin

Given a binary tree where all the right nodes are either leaf nodes
with a sibling (a left node that shares the same parent node) or
empty, flip it upside down and turn it into a tree where the original
right nodes turned into left leaf nodes. Return the new root.

For example:

Given a binary tree {1,2,3,4,5},

    1
   / \
  2   3
 / \
4   5

return the root of the binary tree [4,5,2,#,#,3,1].

   4
  / \
 5   2
    / \
   3   1

=end

def flip r
  return r if r == nil or r.length == 0
  nr = nil
  l = nil
  begin
    nr = [r[0], l, nr]
    l = r[2]
    r = r[1]
  end while !!r
  return nr
end

[ [ [1, [2, [3, [5, nil, nil], [6, nil, nil]], [4, nil, nil]], nil],
    [5, [6, nil, nil], [3, [4, nil, nil], [2, nil, [1, nil, nil]]]] ],
  [ [1, [2, [4, nil, nil], [5, nil, nil]], [3, nil, nil]],
    [4, [5, nil, nil], [2, [3, nil, nil], [1, nil, nil]]] ]
].each do |input, exp|
  if exp == flip(input)
    puts 'PASS'
  else
    puts 'FAIL'
  end
end

