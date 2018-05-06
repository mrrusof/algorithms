#!/usr/bin/env ruby

s = r = o = 0

while true
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  break if nn.length != 4
  a,b,c,d = nn
  if a > 0 && b > 0 && a == c && b == d
    if a == b
      s += 1
    else
      r += 1
    end
  else
    o += 1
  end
end

puts "#{s} #{r} #{o}"
