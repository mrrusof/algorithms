#!/usr/bin/env ruby

def build_proper_prefix_that_is_suffix p
  pi = Array.new(p.length, 0) # Array of zeroes of length |p|
  m = 0
  (1...p.length).each do |k|
    while m > 0 && p[m] != p[k]
      m = pi[m - 1]
    end
    if p[m] == p[k]
      m += 1
    end
    pi[k] = m
  end
  return pi
end

def index_of pattern, text
  pi = build_proper_prefix_that_is_suffix pattern
  k = 0
  (0...text.length).each do |q|
    while k > 0 && pattern[k] != text[q]
      k = pi[k - 1]
    end
    if pattern[k] == text[q]
      return q - k if k + 1 == pattern.length
      k += 1
    end
  end
  return -1
end

def main
  text = readline.strip
  pattern = readline.strip
  puts index_of pattern, text
end

main
