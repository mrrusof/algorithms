#!/usr/bin/env ruby

def length_of_longest_common_palindrome mm # mm is array of messages
  mins = {}
  mm.each_with_index { |m, i|
    letters = {}
    m.chars.each { |c|
      letters[c] ||= 0
      letters[c] += 1
    }
    letters.to_a.each { |c, v|
      if i == 0 or (mins[c] != nil and v < mins[c])
        mins[c] = v
      end
    }
  }
  return mins.values.reduce(0, &:+)
end

while true
  n = readline.strip.to_i rescue break
  mm = []
  while n > 0
    m = readline.strip
    mm << m
    n -= 1
  end
  puts length_of_longest_common_palindrome mm
end
