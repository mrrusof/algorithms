#!/usr/bin/env ruby

def increase_cells row, cells, cols
  cells.each { |c|
    next if c < 0 || c >= cols
    row[c] ||= 0
    row[c] += 1
  }
end

def step curr, rows, cols
  neighbors = {}
  curr.each { |r, row|
    row.each { |c, _|
      if r - 1 >= 0
        increase_cells (neighbors[r - 1] ||= {}), [c - 1, c, c + 1], cols
      end
      if r + 1 < rows
        increase_cells (neighbors[r + 1] ||= {}), [c - 1, c, c + 1], cols
      end
      increase_cells (neighbors[r] ||= {}), [c - 1, c + 1], cols
    }
  }
  succ = {}
  neighbors.each { |r, row|
    row.each { |c, count|
      if count == 3 || !!curr[r] && !!curr[r][c] && count == 2
        succ[r] ||= {}
        succ[r][c] = true
      end
    }
  }
  return succ
end

# def main
#   [ [ { 0 => { 2 => true },
#         1 => { 1 => true },
#         2 => { 2 => true } },
#       4, 4,
#       { 1 => { 1 => true, 2 => true } } ]
    
#   ].each do |curr, rows, cols, e|
#     a = step curr, rows, cols
#     print "step #{curr}, #{rows}, #{cols} = #{a} ... "
#     if a == e
#       puts 'PASS'
#     else
#       puts 'FAIL'
#     end
#   end
# end

def main
  rows, cols = readline.split(' ').map(&:to_i)
  curr = {}
  n = readline.to_i
  (1..n).each { |_|
    r, c = readline.split(' ').map(&:to_i)
    curr[r] ||= {}
    curr[r][c] = true
  }
  s = readline.to_i
  (1..s).each { |_| curr = step curr, rows, cols }
  curr.each { |i, row| row.each { |j, cell| puts "#{i} #{j}" if cell } }
end

main
