#!/usr/bin/env ruby

class Node

  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    h = self
    out = "#{h.value}"
    while h.next != nil
      h = h.next
      out += " #{h.value}"
    end
    return out
  end

end

def dedup c
  return if c == nil
  h = Hash.new
  h[c.value] = 1
  while c.next != nil
    if h.has_key?(c.next.value)
      c.next = c.next.next
    else
      c = c.next
      h[c.value] = 1
    end
  end
end

def slow_dedup c
  while c.next != nil
    f = c
    while f.next != nil
      if f.next.value == c.value
        f.next = f.next.next
      else
        f = f.next
      end
    end
    c = c.next
  end
end

while true
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  h = (c = Node.new nil, nn[0])
  nn[1..-1].each do |n|
    c = c.next = Node.new nil, n
  end
  puts h
  dedup h
  puts h
end
