#!/usr/bin/env ruby

require_relative 'animation'

def build_pi pattern
  pi = Array.new(pattern.length, 0) # Array of zeroes of length |pattern|
  m = 0
  (1...pattern.length).each do |k|
    while m > 0 && pattern[m] != pattern[k]
      m = pi[m - 1]
    end
    if pattern[m] == pattern[k]
      m += 1
    end
    pi[k] = m
  end
  return pi
end

def draw_indexes animation
  index_grid = Grid.new x_margin: 15
  (0..9).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
  index_grid = Grid.new x_margin: 13
  (10..19).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i + 10, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
end

$pi_grid = Grid.new x_margin: 15, y_margin: 25

def draw_pi a, left, y, p, pleft=left
  (p-1).downto(0).each { |i|
    Text.new(a, '001230120'[i], x: pleft + i, y: y, color: 'purple', bold: true, size: 16, grid: $pi_grid).movex(left + i).draw
  }
end

def index_of pattern, text

  a = animation = Animation.new 'implementation', 400, 200
  tt = Text.new(animation, text, y: 2).draw
  pt = Text.new(animation, pattern, color: 'gray60', y: 3).draw
  draw_indexes animation
  index_grid = Grid.new x_margin: 15, y_margin: 25
  qt = Text.new(animation, 'q', color: 'purple', bold: true, grid: index_grid, size: 16).draw
  kt = Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, y: 5).draw
  pilabel = Text.new(a, '(Pi)', x: 17, y: 4, color: 'purple', bold: true, size: 16, grid: $pi_grid).draw
  draw_pi a, 0, 4, 9
  animation.next

  pi = build_pi pattern
  k = 0
  (0...text.length).each do |q|

    qt.movex(q).draw
    kt.movex(q).draw

    while k > 0 && pattern[k] != text[q]

      Text.new(animation, pattern[k], color: 'red', x: q, y: 3).draw
      animation.frame.delay = 100
      animation.next
      animation.frame.erase!

      prev_k = k
      k = pi[k - 1]

      qt.putx(q).draw
      kt.putx(q).draw
      draw_pi a, q - prev_k, 4, 9
      pilabel.draw
      tt.draw
      pt.putx(q - prev_k).draw
      draw_indexes animation
      Text.new(animation, '^', color: 'blue', x: q - 1, y: 5).draw
      if k > 0
        Text.new(animation, pattern[0...k], color: 'blue', x: q - prev_k, y: 3).draw
      else
        Text.new(animation, '_', color: 'blue', x: q - prev_k - 1, y: 3).draw
      end
      animation.frame.delay = 100
      animation.next
      animation.frame.erase!

      qt.putx(q).draw
      kt.putx(q).draw
      draw_pi a, q - k, 4, 9
      tt.draw
      pt.putx(q - k).draw
      draw_indexes animation
      if k > 0
        Text.new(animation, pattern[0...k], color: 'blue', x: q - k, y: 3).draw
      else
        pilabel.movex(0)
      end
      pilabel.draw
      animation.frame.delay = 100
      animation.next

    end

    if pattern[k] == text[q]
      Text.new(animation, pattern[k], color: 'green', x: q, y: 3).draw
      animation.next
      if k + 1 == pattern.length
        animation.frame.delay = 200
        animation.write
        return q - k 
      end
      k += 1
    end

  end
  return -1
end

def main
  text = readline.strip
  pattern = readline.strip
  puts index_of pattern, text
end

main
