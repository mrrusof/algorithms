#!/usr/bin/env ruby

def first_for_level l
  2 ** l - 1
end

def gen_tree p, n, b, g
  if n < b
    l = first_for_level(n + 1) + (p - first_for_level(n)) * 2
    r = l + 1
    g[p] = [l, r]
    gen_tree l, n + 1, b, g
    gen_tree r, n + 1, b, g
  end
end

l = 18
nc = 2 ** (l + 1) - 2

puts 1
puts"0 #{nc}"
puts "#{nc}"
g = {}
gen_tree 0, 0, l, g
g.to_a.each do |a, v|
  v.each do |b|
    puts "#{a} #{b}"
  end
end
