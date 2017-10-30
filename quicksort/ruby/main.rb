#!/usr/bin/env ruby

def swap a, i, j
  t = a[i]
  a[i] = a[j]
  a[j] = t
end

def qs a, s, e
  return if s + 1 >= e
  m = (s + e) / 2
  p = a[m]
  l = s
  r = e - 1
  while true
    while a[l] < p
      l += 1
    end
    while a[r] > p
      r -= 1
    end
    break if l >= r
    swap a, l, r
    l += 1
    r -= 1
  end
  qs a, s, l
  qs a, l, e
end

def quicksort a
  qs a, 0, a.length
end

def main
  a = [10, 3, 9, 4, 5, 6, 1, 8]
  quicksort a
  puts a.inspect
end

main
