#!/usr/bin/env ruby

def permutation_of_palindrome? s
  bit_vector = build_bit_vector s
  return bit_vector == 0 || bit_vector & (bit_vector - 1) == 0
end

def build_bit_vector s
  bit_vector = 0
  s.chars.each do |c|
    bit_pos = c.ord - 'a'.ord
    bit_vector = flip_bit bit_vector, bit_pos
  end
  return bit_vector
end

def flip_bit bv, bp
  mask = 1 << bp
  if bv & mask == 0 # bit is off
    return bv | mask
  end
  return bv & ~mask
end

while true
  s = readline.strip rescue break
  puts permutation_of_palindrome? s
end
