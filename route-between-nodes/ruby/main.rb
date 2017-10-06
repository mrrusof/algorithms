#!/usr/bin/env ruby

def bfs_step nn, rq, v, g, vt
  nn.each do |n|
    next if v[n]
    return true if vt[n]
    v[n] = true
    rq << n
  end
  return false if rq.empty?
  return g[rq.delete_at 0]
end

def bidirectional_search s, t, g
  nns = [s]
  nnt = [t]
  vs = {}
  vt = {}
  rqs = []
  rqt = []
  while true
    ss = bfs_step nns, rqs, vs, g, vt
    return ss if !!ss == ss
    nns = ss
    st = bfs_step nnt, rqt, vt, g, vs
    return st if !!st == st
    nnt = st
  end
end

g = {0 => [1, 2],
     1 => [0, 3],
     2 => [0],
     3 => [1, 4],
     4 => [3]}
puts bidirectional_search 0, 4, g

g = {0 => [1, 2, 3],
     1 => [0],
     2 => [0],
     3 => [0, 4, 6],
     4 => [3, 5],
     5 => [4, 9],
     6 => [3, 7],
     7 => [6, 8, 9],
     8 => [7, 9],
     9 => [5, 7, 8]}
puts bidirectional_search 0, 9, g

g = {0 => [1, 2, 3],
     1 => [0],
     2 => [0],
     3 => [0, 6],
     4 => [5],
     5 => [4, 9],
     6 => [3, 7],
     7 => [6, 8, 9],
     8 => [7, 9],
     9 => [5, 7, 8]}
puts bidirectional_search 0, 9, g

g = {0 => [1, 2, 3],
     1 => [0],
     2 => [0],
     3 => [0, 6],
     4 => [5],
     5 => [4, 9],
     6 => [3],
     7 => [8, 9],
     8 => [7, 9],
     9 => [5, 7, 8]}
puts bidirectional_search 0, 9, g
