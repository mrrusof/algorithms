#!/usr/bin/env ruby

def min_tree a
  return nil if !a or a == []
  middle = a.length / 2
  l = min_tree a[0...middle]
  r = min_tree a[(middle + 1)...a.length]
  return [a[middle], l, r]
end

while true
  a = readline.strip.split(' ').map(&:to_i) rescue break
  puts "#{min_tree a}"
end
