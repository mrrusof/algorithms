#!/usr/bin/env ruby

def search c, m, b
  # puts "m = #{m.to_s(2)}, s = #{s}"
  if b == 0
    return false
  elsif c == m
    return true
  else
    b /= 2
    if m < c # candidate is not on the left
      m = (m >> b) | m
      return search c, m, b
    else # c < m, candidate is not on the right
      m = (m << b) & 4294967295 # 4294967295.to_s(2) => "11111111111111111111111111111111"
      return search c, m, b
    end
  end
end

def netmask? a, b, c, d
  candidate = (a << 24) + (b << 16) + (c << 8) + d
  # puts "c = " + candidate.to_s(2) + " "
  if candidate < 4278190080 || # 4278190080.to_s(2) => "11111111000000000000000000000000"
     candidate > 4294967292    # 4294967292.to_s(2) => "11111111111111111111111111111100"
    return false
  end
  middle = 4294901760 # middle.to_s(2) => "11111111111111110000000000000000"
  bits_in_half = 16
  return search candidate, middle, bits_in_half
end

while true
  a, b, c, d = readline.strip.split('.').map(&:to_i) rescue break
  puts netmask? a, b, c, d
end
