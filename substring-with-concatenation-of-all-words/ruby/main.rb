#!/usr/bin/env ruby

=begin

You are given a string, s, and a list of words, words, that are all of
the same length. Find all starting indices of substring(s) in s that
is a concatenation of each word in words exactly once and without any
intervening characters.

For example, given:
s: "barfoothefoobarman"
words: ["foo", "bar"]

You should return the indices: [0,9].
(order does not matter).

=end

def reset_word_count wc, ww
  ww.each { |w| if wc.has_key? w then wc[w] += 1 else wc[w] = 1 end }
end

def do_the_counting offset, l, s, ww
  # puts "s = #{s}"
  i = 0
  tt = []
  while i + l - 1 < s.length
    tt << s[i..i+l-1]
    i += l
  end
  # puts "tt = #{tt}"
  o = []
  ttq = []
  wc = {}
  reset_word_count wc, ww
  tt.each_with_index do |t, i|
    # puts "1 ttq = #{ttq}"
    # puts "1 wc = #{wc}"
    # expand
    ttq << [t, i * l + offset]
    if wc.has_key? t
      wc[t] -= 1
    end
    # puts "2 ttq = #{ttq}"
    # puts "2 wc = #{wc}"
    # contract
    if ttq.length > ww.length
      h, _ = ttq.delete_at 0
      # puts "del h = #{h}"
      if wc.has_key? h
        wc[h] += 1
      end
    end
    # puts "3 ttq = #{ttq}"
    # puts "3 wc = #{wc}"
    if wc.all? { |k, v| v == 0 }
      o << ttq.first[1]
    end
    # puts "o = #{o}"
  end
  # puts "o = #{o}"
  return o
end

def swcoaw s, ww
  l = ww.first.length
  return (0..l-1).reduce([]) { |o, i| o + do_the_counting(i, l, s[i..-1], ww) }
end

[ [ "barfoothefoobarman", ["foo", "bar"], [0,9] ],
  [ "bbarfoothefoobarman", ["foo", "bar"], [1,10] ],
  [ "foom", ["foo"], [0] ],
  [ "foom", ["oom"], [1] ],
  [ "barfoofoobarthefoobarman", ["bar","foo","the"], [6,9,12] ]
].each do |s, ww, exp|
  act = swcoaw s, ww
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " swcoaw '#{s}', #{ww} = #{act}"
end
