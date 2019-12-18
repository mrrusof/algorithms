#!/usr/bin/env ruby

def swap a, i, j
  t = a[i]
  a[i] = a[j]
  a[j] = t
end

def partition a, b, e
  p = a[e]
  l = b
  r = (e -= 1)
  while l < r
    while l < e && a[l] <= p do l += 1 end
    while b < r && p <= a[r] do r -= 1 end
    swap a, l, r if l < r
  end
  if p <= a[l]
    swap a, l, e + 1 
    return l
  else
    return e + 1
  end
end

def quicksort! a, b, e
  return if e <= b
  m = partition a, b, e
  quicksort! a, b, m - 1
  quicksort! a, m + 1, e
end

[
  [1,2,3,4,5],
  [6,5,4,3,2],
  [5,6,6,7,6],
  [5,6,1,4,3,7,9]
].each do |a|
  print "quicksort #{a} = "
  quicksort! a, 0, a.length - 1
  puts "#{a}"
end
