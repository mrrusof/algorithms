#!/usr/bin/env ruby

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
  mr1 = mr2 = mc1 = mc2 = 0
  max = nil
  (0...m.length).each do |r1|
    col_sum = [0] * m.length
    (r1...m.length).each do |r2|
      col_sum.map!.with_index { |v, c| v + m[r2][c] }
      c1, c2, max_here = max_subarray col_sum
      if max == nil || max < max_here
        max = max_here
        mr1 = r1
        mr2 = r2
        mc1 = c1
        mc2 = c2
      end
    end
  end
  return [mr1, mc1, mr1, mc2, max]
end

def test m
  m.each { |row| puts row.inspect }
  puts
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
