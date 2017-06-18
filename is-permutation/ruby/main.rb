#!/usr/bin/env ruby

def count_chars s
  h = {}
  s.chars.each do |c|
    h[c] ||= 0
    h[c] += 1
  end
  return h
end

def is_permutation? a, b
  h1 = count_chars a
  h2 = count_chars b
  return h1.all? { |k, v| h2[k] == v }
end

while true
  a = readline.strip rescue break
  b = readline.strip rescue break
  puts is_permutation? a, b
end
