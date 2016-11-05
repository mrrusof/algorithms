#!/usr/bin/env ruby

class Hash

  def save_word w
    h = self
    w.chars.each do |l|
      h[l] = {} if not h[l]
      h = h[l]
    end
    h[:eow] = true
  end

  def word_exists? w
    h = self
    w.chars.each_with_index do |l, i|
      if l == '.'
        return h.any? { |k,v| k != :eow and v.word_exists? w[i+1..-1] }
      elsif not h[l]
        return false
      end
      h = h[l]
    end
    return !!h[:eow]
  end

end

def main
  words = {}
  while true
    w = readline.strip
    break if w == '#'
    words.save_word w
  end
  while true
    begin
      p = readline.strip
    rescue EOFError => ex
      break
    end
    puts "#{p} #{words.word_exists? p}"
  end
end

main
