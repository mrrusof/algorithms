#!/usr/bin/env ruby

require_relative './read-graph.rb'

def bfs s, t, g
  return true if s == t
  v = {s => true}
  frontier_queue = [s]
  while not frontier_queue.empty?
    p = frontier_queue.delete_at 0
    g[p].each do |child|
      next if v[child]
      return true if child == t
      v[child] = true
      frontier_queue << child
    end
  end
  return false
end

n = readline.to_i

while (n -= 1) >= 0
  s, t = readline.strip.split(' ').map(&:to_i)
  g = read_graph
  puts bfs s, t, g
end
