#!/usr/bin/env ruby

require_relative 'animation'

def main
  animation = Animation.new 'second-mismatch', 400, 175
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
  Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, x: 5, y: 4).draw

  Text.new(animation, 'ababaababacababacabc', y: 2).draw
  Text.new(animation, 'aba', x: 2, y: 3, color: 'blue').draw
  Text.new(animation, 'b', x: 5, y: 3, color: 'red').draw
  Text.new(animation, 'acabc', x: 6, y: 3, color: 'gray60').draw

  animation.write
end

main
