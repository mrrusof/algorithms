#!/usr/bin/env ruby

def is_substring s1, s2
  return s2.index(s1) != nil
end

def is_rotation s1, s2
  return false if s1.length != s2.length
  return is_substring(s2, s1 + s1)
end

while true
  s1 = readline.strip rescue break
  s2 = readline.strip rescue break
  puts is_rotation s1, s2
end
