#!/usr/bin/env ruby

def bo n, g, path, done, acc
  return false if !acc
  return acc if done[n]
  return false if path[n]
  path[n] = true
  acc = g[n].reduce(acc) do |acc, c|
    bo c, g, path, done, acc
  end
  return false if !acc
  path.delete n
  acc << n
  done[n] = true
  return acc
end

def build_order p, d
  g = {}
  p.each { |n| g[n] = [] }
  d.each { |a, b| g[b] << a }
  done = {}
  path = {}
  acc = p.reduce([]) { |acc, n| bo n, g, path, done, acc }
  return false if !acc
  return acc
end

def main
  while true
    p = readline.strip.split(' ').map(&:to_i) rescue return
    n = readline.strip.to_i rescue return
    d = (1..n).map do |_|
      readline.strip.split(' ').map(&:to_i) rescue return
    end
    puts (if r = build_order(p, d) then r.join(' ') else r end)
  end
end

main
