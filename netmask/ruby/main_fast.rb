#!/usr/bin/env ruby

def netmask? a, b, c, d
  candidate = (a << 24) + (b << 16) + (c << 8) + d
  # puts "c = " + candidate.to_s(2) + " "
  if candidate < 4278190080 || # 4278190080.to_s(2) => "11111111000000000000000000000000"
     candidate > 4294967292    # 4294967292.to_s(2) => "11111111111111111111111111111100"
    return false
  end
  complement = ~candidate & 4294967295 # 4294967295.to_s(2) => "11111111111111111111111111111111"
  succ_complement = complement + 1
  return complement & succ_complement == 0
end

while true
  a, b, c, d = readline.strip.split('.').map(&:to_i) rescue break
  puts netmask? a, b, c, d
end
