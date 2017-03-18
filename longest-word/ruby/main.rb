#!/usr/bin/env ruby

def length_of_longest_common_anagram mm # mm is array of messages
  mins = Array.new(26)
  count = Array.new(26)
  mm.each { |m|
    count.map! { |_| 0 }
    m.chars.each { |l|
      count[l.ord - 'a'.ord] += 1
    }
    count.each_with_index { |c, l|
      if mins[l] == nil or c < mins[l]
        mins[l] = c
      end
    }
  }
  return mins.reduce(0, &:+)
end

while true
  n = readline.strip.to_i rescue break
  mm = []
  while n > 0
    m = readline.strip
    mm << m
    n -= 1
  end
  puts length_of_longest_common_anagram mm
end
