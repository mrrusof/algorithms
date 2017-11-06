#!/usr/bin/env ruby

def swap a, i, j
  t = a[i]
  a[i] = a[j]
  a[j] = t
end

def shuffle
  a = (0...52).to_a
  i = a.length
  while i > 0
    j = Random.rand i
    i -= 1
    swap a, i, j
  end
  return a
end

def main
  s = shuffle
  puts s.inspect
  puts "all elements in result? #{(0...52).all? { |e| s.member? e }}"
  puts "length is 52? #{s.length == 52}"
end

main
