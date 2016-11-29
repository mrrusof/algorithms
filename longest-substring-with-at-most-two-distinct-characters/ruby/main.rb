#!/usr/bin/env ruby

=begin

Given a string, find the length of the longest substring `t` that
contains at most 2 distinct characters.

For example, Given `s` = "eceba",

`t` is "ece" which its length is 3.

=end

def lswamtdc s
  a = nil
  ac = 0
  b = nil
  bc = 0
  i = 0
  max_len = 0
  s.chars.each_with_index do |c, j|
    if a == nil
      a = c
      ac = 1
    elsif c == a
      ac += 1
    elsif b == nil
      b = c
      bc = 1
    elsif c == b
      bc += 1
    else
      # contract window
      while ac > 0 and bc > 0
        if s[i] == a
          ac -= 1
        else
          bc -= 1
        end
        i += 1
      end
      i += 1
      if ac == 0
        a = c
        ac = 1
      else
        b = c
        bc = 1
      end
    end
    max_len = [max_len, ac + bc].max
  end

  return max_len
end

[ ['', 0],
  ['x', 1],
  ['xy', 2],
  ['xyz', 2],
  ['aaa', 3],
  ['baa', 3],
  ['aba', 3],
  ['aab', 3],
  ['aabb', 4],
  ['abab', 4],
  ['abba', 4],
  ['baba', 4],
  ['bbaa', 4],
  ['xaabb', 4],
  ['axabb', 3],
  ['aaxbb', 3],
  ['aabxb', 3],
  ['aabbx', 4],
  ['aabbb', 5],
  ['ababb', 5],
  ['abbab', 5],
  ['abbba', 5],
  ['eceba', 3],
  ['abcbbbbcccbdddadacb', 10]
].each do |s, exp|
  act = lswamtdc s
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " lswamtdc #{s} = #{act}"
end
