#!/usr/bin/env ruby

require_relative 'animation'

def pattern animation, x, y, index_grid
  Text.new(animation, 'ababacabc', x: x, y: y, color: 'gray75').draw
  Text.new(animation, "(offset #{x})", x: -0.5,  y: y, size: 16, grid: index_grid).draw
  pi animation, x, y + 1
end

def pi animation, x=0, y=4
  index_grid = Grid.new x_margin: 15, y_margin: 25
  (0..4).each { |i|
    Text.new(animation, '00123'[i], x: x + i, y: y, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
  }
  Text.new(animation, '(Pi)', x: -0.5, y: y, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
end

def pat animation, p
  Text.new(animation, 'ababacabc'[0... if p == 9 then 8 else p end], x: 11, y: 8, color: 'green').draw
  Text.new(animation, 'ababacabc'[p..-1], x: 11 + p, y: 8, color: 'gray60').draw
  Text.new(animation, 'c', x: 5 + 8, y: 3, color: 'red').draw if p == 9
end

def main
  animation = Animation.new 'continue-annotate-pattern', 400, 400
  index_grid = Grid.new x_margin: 15
  (0..9).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
  index_grid = Grid.new x_margin: 13
  (10..19).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i + 10, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end

  index_grid = Grid.new x_margin: 15, y_margin: 25
  Text.new(animation, 'q', color: 'purple', bold: true, grid: index_grid, size: 16, x: 13).draw
#  Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, x: 5, y: 5).draw

  Text.new(animation, 'ababaababacababacabc', y: 2).draw
  Text.new(animation, 'ababacab', x: 5, y: 3, color: 'green').draw
  Text.new(animation, 'c', x: 13, y: 3, color: 'red').draw

  pi animation, 5
  animation.frame.delay = 100
  animation.next

  pattern animation, 7, 5, index_grid
  Text.new(animation, 'aba', x: 7, y: 5, color: 'blue').draw
  animation.frame.delay = 75
  animation.next

  Text.new(animation, 'b', x: 10, y: 5, color: 'red').draw
  animation.next

  pattern animation, 9, 7, index_grid
  Text.new(animation, 'a', x: 9, y: 7, color: 'blue').draw
  animation.frame.delay = 75
  animation.next

  Text.new(animation, 'b', x: 10, y: 7, color: 'red').draw
  animation.next

  pattern animation, 10, 9, index_grid
  animation.frame.delay = 75
  animation.next

  Text.new(animation, 'a', x: 10, y: 9, color: 'red').draw
  zt = Text.new(animation, '0', color: 'purple', bold: true, grid: index_grid, size: 16, x: 10, y: 4).draw
  # zt.put(12,6).draw
  # zt.put(14,8).draw
  # zt.put(15,10).draw
  animation.next

  pattern animation, 11, 11, index_grid
  # zt.put(16,12).draw
  animation.frame.delay = 75
  animation.next

  (0...2).each { |i|
    Text.new(animation, 'a', x: 11 + i, y: 11, color: 'white').movex(0)
    Text.new(animation, 'ababacabc'[i], x: 11 + i, y: 11, color: 'green').draw
    pt = Text.new(animation, '123'[i], color: 'purple', bold: true, grid: index_grid, size: 16, x: 11 + i, y: 4).draw
    # pt.put(13 + i, 6).draw
    # pt.put(15 + i, 8).draw
    # pt.put(16 + i, 10).draw
    # pt.put(17 + i, 12).draw
    animation.next if i < 2
  }

  animation.frame.delay = 200
  animation.write
end

main
