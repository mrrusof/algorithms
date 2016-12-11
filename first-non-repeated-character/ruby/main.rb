#!/usr/bin/env ruby

=begin

For a given string, find the first non-repeated character if any.

**Examples.**

'a' -> 'a'
'aa' -> nil
'ab' -> 'a'
'aab' -> 'b'

=end

def first_non_repeated s
  h = {}
  s.chars.each do |c|
    if not h.has_key? c
      h[c] = :not_repeated
    else
      h[c] = :repeated
    end
  end
  return s.chars.find { |c| h[c] == :not_repeated }
end

# while true
#   s = readline.strip rescue break
#   puts first_non_repeated(s)
# end

[ ['', nil],
  ['a', 'a'],
  ['aa', nil],
  ['ab', 'a'],
  ['aab', 'b']
].each do |s, exp|
  act = first_non_repeated s
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " first_non_repeated \"#{s}\" = #{act.inspect} (#{exp.inspect})"
end
