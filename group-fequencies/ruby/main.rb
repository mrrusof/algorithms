#!/usr/bin/env ruby

def sum_reachable g, c, v, f
  return nil if !g[c]
  work = [c]
  v[c] = true
  s = f[c]
  while !work.empty?
    p = work.pop
    g[p].each do |c|
      next if v[c]
      work << c
      v[c] = true
      s += f[c]
    end             
  end
  return s
end

def group_frequencies freqs, eqs # O(A + B + C + D) = O(|F| + |E| + |F| + |F| + |E|) = O(|F| + |E|)
  rf = []
  g = {}
  visited = {}
  freqs = freqs.to_h # A: |F|
  eqs.each do |a, b| # B: |E|
    g[a] ||= []
    g[a] << b
    g[b] ||= []
    g[b] << a
  end
  freqs.each do |n, f| # C: |F|, not multiplied by D
    next if !!visited[n]
    s = sum_reachable g, n, visited, freqs # D: |F| + |E| in total
    if !!s
      rf << [n, s]
    else
      rf << [n, f]
    end
  end
  return rf
end

def main
  [
    [ [ ['a', 1],
        ['aa', 2],
        ['b', 4] ],
      [ ['a', 'aa'] ],
      [ ['a', 3],
        ['b', 4] ] ],
    [ [ ['a', 1],
        ['aa', 2] ],
      [ ['b', 'bb'] ],
      [ ['a', 1],
        ['aa', 2] ] ],
    [ [ ['a', 1],
        ['aa', 2],
        ['c', 5]],
      [ ['aa', 'a'],
        ['aa', 'c'] ],
      [ ['a', 8] ] ],
    [ [ ['a', 1],
        ['aa', 2],
        ['c', 5]],
      [ ['aa', 'a'],
        ['c', 'aa'] ],
      [ ['a', 8] ] ],
    [ [ ['a1', 10],
        ['a2', 3],
        ['a3', 9],
        ['a4', 11],
        ['x', 2],
        ['b1', 3],
        ['b2', 5],
        ['c1', 8],
        ['c2', 2] ],
      [ ['a3', 'a1'],
        ['a2', 'a4'],
        ['a4', 'a1'],
        ['b1', 'b2'],
        ['c2', 'c1'] ],
      [ ['a1', 33],
        ['x', 2],
        ['b1', 8],
        ['c1', 10] ] ]
  ].each do |freqs, eqs, exp|
    act = group_frequencies freqs, eqs
    print "group_frequencies #{freqs}, #{eqs} = #{act} ... "
    if act == exp
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

main
