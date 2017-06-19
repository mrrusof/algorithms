#!/usr/bin/env ruby

def substituted? a, b # |a| = |b|
  i = 0
  found_diff = false
  while i < a.length
    if a[i] != b[i]
      return false if found_diff
      found_diff = true
    end
    i += 1
  end
  return true
end

def add? a, b # |a| = |b| + 1
  apos = bpos = 0
  skipped = false
  while bpos < b.length
    if a[apos] != b[bpos]
      return false if skipped
      skipped = true
    else
      bpos += 1
    end
    apos += 1
  end
  return true
end

def at_most_one_diff? a, b
  return true if a == b # O(n)
  if a.length == b.length
    return substituted? a, b
  elsif a.length == b.length + 1
    return add? a, b
  elsif a.length + 1 == b.length
    return add? b, a
  end
  return false
end

while true
  a = readline.strip rescue break
  b = readline.strip rescue break
  puts at_most_one_diff? a, b
end
