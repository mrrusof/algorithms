#!/usr/bin/env ruby

def read_graph
  n = readline.to_i
  g = {}
  while (n -= 1) >= 0
    a, b = readline.strip.split(' ').map(&:to_i)
    g[a] ||= []
    g[a] << b
    g[b] ||= []
    g[b] << a
  end
  return g
end
