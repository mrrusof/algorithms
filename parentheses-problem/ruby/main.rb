#!/usr/bin/env ruby

def balance s

  op = [] # opening parentheses
  dl = [] # delete these indexes

  s.chars.each_with_index do |c, i|
    if c == '('         # `c` is an opening parenthesis
      op << i           #   that we have to remember.
    elsif c == ')'      # `c` is a closing parenthesis
      if op.length == 0 #   that does not match an opening parenthesis
        dl << i         #     and therefore we will delete later
      else              #   that corresponds to an opening parenthesis
        op.pop          #     and therefore we forget about both
      end
    end
  end
  dl += op # delete later all unmatched opening/closing parentheses

  #
  # dl << s.length
  # r, _ = dl.reduce(['', 0]) { |a, i| [a[0] + s[a[1]...i], i + 1] }
  #

  r = '' # result string
  di = 0 # index in dl
  s.chars.each_with_index do |c, i|
    if di < dl.length and dl[di] == i # either skip this character
      di += 1
    else                              # or not
      r += c
    end
  end

  return r
end

while true
  s = readline.strip rescue break
  puts balance s
end
