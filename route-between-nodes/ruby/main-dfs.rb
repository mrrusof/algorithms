#!/usr/bin/env ruby

require_relative './read-graph.rb'

def dfs s, t, g
  touched = {s => true}
  work_stack = [s]
  while not work_stack.empty?
    c = work_stack.pop
    return true if c == t
    g[c].each do |child|
      next if touched[child]
      touched[child] = true
      work_stack.push child
    end
  end
  return false
end

n = readline.to_i

while (n -= 1) >= 0
  s, t = readline.strip.split(' ').map(&:to_i)
  g = read_graph
  puts dfs s, t, g
end
