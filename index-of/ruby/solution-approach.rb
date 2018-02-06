#!/usr/bin/env ruby

require_relative 'animation'

def build_proper_prefix_that_is_suffix p
  pi = Array.new(p.length, 0) # Array of zeroes of length |p|
  m = 0
  (1...p.length).each do |k|
    while m > 0 && p[m] != p[k]
      m = pi[m - 1]
    end
    if p[m] == p[k]
      m += 1
    end
    pi[k] = m
  end
  return pi
end

def index_of pattern, text

  animation = Animation.new 'solution-approach', 400, 70
  tt = Text.new(animation, text).draw
  pt = Text.new(animation, pattern, color: 'gray60', y: 1).draw
  animation.next

  pi = build_proper_prefix_that_is_suffix pattern
  k = 0
  (0...text.length).each do |q|

    while k > 0 && pattern[k] != text[q]

      Text.new(animation, pattern[k], color: 'red', x: q, y: 1).draw
      animation.frame.delay = 100
      animation.next
      animation.frame.erase!

      k = pi[k - 1]

      tt.draw
      pt.putx(q - k).draw
      if k > 0
        Text.new(animation, pattern[0...k], color: 'blue', x: q - k, y: 1).draw
        animation.frame.delay = 100
      else
        animation.frame.delay = 100
      end
      animation.next

    end

    if pattern[k] == text[q]
      Text.new(animation, pattern[k], color: 'green', x: q, y: 1).draw
      animation.next
      if k + 1 == pattern.length
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
