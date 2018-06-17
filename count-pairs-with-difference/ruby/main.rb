#!/usr/bin/env ruby

def count_pairs nn, d
  seen = {}
  count = 0
  nn.each do |n|
    count += 1 if seen[n - d]
    count += 1 if seen[n + d]
    seen[n] = true
  end
  return count
end

while true
  _, d = readline.chomp.split(' ').map(&:to_i) rescue break
  nn = readline.chomp.split(' ').map(&:to_i)
  puts count_pairs nn, d
end
