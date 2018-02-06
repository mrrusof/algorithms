#!/usr/bin/env ruby

require_relative 'animation'

def index_of pattern, text
  animation = Animation.new 'naive-approach', 400, 70
  tt = Text.new animation, text
  pt = Text.new animation, pattern, color: 'gray60', y: 1
  (0...text.length).each do |q|
    tt.draw
    pt.putx(q).draw
    animation.next
    k = 0
    while k < pattern.length && q + k < text.length && pattern[k] == text[q + k]
      Text.new(animation, pattern[k], color: 'green', x: q + k, y: 1).draw
      animation.next
      k += 1
    end
    if k == pattern.length
      animation.write
      return q
    else
      Text.new(animation, pattern[k], color: 'red', x: q + k, y: 1).draw
    end
    animation.frame.delay = 75
    animation.next
    animation.frame.erase!
  end
  animation.write
  return -1
end

def main
  text = readline.strip
  pattern = readline.strip
  puts index_of pattern, text
end

main
