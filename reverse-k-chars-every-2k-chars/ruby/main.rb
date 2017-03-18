#!/usr/bin/env ruby

def reverse_k_every_2k s, k
  i = 0
  while i < s.length
    l = i
    if i + k < s.length
      r = i + k - 1
    else
      r = s.length - 1
    end
    while l < r
      t = s[l]
      s[l] = s[r]
      s[r] = t
      l += 1
      r -= 1
    end
    i += 2 * k
  end
  return s
end

while true
  k = readline.strip.to_i rescue break
  s = readline.strip rescue break
  puts reverse_k_every_2k s, k
end
