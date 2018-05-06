#!/usr/bin/env ruby

n = readline.strip.to_i
m = readline.strip.to_i
nums = []

while m > 0
  nums << readline.strip.to_i
  m -= 1
end

nums.sort! # n log n

while nums.length > 1
  x = nums.delete_at(0)
  y = nums.bsearch { |y| n <= x + y }
  if y != nil and x + y == n
    puts '1'
    exit
  end
end

puts '0'
