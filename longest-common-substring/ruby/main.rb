#!/usr/bin/env ruby

def substring s1, s2
  (0..(s2.length - s1.length)).each do |i|
    if (0...s1.length).all? { |j| s2[i+j] == s1[j] }
      return i
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
