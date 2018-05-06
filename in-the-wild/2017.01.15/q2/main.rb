#!/usr/bin/env ruby

ww = readline.strip.split(' ')
ww.sort!
m = readline.strip.to_i
h = {}

while m > 0
  id = readline.strip.to_i
  h[id] ||= 0
  r = readline.strip.delete(',.').downcase.split(' ')
  r.each do |rw|
    c = ww.bsearch { |w| rw <= w }
    if c != nil && c == rw then
      h[id] += 1
    end
  end
  m -= 1
end

res = h.to_a.sort! do |a, b|
  id1, c1 = a
  id2, c2 = b
  if c1 == c2 then
    if id1 < id2 then 1
    elsif id1 == id2 then 0
    else -1 end
  elsif c1 < c2 then 1
  else -1 end
end

puts res.map(&:first).join(' ')
