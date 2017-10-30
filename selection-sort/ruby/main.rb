#!/usr/bin/env ruby

def swap a, i, j
  t = a[i]
  a[i] = a[j]
  a[j] = t
end

def selection_sort a
  i = 0
  while i < a.length
    j = i
    minj = j
    min = a[j]
    while (j += 1) < a.length
      if a[j] < min
        minj = j
        min = a[j]
      end
    end
    swap a, i, minj
    i += 1
  end
end

def main
  a = [10, 3, 9, 4, 5, 6, 1, 8]
  selection_sort a
  puts a.inspect
end

main
