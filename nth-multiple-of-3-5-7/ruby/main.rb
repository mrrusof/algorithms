#!/usr/bin/env ruby

def kth k
  return nil if k < 1
  nn = [1]
  i3 = i5 = i7 = 0
  while nn.length < k
    n3 = nn[i3] * 3
    n5 = nn[i5] * 5
    n7 = nn[i7] * 7
    next_n = [n3, n5, n7].min
    i3 += 1 if n3 == next_n
    i5 += 1 if n5 == next_n
    i7 += 1 if n7 == next_n
    nn << next_n
  end
  return nn[-1]
end

def main
  (0..20).each do |n|
    puts "#{n} -> #{kth n}"
  end
end

main
