#!/usr/bin/env ruby

require_relative 'animation'

def pattern animation, x, index_grid
  Text.new(animation, 'ababacabc', x: x, y: 4 + x, color: 'gray90').draw
  Text.new(animation, "(offset #{x})", x: 15, y: 4 + x, size: 16, grid: index_grid).draw
end

def pat animation, p, x=5, y=3
  Text.new(animation, 'ababacabc'[0... if p == 9 then 8 else p end], x: x, y: y, color: 'green').draw
  Text.new(animation, 'ababacabc'[p..-1], x: x + p, y: y, color: 'gray60').draw
  Text.new(animation, 'c', x: x + 8, y: y, color: 'red').draw if p == 9
end

def start animation
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
  Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, x: 13, y: 5).draw

  Text.new(animation, 'ababaababacababacabc', y: 2).draw
end

def pi animation, x=5
  index_grid = Grid.new x_margin: 15, y_margin: 25
  (0...8).each { |i|
    Text.new(animation, '00123012'[i], x: x + i, y: 4, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
  }
  Text.new(animation, '(Pi)', x: -0.5, y: 4, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
end

def main
  animation = Animation.new 'fourth-shift-by-pi', 400, 190

  start animation

  pat animation, 9
  pi animation

  animation.frame.delay = 150
  animation.next
  animation.frame.erase!

  start animation
  Text.new(animation, 'ab', x: 5, y: 3, color: 'blue').draw
  Text.new(animation, 'abacabc', x: 7, y: 3, color: 'gray60').draw
  pi animation
  # at.draw
  at = Text.new(animation, '^', x: 12, y: 5, color: 'blue').draw

  animation.frame.delay = 110
  animation.next
  animation.frame.erase!

  start animation
  Text.new(animation, 'ab', x: 11, y: 3, color: 'blue').draw
  Text.new(animation, 'abacabc', x: 13, y: 3, color: 'gray60').draw
  pi animation, 11

  animation.frame.delay = 150
  animation.write

end

main
