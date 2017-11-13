#!/usr/bin/env ruby

def cmp a, b
  if (d = a[0] - b[0]) == 0
    return a[1] - b[1]
  end
  return d
end

def fits a, b
  return a[0] <= b[0] && a[1] <= b[1]
end

def max_height pp
  pp = pp.sort {|a, b| cmp a, b }
  h = pp.map {|_| nil }
  i = 0
  while i < pp.length
    j = 0
    max = 1
    while j < i
      if !fits pp[j], pp[i]
        j += 1
        next
      end
      height_here = 1 + h[j]
      if max < height_here
        max = height_here
      end
      j += 1
    end
    h[i] = max
    i += 1
  end
  return h.max
end

def main
  [ [ [ [65, 100],
        [56, 90],
        [68, 110],
        [60, 95] ], 4 ],
    [ [ [65, 100],
        [56, 90],
        [68, 99],
        [60, 95] ], 3 ]
  ].each do |i, e|
    a = max_height i
    print "max_height #{i} = #{a} ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

main
