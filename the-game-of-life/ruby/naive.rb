#!/usr/bin/env ruby

def populated_cells row, cols
  count = 0
  cols.each { |j|
    next if j < 0 || row.length <= j
    count += 1 if row[j]
  }
  return count
end

def neighbors curr, i, j
  count = 0
  if 0 < i
    count += populated_cells curr[i-1], [j-1, j, j+1]
  end
  count += populated_cells curr[i], [j-1, j+1]
  if i < curr.length - 1
    count += populated_cells curr[i+1], [j-1, j, j+1]
  end
  return count
end

def step curr
  succ = curr.map { |row| row.map { |_| false } }
  curr.each_with_index { |row, i|
    row.each_with_index { |cell, j|
      count = neighbors curr, i, j
      if count == 3 || cell && count == 2
        succ[i][j] = true
      end
    }
  }
  return succ
end

# def hash_to_matrix h, rows, cols
#   (0...rows).map { |r|
#     (0...cols).map { |c|
#       !!h[r] && !!h[r][c]
#     }
#   }
# end

# def main
#   [ [ { 0 => { 2 => true },
#         1 => { 1 => true },
#         2 => { 2 => true } },
#       4, 4,
#       { 1 => { 1 => true, 2 => true } } ]
    
#   ].each do |curr, rows, cols, e|
#     curr = hash_to_matrix curr, rows, cols
#     e = hash_to_matrix e, rows, cols
#     a = step curr
#     print "step #{curr} = #{a} ... "
#     if a == e
#       puts 'PASS'
#     else
#       puts 'FAIL'
#     end
#   end
# end

def main
  rows, cols = readline.split(' ').map(&:to_i)
  curr = (1..rows).map { |_| (1..cols).map { |_| false } }
  n = readline.to_i
  (1..n).each { |_|
    r, c = readline.split(' ').map(&:to_i)
    curr[r][c] = true
  }
  s = readline.to_i
  (1..s).each { |_| curr = step curr }
  curr.each_with_index { |row, i| row.each_with_index { |cell, j| puts "#{i} #{j}" if cell } }
end

main
