#!/usr/bin/env ruby

# Ex. 15.1-4: Return the position of the cuts.

def memoized_cut_rod n, p
  r = (0..n).map { |_|  -1 }
  return memoized_cut_rod_aux n, p, r
end

def memoized_cut_rod_aux n, p, r
  return r[n] if r[n] >= 0
  if n == 0
    r[n] = 0
  else
    r[n] = (1..n).map { |i| p[i-1] + memoized_cut_rod_aux(n-i, p, r) }.max
  end
  return r[n]
end

def struct_memoized_cut_rod n, p
  r = (0..n).map { |_| -1 }
  s = (1..n).to_a # position of the first cut
  return struct_memoized_cut_rod_aux(n, p, r, s), s
end

def struct_memoized_cut_rod_aux n, p, r, s
  return r[n] if r[n] >= 0
  if n == 0
    r[n] = 0
  else
    (1..n).each do |i|
      q = struct_memoized_cut_rod_aux(n-i, p, r, s)
      if r[n] < p[i-1] + q
        r[n] = p[i-1] + q
        s[n-1] = i
      end
    end
  end
  return r[n]
end

p = [1,5,8,9,10,17,17,20,24,30]
[ [1, 1, 1, 1],
  [2, 1, 5, 2],
  [3, 1, 8, 3],
  [4, 1, 10, 2],
  [5, 1, 13, 2],
  [6, 1, 17, 6],
  [7, 1, 18, 1],
  [8, 1, 22, 2],
  [9, 1, 25, 3],
  [10, 1, 30, 10],
].each do |n, c, ev, es|
  av, as = struct_memoized_cut_rod n, p
  if av == ev and as[n-1] == es
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " struct_memoized_cut_rod #{n} = #{av}, #{as} (#{ev}, #{es})"
end
