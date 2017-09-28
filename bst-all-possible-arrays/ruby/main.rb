#!/usr/bin/env ruby

def apa children, w, acc, curr
  children[curr].each { |c| w[c] = 1 } if !!children[curr]
  r = []
  if w.empty?
    r << acc + [curr]
  else
    w.keys.each do |k|
      w.delete(k)
      acc.push curr
      r += apa(children, w, acc, k)
      acc.pop
      w[k] = 1
    end
  end
  children[curr].each { |c| w.delete c } if !!children[curr]
  return r
end
        

def main
  n = readline.to_i

  while (n -= 1) >= 0
    m, r = readline.strip.split(' ').map(&:to_i)
    children = {}
    while (m -= 1) >= 0
      p, c = readline.strip.split(' ').map(&:to_i)
      children[p] ||= []
      children[p] << c
    end
    apa(children, Hash.new, [], r).sort.each { |a| puts a.join(' ') }
  end
end

main
