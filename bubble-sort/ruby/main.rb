#!/usr/bin/env ruby

def swap a, i, j
  t = a[i]
  a[i] = a[j]
  a[j] = t
end

def bubble_sort a
  swapped = true
  while swapped
    swapped = false
    i = 0
    while i < a.length - 1
      if a[i] > a[i + 1]
        swap a, i, i + 1
        swapped = true
      end
      i += 1
    end
  end
end

def main
  a = [10, 3, 9, 4, 5, 6, 1, 8]
  bubble_sort a
  puts a.inspect
end

main
