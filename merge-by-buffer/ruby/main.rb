#!/usr/bin/env ruby

def merge_by_buffer p, s, l
  i = l - 1
  j = s.length - 1
  t = p.length - 1
  while i >= 0 or j >= 0
    if i >= 0 and j >= 0
      if p[i] > s[j]
        p[t] = p[i]
        i -= 1
      else
        p[t] = s[j]
        j -= 1
      end
    elsif i >= 0
      p[t] = p[i]
      i -= 1
    else
      p[t] = s[j]
      j -= 1
    end
    t -= 1
  end
  t += 1
  h = 0
  while t < p.length
    p[h] = p[t]
    h += 1
    t += 1
  end
  return h
end

while true
  l = readline.strip.to_i rescue break
  p = readline.strip.split(' ').map(&:to_i) rescue break
  s = readline.strip.split(' ').map(&:to_i) rescue break
  puts merge_by_buffer(p, s, l)
  puts p.join(' ')
end
