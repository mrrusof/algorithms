#!/usr/bin/env ruby

def ss a, s, e
  return s if s + 1 == e
  if s + 2 == e
    if a[s] <= a[s+1]
      return s
    else
      return s + 1
    end
  end
  m = (s + e) / 2
  if a[m] < a[e-1]
    return ss a, s, m+1
  elsif a[s] < a[m]
    return ss a, m, e
  else
    p = nil
    if a[s] == a[m]
      p = ss a, s, m+1
    end
    if p == nil
      p = ss a, m, e
    end
    return p
  end
end

def bs a, s, e, n
  return nil if s == e
  m = (s + e) / 2
  wm = m % a.length
  if a[wm] == n
    return wm
  elsif a[wm] < n
    return bs a, m+1, e, n
  else
    return bs a, s, m, n
  end
end

def rotated_search a, n
  return nil if a.length == 0
  s = ss a, 0, a.length
  return bs a, s, a.length + s, n
end

[ [ [],
    1,
    nil ],
  [ [2],
    3,
    nil ],
  [ [2],
    2,
    0 ],
  [ [3, 2],
    2,
    1 ],
  [ [2, 3],
    2,
    0 ],
  [ [3, 2],
    4,
    nil ],
  [ [2, 3],
    4,
    nil ] ].each do |nn, n, e|
  a = rotated_search nn, n
  print "#{nn}, #{n} -> #{if !!a then a else 'nil' end} ("
  if a == e
    puts 'PASS)'
  else
    puts 'FAIL)'
  end
end
