#!/usr/bin/env ruby

def index_of pattern, text
  (0...text.length).each do |q|
    k = 0
    while k < pattern.length && q + k < text.length && pattern[k] == text[q + k]
      k += 1
    end
    return q if k == pattern.length
  end
  return -1
end

def main
  text = readline.strip
  pattern = readline.strip
  puts index_of pattern, text
end

main
