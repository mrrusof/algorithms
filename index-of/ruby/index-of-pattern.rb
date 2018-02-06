#!/usr/bin/env ruby

require_relative 'animation'

def main
  animation = Animation.new 'index-of-pattern', 400, 140
  index_grid = Grid.new x_margin: 15
  (0..9).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i, color: 'gray40', size: 12, grid: index_grid).draw
  end
  index_grid = Grid.new x_margin: 13
  (10..19).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i + 10, color: 'gray40', size: 12, grid: index_grid).draw
  end
  Text.new(animation, 'ababaababacababacabc', y: 1).draw
  Text.new(animation, 'ababacabc', x: 11, y: 2, color: 'green').draw
  Text.new(animation, '^', x: 11, y: 3, color: 'green').draw
  animation.write
end

main
