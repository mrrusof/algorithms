#!/usr/bin/env ruby

=begin

Given a 2d grid map of '1's (land) and '0's (water), count the
number of islands.  An island is surrounded by water and is formed by
connecting adjacent lands horizontally or vertically.  You may assume
all four edges of the grid are all surrounded by water.

Example 1:

11110
11010
11000
00000

Answer: 1

Example 2:

11000
11000
00100
00011

Answer: 3

=end

def explore_island m, v, i, j
  w = [[i, j]]
  v[i][j] = true
  while not w.empty?
    i, j = w.pop
    if j > 0 and m[i][j-1] == 1 and !v[i][j-1]
      w << [i, j-1]
      v[i][j-1] = true
    end
    if j + 1 < m[i].length and m[i][j+1] == 1 and !v[i][j+1]
      w << [i, j+1]
      v[i][j+1] = true
    end
    if i > 0 and m[i-1][j] == 1 and !v[i-1][j]
      w << [i-1, j]
      v[i-1][j] = true
    end
    if i + 1 < m.length and m[i+1][j] == 1 and !v[i+1][j]
      w << [i+1, j]
      v[i+1][j] = true
    end
  end
end

def count_islands m
  v = m.map { |r| r.map { |_| false }}
  c = 0
  m.each_with_index do |r, i|
    r.each_with_index do |l, j|
      if l == 1 and !v[i][j]
        explore_island m, v, i, j
        c += 1
      end
    end
  end
  return c
end

def main
  n = readline.strip.to_i
  m = []
  while n > 0
    m << readline.strip.chars.map { |e| e.to_i }
    n -= 1
  end
  m.each { |r| puts "#{r}" }
  puts count_islands m
end

main
