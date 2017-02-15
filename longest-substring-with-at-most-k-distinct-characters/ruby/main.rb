#!/usr/bin/env ruby

=begin

Given a string, find the length of the longest substring `t` that
contains at most 2 distinct characters.

For example, given `s` = "eceba",

`t` is "ece" which its length is 3.

=end

def longest k, s
  cc = {}
  i = 0
  max_len = 0
  s.chars.each_with_index do |c, j|
    if cc.has_key? c
      cc[c] += 1
    else
      max_len = [max_len, j - i].max
      if cc.length == k
        while cc[s[i]] != 1
          cc[s[i]] -= 1
          i += 1
        end
        cc.delete s[i]
        i += 1
      end
      cc[c] = 1
    end
  end
  return [max_len, s.length - i].max
end

[ [2, '', 0],
  [2, 'x', 1],
  [2, 'xy', 2],
  [2, 'xyz', 2],
  [2, 'aaa', 3],
  [2, 'baa', 3],
  [2, 'aba', 3],
  [2, 'aab', 3],
  [2, 'aabb', 4],
  [2, 'abab', 4],
  [2, 'abba', 4],
  [2, 'baba', 4],
  [2, 'bbaa', 4],
  [2, 'xaabb', 4],
  [2, 'axabb', 3],
  [2, 'aaxbb', 3],
  [2, 'aabxb', 3],
  [2, 'aabbx', 4],
  [2, 'aabbb', 5],
  [2, 'ababb', 5],
  [2, 'abbab', 5],
  [2, 'abbba', 5],
  [2, 'eceba', 3],
  [2, 'abcbbbbcccbdddadacb', 10],
  [3, 'abcadcacacaca', 11]
].each do |k, s, exp|
  act = longest k, s
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " longest #{k}, #{s} = #{act}"
end
