#!/usr/bin/env ruby

def merge a, s, m, e, b
  (s...e).each do |i|
    b[i] = a[i]
  end
  i = l = s
  r = m
  while l < m and r < e
    if b[l] < b[r]
      a[i] = b[l]
      l += 1
    else
      a[i] = b[r]
      r += 1
    end
    i += 1
  end
  while l < m
    a[i] = b[l]
    l += 1
    i += 1
  end
end

def ms a, s, e, b
  return if s + 1 >= e
  m = (s + e) / 2
  ms a, s, m, b
  ms a, m, e, b
  merge a, s, m, e, b
end

def merge_sort a
  ms a, 0, a.length, a.dup
end

def main
  a = [10, 3, 9, 4, 5, 6, 1, 8]
  merge_sort a
  puts a.inspect
end

main
