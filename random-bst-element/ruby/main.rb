#!/usr/bin/env ruby

def get_random root, count
  i = Random.rand count
  r = root
  left_cousins = 0
  while true
    j = r.left_count + left_cousins
    return r.value if j == i
    if j < i
      r = r.right
      left_cousins = j + 1
    else
      r = r.left
    end
  end
end

class Node
  attr_accessor :value, :left, :right, :left_count
  def initialize v, l, r, lc
    @value = v
    @left = l
    @right = r
    @left_count = lc    
  end
end

def main
  n1 = Node.new 1, nil, nil, 0
  n3 = Node.new 3, nil, nil, 0
  n2 = Node.new 2, n1, n3, 1
  n6 = Node.new 6, nil, nil, 0
  n7 = Node.new 7, n6, nil, 1
  n9 = Node.new 9, nil, nil, 0
  n8 = Node.new 8, n7, n9, 2
  n5 = Node.new 5, n2, n8, 3
  i = 0
  fq = {}
  [1,2,3,5,6,7,8,9].each { |i| fq[i] = 0 }
  while (i += 1) < 800000
    fq[get_random n5, 8] += 1
  end
  fq.each do |k,v|
    puts "#{k} -> #{v}"
  end
end

main
