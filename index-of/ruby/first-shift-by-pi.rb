#!/usr/bin/env ruby

require_relative 'animation'

def pattern animation, x, index_grid
  Text.new(animation, 'ababacabc', x: x, y: 4 + x, color: 'gray90').draw
  Text.new(animation, "(offset #{x})", x: 15, y: 4 + x, size: 16, grid: index_grid).draw
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
  Text.new(animation, 'q', color: 'purple', bold: true, grid: index_grid, size: 16, x: 5).draw
  Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, x: 5, y: 5).draw

  Text.new(animation, 'ababaababacababacabc', y: 2).draw
end

def pi animation, x=0
  index_grid = Grid.new x_margin: 15, y_margin: 25
  (0..4).each { |i|
    Text.new(animation, '00123'[i], x: x + i, y: 4, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
  }
  Text.new(animation, '(Pi)', x: 15, y: 4, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
end

def main
  animation = Animation.new 'first-shift-by-pi', 400, 190

  start animation

  Text.new(animation, 'ababa', y: 3, color: 'green').draw
  Text.new(animation, 'c', x: 5, y: 3, color: 'red').draw
  Text.new(animation, 'abc', x: 6, y: 3, color: 'gray60').draw

  pi animation

  animation.frame.delay = 150
  animation.next
  animation.frame.erase!

  # start animation
  # Text.new(animation, 'ababacabc', y: 3, color: 'gray60').draw
  # pi animation

  # animation.frame.delay = 75
  # animation.next

#  at = Text.new(animation, '^', x: 4, y: 5, color: 'blue').draw

  # animation.next
  # animation.frame.erase!

  start animation
  Text.new(animation, 'aba', y: 3, color: 'blue').draw
  Text.new(animation, 'bacabc', x: 3, y: 3, color: 'gray60').draw
  pi animation
  # at.draw
  at = Text.new(animation, '^', x: 4, y: 5, color: 'blue').draw

  animation.frame.delay = 110
  animation.next
  animation.frame.erase!

#   start animation
#   Text.new(animation, 'aba', y: 3, color: 'blue').draw
#   Text.new(animation, 'bacabc', x: 3, y: 3, color: 'gray60').draw
#   pi animation
# #  at.putx(2).draw

#   animation.frame.delay = 75
#   animation.next
#   animation.frame.erase!

  start animation
  Text.new(animation, 'aba', x: 2, y: 3, color: 'blue').draw
  Text.new(animation, 'bacabc', x: 5, y: 3, color: 'gray60').draw
  pi animation, 2
#  at.putx(4).draw

  animation.frame.delay = 150
  animation.write

end

main
