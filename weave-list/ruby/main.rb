#!/usr/bin/env ruby

class Node

  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    n = self
    out = "#{n.value}"
    while n.next != nil
      out += " #{n.next.value}"
      n = n.next
    end
    return out
  end

  def inspect
    to_s
  end

end

def weave l
  return nil if l == nil
  slow = l
  fast = l.next
  while fast.next != nil
    slow = slow.next
    fast = fast.next.next
  end
  slow = slow.next # move to b1
  fast = l
  while true
    fn = fast.next
    fast.next = slow
    fast = fn
    break if slow.next == nil
    sn = slow.next
    slow.next = fast
    slow = sn
  end
end

while true
  nn = readline.strip.split(" ") rescue break
  head = curr = Node.new nil, nn[0]
  nn[1..-1].each do |n|
    curr = (curr.next = Node.new nil, n)
  end
  puts head
  weave head
  puts head
end
