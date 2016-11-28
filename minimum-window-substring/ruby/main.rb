#!/usr/bin/env ruby

=begin

Given a string S and a string T, find the minimum window in S which
will contain all the characters in T in complexity O(n).

For example,
S = "ADOBECODEBANC"
T = "ABC"
Minimum window is "BANC".

Note: If there is no such window in S that covers all characters in T,
return the empty string "".

If there are multiple such windows, you are guaranteed that there will
always be only one unique minimum window in S.

=end

def mws s, t
  rc = {}
  t.chars.each do |r|
    if rc.has_key? r
      rc[r] += 1
    else
      rc[r] = 1
    end
  end
  rq = []
  er = rc.values.reduce(0) { |acc, v| acc + v }
  # find first window
  s.chars.each_with_index do |l, i|
    if rc.has_key? l # l is a runner
      rc[l] -= 1
      rq << [l, i]
      if rc[l] >= 0 # runner is not repeated
        er -= 1
        break if er == 0 # close the window
      end
    end
  end
  return "" if er > 0
  # contract first window
  while true
    nr = rq.first.first
    break if rc[nr] == 0
    rc[nr] += 1
    rq.delete_at 0
  end
  min_left = rq.first[1]
  min_right = rq[-1][1]
  min_size = min_right - min_left
  # find a smaller window
  right = min_right
  s.chars[right+1..-1].each do |l|
    # expand
    right += 1
    if rc.has_key? l # l is a runner
      rq << [l, right]
      rc[l] -= 1
    end
    # contract
    while true
      nr = rq.first.first
      break if rc[nr] == 0
      rc[nr] += 1
      rq.delete_at 0
    end
    left = rq.first[1]
    if right - left < min_size
      min_size = right - left
      min_left = left
      min_right = right
    end
  end
  return s.chars[min_left..min_right].join
end

[ [ 'ADOBECODEBANC', 'ABC', 'BANC' ],
  [ 'bba', 'ab', 'ba' ],
  [ 'aa', 'aa', 'aa' ],
  [ 'aa', 'a', 'a' ],
  [ 'aa', 'b', '' ]
].each do |s, t, exp|
  act = mws s, t
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " mws #{s}, #{t} = #{act}"
end
