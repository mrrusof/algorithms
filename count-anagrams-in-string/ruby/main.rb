#!/usr/bin/env ruby

def count_anagrams s, p
  ac = 0        # anagram count
  f = {}        # counters for the characters in `s`
  s.chars.each { |c| f[c] = (f[c] || 0) + 1 }
  cl = f.length # counters left to reach zero
  p.chars.each_with_index do |c, i|
    # contract window
    if i >= s.length
      ec = p[i - s.length] # the letter that exits
      if !!f[ec]           # is the letter that exits in `s`?
        f[ec] += 1         # it is and we note that it left the window
        if f[ec] == 1      # do we lack instances of the letter?
          cl += 1          # we do and we note that
        end
      end
    end
    # expand window
    if !!f[c]      # is the letter that enters in `s`?
      f[c] -= 1    # it is and we make a note that it is in the window
      if f[c] == 0 # have we found enough instances of the letter?
        cl -= 1    # we have and we note that
        if cl == 0 # have we found all the letters of `s`?
          ac += 1  # we have, this window position is an anagram
        end
      end
    end
  end
  return ac
end

while true
  s = readline.strip rescue break
  p = readline.strip
  puts count_anagrams s, p
end

# [ ['hello', 'ellohello', 5]
# ].each do |s, p, exp|
#   act = count_anagrams s, p
#   if act == exp
#     print 'PASS'
#   else
#     print 'FAIL'
#   end
#   puts " count_anagrams #{s}, #{p} = #{act} (#{exp})"
# end
