#!/usr/bin/env ruby

def all_unique s
  ll = {}
  s.each do |l|
    if !!ll[l]
      return false
    end
    ll[l] = true
  end
  return true
end

[
  [ [1,2,3,4],
    true ],
  [ [1,2,1,4],
    false ]
].each do |s, e|
  puts "#{s} -> #{all_unique s} (#{e})"
end

def all_unique_chars s
  ll = {}
  s.chars.each do |l|
    if !!ll[l]
      return false
    end
    ll[l] = true
  end
  return true
end

[
  [ "tacos",
    true ],
  [ "tecolote",
    false ]
].each do |s, e|
  puts "#{s} -> #{all_unique_chars s} (#{e})"
end

def swap s, l, r
  t = s[l]
  s[l] = s[r]
  s[r] = t
end

def partition s, l, r
  p = s[r]
  r -= 1
  b = l
  e = r
  while l < r
    while b < r && p <= s[r] do r -= 1 end
    while l < e && s[l] <= p do l += 1 end
    swap s, l, r if l < r
  end
  if p <= s[l]
    swap s, l, e + 1 
    return l
  else
    return e + 1
  end
end

def quicksort! s, l, r
  return if r - l < 1
  m = partition s, l, r
  quicksort! s, l, m - 1
  quicksort! s, m + 1, r
end

[
  [5,6,6,7,6],
  [5,6,1,4,3,7,9],
  [1,2,3,4]
].each do |a|
  print "quicksort #{a} = "
  quicksort! a, 0, a.length - 1
  puts "#{a}"
end

def all_unique_chars_n_log_n s
  ll = s.chars
  quicksort! ll, 0, ll.length - 1
  (0...(ll.length - 1)).each do |i|
    return false if ll[i] == ll[i+1]
  end
  return true
end

[
  [ "tacos",
    true ],
  [ "tecolote",
    false ]
].each do |s, e|
  puts "#{s} -> #{all_unique_chars_n_log_n s} (#{e})"
end
