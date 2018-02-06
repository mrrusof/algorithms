#!/usr/bin/env ruby

require_relative 'animation'

def draw_indexes animation, left
  index_grid = Grid.new x_margin: 15
  (0...9).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: left + i, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
end

$pi_grid = Grid.new x_margin: 15, y_margin: 25

def draw_pi a, left, y, p, pleft=left
  (p-1).downto(0).each { |i|
    Text.new(a, '001230120'[i], x: pleft + i, y: y, color: 'purple', bold: true, size: 16, grid: $pi_grid).movex(left + i).draw
  }
end

def color a, p, left, x, m, c
  Text.new(a, p[m], x: left + x, y: 4, color: 'white').movex(0)
  Text.new(a, p[m], x: left + x, y: 4, color: c).draw
end

def green a, p, left, x, m
  color a, p, left, x, m, 'green'
end

def red a, p, left, x, m
  color a, p, left, x, m, 'red'
end

def build_pi pattern

  left = 1

  a = Animation.new 'build-pi', 400, 215
  draw_indexes a, left
  patref = Text.new(a, pattern, x: left, y: 2)
  pat = Text.new(a, pattern, x: left + 1, y: 4, color: 'gray60')

  counters_grid = Grid.new x_margin: 15, y_margin: 25

  kt = Text.new(a, 'k', color: 'purple', bold: true, grid: counters_grid, size: 16)
  mt = Text.new(a, 'm', color: 'purple', bold: true, grid: counters_grid, size: 16)
  mt2 = Text.new(a, 'm', y: 6, color: 'purple', bold: true, grid: counters_grid, size: 16)

  pilabel = Text.new(a, '(Pi)', x: 17, y: 3, color: 'purple', bold: true, size: 16, grid: $pi_grid)

  pilabel.draw
#  pilabel.puty(5).draw
  patref.draw
  kt.putx(left).draw
#  mt.putx(left - 1).draw
  draw_pi a, left, 3, 0

  a.frame.delay = 100
  a.next

  draw_pi a, left, 3, 1

  a.frame.delay = 150
  a.next

  kt.movex(left + 1).draw
  mt.movex(left).draw
  pat.draw
  draw_pi a, left + 1, 5, 1
  mt2.movex(left + 1).draw

  a.frame.delay = 100
  a.next

  pi = Array.new(pattern.length, 0) # Array of zeroes of length |pattern|
  m = 0
  (1...pattern.length).each do |k|

    kt.movex(left + k).draw
    mt.movex(left + m).draw
    mt2.movex(left + k).draw

    while m > 0 && pattern[m] != pattern[k]

      red a, pattern, left, k, m
      a.frame.delay = 150
      a.next

      prev_m = m
      m = pi[m - 1]

      pat.movex(left + k - prev_m).draw
      if m > 0
        Text.new(a, pattern[0...m], x: left + k - prev_m, y: 4, color: 'blue').draw
      else
        Text.new(a, '_', x: left + k - prev_m - 1, y: 4, color: 'blue').draw
      end
      ba = Text.new(a, '^', x: left + k - 1, y: 6, color: 'blue').draw
      a.frame.delay = 100
      a.next

      pat.movex(left + k - m).draw
      Text.new(a, pattern[0...m], x: left + k - m, y: 4, color: 'blue').draw
        Text.new(a, '_', x: left + k - prev_m - 1, y: 4, color: 'blue').movex(0)
      ba.movex(0)
      draw_pi a, left + k - m, 5, k, left + k - prev_m
      mt.movex(left + m).draw
      a.frame.delay = 150
      a.next

    end

    draw_pi a, left, 3, k + 1, left
    draw_pi a, left + k - m, 5, k + 1, left + k - m

    if pattern[m] == pattern[k]
      
      green a, pattern, left, k, m
      a.frame.delay = 100
      a.next

      m += 1
    else

      red a, pattern, left, k, m
      a.frame.delay = 150
      a.next

      if k < pattern.length - 1
        pat.movex(left + k + 1).draw
        draw_pi a, left + k + 1, 5, k + 1, left + k
        kt.movex(left + k + 1).draw
        mt.movex(left).draw
        mt2.movex(left + k + 1).draw
        a.frame.delay = 100
        a.next
      else
        a.frame.delay = 200
      end
    end
    pi[k] = m
  end

  a.write
  return pi
end

def index_of pattern, text

  pi = build_pi pattern

end

def main
  text = readline.strip
  pattern = readline.strip
  index_of pattern, text
end

main
