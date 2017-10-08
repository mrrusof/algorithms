#!/usr/bin/env ruby

require_relative './read-graph.rb'

def bfs_step fq, vs, vt, g
  p = fq.delete_at 0
  g[p].each do |child|
    next if vs[child]
    return true if vt[child]
    vs[child] = true
    fq << child
  end
  return false
end

def bidirectional_search s, t, g
  return true if s == t
  vs = {s => true}
  vt = {t => true}
  fs = [s]
  ft = [t]
  while !(fs.empty? || ft.empty?)
    return true if bfs_step fs, vs, vt, g
    return true if bfs_step ft, vt, vs, g
  end
  return false
end

n = readline.to_i

while (n -= 1) >= 0
  s, t = readline.strip.split(' ').map(&:to_i)
  g = read_graph
  puts bidirectional_search s, t, g
end
