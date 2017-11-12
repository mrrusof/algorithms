#!/usr/bin/env ruby

def group_frequencies freqs, eqs
  bb = {}
  rf = {}
  eqs.each do |s1, s2|
    if !bb[s1] && !bb[s2]
      bb[s1] = s2
      bb[s2] = s2
    elsif !bb[s1]
      bb[s1] = bb[s2]
    elsif !bb[s2]
      bb[s2] = bb[s1]
    end
  end
  freqs.each do |s, f|
    b = bb[s]
    b ||= s
    rf[b] ||= 0
    rf[b] += f
  end
  return rf.to_a
end

def main
  [
    [ [ ['a', 1],
        ['aa', 2],
        ['b', 4] ],
      [ ['a', 'aa'] ] ],
    [ [ ['a', 1],
        ['aa', 2] ],
      [ ['b', 'bb'] ] ],
    [ [ ['a', 1],
        ['aa', 2],
        ['c', 5]],
      [ ['aa', 'a'],
        ['aa', 'c'] ] ],
    [ [ ['a', 1],
        ['aa', 2],
        ['c', 5]],
      [ ['aa', 'a'],
        ['c', 'aa'] ] ]
  ].each do |freqs, eqs|
    puts "group_frequencies #{freqs}, #{eqs} = #{group_frequencies freqs, eqs}"
  end
end

main
