#!/usr/bin/env ruby

def is_permutation? a, b
  return false if a.length != b.length
  h = {}
  a.chars.each do |c|
    h[c] ||= 0
    h[c] += 1
  end
  b.chars.each do |c|
    h[c] ||= 0
    h[c] -= 1
    return false if h[c] < 0
  end
  return true
end

while true
  a = readline.strip rescue break
  b = readline.strip rescue break
  puts is_permutation? a, b
end
