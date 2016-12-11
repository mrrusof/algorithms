#!/usr/bin/env ruby

=begin

For each non-empty prefix of a given string, find the first
non-repeated character if any.

**Examples.**

'a' -> 'a'
'aa' -> 'a'
'ab' -> 'ab'
'aab' -> 'ab'

=end

def first_non_repeated_prefix s
  return nil if s == ''
  o = ''
  l = 0
  h = {}
  s.chars.each_with_index do |c, i|
    if not h.has_key? c
      h[c] = :not_repeated
    else
      h[c] = :repeated
    end
    while l <= i and h[s[l]] == :repeated
      l += 1
    end
    o += s[l] if l < i or h[s[l]] == :not_repeated
  end
  return o
end

# while true
#   s = readline.strip rescue break
#   puts first_non_repeated_prefix(s)
# end

[ ['', nil],
  ['a', 'a'],
  ['aa', 'a'],
  ['ab', 'aa'],
  ['aab', 'ab'],
  ['abc', 'aaa'],
  ['abac', 'aabb'],
  ['ababc', 'aabc'],
  ['ababcbc', 'aabcc'],
  ['ababcdc', 'aabccd']
].each do |s, exp
|
  act = first_non_repeated_prefix s
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " first_non_repeated_prefix \"#{s}\" = #{act.inspect} (#{exp.inspect})"
end
