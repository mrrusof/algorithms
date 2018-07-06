#!/usr/bin/env ruby

def column_prefix_sum m
  (0...m.length).map do |col|
    acc = 0
    [0] + (0...m.length).map do |row|
      acc += m[row][col]
    end
  end
end

def max_subarray a
  max = nil
  b = e = nil
  max_here_b = max_here = 0
  a.each_with_index do |n, i|
    max_here += n
    if max == nil || max < max_here
      max = max_here
      b = max_here_b
      e = i
    end
    if max_here < 0
      max_here = 0
      max_here_b = i + 1
    end
  end
  return [b, e, max]
end

def max_matrix m
  cps = column_prefix_sum m
  puts
  cps.each { |r| puts r.inspect }
  puts
  mr1 = mr2 = mc1 = mc2 = 0
  max = nil
  (0...m.length).each do |r1|
    (r1 + 1..m.length).each do |r2|
      row_values = (0...m.length).map { |c| cps[c][r2] - cps[c][r1] }
      c1, c2, max_here = max_subarray row_values
      if max == nil || max < max_here
        max = max_here
        mr1 = r1
        mr2 = r2 - 1
        mc1 = c1
        mc2 = c2
      end
    end
  end
  return [mr1, mc1, mr1, mc2, max]
end

def test m
  m.each { |row| puts row.inspect }
  puts max_matrix(m).inspect
  puts
end

test [ [-1, -1, 0, 0],
       [1, 1, 1, 0],
       [1, 1, 2, 0],
       [0, 0, 0, 0] ]

test [ [-1, -1, 0, 0],
       [-2, 1, 1, 0],
       [1, 1, 2, 0],
       [0, 0, 0, 0] ]

test [ [-12, -13, -10, -20],
       [-21, -14, -15, -30],
       [-11, -24, -2, -40],
       [-80, -90, -60, -10] ]
