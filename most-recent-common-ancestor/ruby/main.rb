#!/usr/bin/env ruby

def depth n, p
  i = 0
  while !!p[n]
    n = p[n]
    i += 1
  end
  return i
end

def most_recent_common_ancestor a, b, p
  da = depth a, p
  db = depth b, p
  if da < db
    diff = db - da
    while diff > 0
      b = p[b]
      diff -= 1
    end
  elsif db < da
    diff = da - db
    while diff > 0
      a = p[a]
      diff -= 1
    end
  end
  while a != b
    a = p[a]
    b = p[b]
  end
  return a
end

def main
  x, y = readline.strip.split(' ').map(&:to_i)
  n = readline.strip.to_i
  p = {}
  while n > 0
    a, b = readline.strip.split(' ').map(&:to_i)
    p[b] = a
    n -= 1
  end
  puts most_recent_common_ancestor x, y, p
end

main
