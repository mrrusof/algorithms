#!/usr/bin/env ruby

def count_pairs nn, d # O(n log n + n) = O(n log n)
  nn.sort! # O(n log n)
  count = 0
  c = 1
  p = 0
  while c < nn.length # O(n + n) = O(n)
    # move candidate position p
    while nn[p] < nn[c] - d # O(n)
      p += 1
    end
    # do positions p and c make a pair?
    if nn[p] == nn[c] - d
      count += 1
    end
    c += 1
  end
  return count
end

while true
  _, d = readline.chomp.split(' ').map(&:to_i) rescue break
  nn = readline.chomp.split(' ').map(&:to_i)
  puts count_pairs nn, d
end
