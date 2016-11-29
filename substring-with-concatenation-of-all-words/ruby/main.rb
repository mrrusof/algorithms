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

def do_et offset, l, s, ww
  i = 0
  tt = []
  while i + l - 1 < s.length
    tt << s[i..i+l-1]
    i += l
  end
  o = []
  ttq = []
  wc = {}
  ww.each { |w| if wc.has_key? w then wc[w] += 1 else wc[w] = 1 end }
  zc = wc.length
  tt.each_with_index do |t, i|
    # expand
    ttq << [t, i * l + offset]
    if wc.has_key? t
      if wc[t] == 1
        zc -= 1
      elsif wc[t] == 0
        zc += 1
      end
      wc[t] -= 1
    end
    # contract
    if ttq.length > ww.length
      h, _ = ttq.delete_at 0
      if wc.has_key? h
        if wc[h] == -1
          zc -= 1
        elsif wc[h] == 0
          zc += 1
        end
        wc[h] += 1
      end
    end
    # check
    if zc == 0
      o << ttq.first[1]
    end
  end
  return o
end

def swcoaw s, ww
  return [] if ww.length == 0
  l = ww.first.length
  return (0..l-1).reduce([]) { |o, i| o + do_et(i, l, s[i..-1], ww) }
end

# For the blog
#
# def main
#   s = readline rescue abort('Could not read string.')
#   ww = readline.split(' ') rescue abort('Could not read words.')
#   puts swcoaw(s, ww).join(' ')
# end

# main

[ [ "barfoothefoobarman", ["foo", "bar"], [0,9] ],
  [ "barfoomanthefoobar", ["foo", "bar"], [0,12] ],
  [ "barthefoomanfoothebar", ["foo", "bar"], [] ],
  [ "bbarfoothefoobarman", ["foo", "bar"], [1,10] ],
  [ "bartfoomfootbar", ["foo", "bar"], [] ],
  [ "bartfoomfoobar", ["foo", "bar"], [8] ],
  [ "bartfoomf ob r", ["foo", "bar"], [] ],
  [ "foofoofoo", ["foo", "foo"], [0,3] ],
  [ "foofoofoo", [], [] ],
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
