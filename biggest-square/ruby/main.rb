#!/usr/bin/env ruby

def longest_horizontal m
  m.map do |row|
    longest = 0
    (m.length - 1).downto(0).map do |i|
      if row[i] == 0
        longest = 0
      else
        longest += 1
      end
    end.reverse
  end
end

def transpose m
  (0...m.length).map do |col|
    (0...m.length).map do |row|
      m[row][col]
    end
  end
end

def longest_vertical m
  transpose(longest_horizontal(transpose(m)))
end

def biggest_square m
  h = longest_horizontal m
  v = longest_vertical m
  m.length.downto(1).each do |size|
    (0...m.length).each do |row|
      (0...m.length).each do |col|
        sides = [h[row][col],
                 v[row][col],
                 (row + size - 1 < m.length ? h[row + size - 1][col] : 0),
                 (col + size - 1 < m.length ? v[row][col + size - 1] : 0)]
        if size <= sides.min
          return [row, col, size]
        end
      end
    end
  end
end

def test m
  longest_horizontal(m).each { |row| puts row.inspect }
  puts
  longest_vertical(m).each { |row| puts row.inspect }
  puts
  puts biggest_square(m).inspect
  puts
end

test [ [0, 1, 1, 1],
       [0, 1, 1, 0],
       [1, 1, 0, 0],
       [0, 1, 0, 1] ]

test [ [0, 1, 1, 1],
       [0, 1, 1, 0],
       [1, 1, 1, 0],
       [0, 1, 0, 1] ]

test [ [0, 1, 1, 1],
       [0, 1, 1, 0],
       [1, 1, 1, 1],
       [0, 1, 0, 1] ]

test [ [0, 1, 1, 1],
       [0, 1, 1, 1],
       [1, 1, 1, 1],
       [0, 1, 0, 1] ]
