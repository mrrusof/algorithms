#!/usr/bin/env ruby

=begin

Given a string, find the length of the longest substring
without repeating characters.

Examples:

Given "abcabcbb", the answer is "abc", which the length is 3.

Given "bbbbb", the answer is "b", with the length of 1.

Given "pwwkew", the answer is "wke", with the length of 3. Note that
the answer must be a substring, "pwke" is a subsequence and not a
substring.

=end

def lsworc s
  i = 0
  max_len = 0
  cc = {}
  s.chars.each_with_index do |c, j|
    if !!cc[c]
      # contract window
      while s[i] != c
        cc[s[i]] = false
        i += 1
      end
      i += 1
    end
    # expand window
    cc[c] = true
    # select longest
    max_len = [max_len, j + 1 - i].max
  end
  return max_len
end

[ ['abc', 3],
  ['abcabcbb', 3],
  ['bbb', 1],
  ['', 0],
  ['pwwkew', 3],
  ['abcde', 5],
  ['ababc', 3],
  ['abcaxyz', 6],
  ['abcbae', 4]
].each do |s, exp|
  act = lsworc s
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " lsworc #{s} = #{act}"
end
