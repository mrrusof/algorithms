#!/usr/bin/env ruby

require_relative 'animation'

def main

  animation = Animation.new 'naive-solution', 500, 500
  text    = Text.new animation, 'ababaababacababacabc'
  pattern = Text.new animation, 'ababacabc', color: 'gray60'

  text
    .put(0,0)
    .draw
  pattern
    .put(0,1)
    .draw
  animation.next

  pattern.text.chars.each_with_index do |c, i|
    Text.new(animation, c,
             x: (pattern.x + i),
             y: pattern.y,
             color: 'green')
      .draw
    animation.next
  end

  animation.frames.delay = 25
  animation.frames.first.delay = 100
  animation.write

end

main
