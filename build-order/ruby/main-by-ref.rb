#!/usr/bin/env ruby

def ts r, g, path, done, sort
  return false if path[r]
  return true if done[r]
  path[r] = true
  return false if ! g[r].all? { |c| ts c, g, path, done, sort }
  path.delete r
  sort << r
  done[r] = true
  return true
end

def topological_sort nn, g
  done = {}
  path = {}
  sort = []
  return false if ! nn.all? { |n| ts n, g, path, done, sort }
  return sort
end  

def graph nn, ee
  g = {}
  nn.each { |n| g[n] = [] }
  ee.each { |a, b| g[b] << a }
  return g
end

def main
  while true
    p = readline.strip.split(' ').map(&:to_i) rescue return
    n = readline.strip.to_i rescue return
    d = (1..n).map do |_|
      readline.strip.split(' ').map(&:to_i) rescue return
    end
    g = graph p, d
    puts (if (s = topological_sort p, g) then s.join(' ') else false end)
  end
end

main
