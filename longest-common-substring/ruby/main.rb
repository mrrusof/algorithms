#!/usr/bin/env ruby

def substring s1, s2
  s1p = 0
  s2.chars.each_with_index do |c, i|
    s1p = 0 if s1[s1p] != c
    if s1[s1p] == c
      s1p += 1
      return i - s1.length + 1 if s1p == s1.length
    end
  end
  return -1
end

def alcs s1, s2
  max = 0
  maxb = maxe = 0
  (0...s1.length).each do |s1b|
    s1e = s1b
    s2.chars.each do |c|
      s1e = s1b if s1e == s1.length or s1[s1e] != c
      if s1[s1e] == c
        s1e += 1
        if max < s1e - s1b
          max = s1e - s1b
          maxb = s1b
          maxe = s1e
        end
      end
    end
  end
  return s1[maxb...maxe]
end

while true
  s1 = readline.strip rescue break
  next if s1[0] == '#'
  s2 = readline.strip rescue break
  next if s2[0] == '#'
#  puts "'#{s1}' is substring of '#{s2}': #{substring s1, s2}"
  puts "a longest common substring of '#{s1}' and '#{s2}' is '#{alcs s1, s2}'"
end
