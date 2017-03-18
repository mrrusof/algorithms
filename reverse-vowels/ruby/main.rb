#!/usr/bin/env ruby

def reverse_vowels s
  vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
  l = 0
  r = s.length
  while l < r
    while l < r and not vowels.include? s[l]
      l += 1
    end
    while l < r and not vowels.include? s[r]
      r -= 1
    end
    if l < r
      t = s[l]
      s[l] = s[r]
      s[r] = t
    end
    l += 1
    r -= 1
  end
  return s
end

while true
  s = readline.strip rescue break
  puts reverse_vowels s
end
