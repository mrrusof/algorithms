class Node
  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    out = "#{@value}"
    c = self
    while !!c.next
      c = c.next
      out += " #{c.value}"
    end
    return out
  end

end

def partition_by_swap h, x
  v = h
  w = nil
  while true
    while v != nil and v.value < x
      v = v.next
    end
    w = v.next if w == nil and v != nil
    while w != nil and x <= w.value
      w = w.next
    end
    break if w == nil
    t = v.value
    v.value = w.value
    w.value = t
  end
end

def partition_by_buckets h, x
  left = left_tail = Node.new nil, 0
  right = right_tail = Node.new nil, 0
  while h != nil
    if h.value < x
      left_tail.next = h
      left_tail = h
    else
      right_tail.next = h
      right_tail = h
    end
    h = h.next
  end
  left_tail.next = right.next
  right_tail.next = nil
  return left.next
end

def partition_by_head_tail h, x
  return nil if h == nil
  head = tail = h
  h = h.next
  while h != nil
    hh = h.next
    if h.value < x
      h.next = head
      head = h
    else
      tail.next = h
      tail = tail.next
    end
    h = hh
  end
  tail.next = nil
  return head
end

while true
  x = readline.to_i rescue break
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  h = c = Node.new nil, nn[0]
  nn[1..-1].each do |n|
    c = c.next = Node.new nil, n
  end

  # partition_by_swap h, x
  # puts h

  # puts partition_by_buckets h, x

  puts partition_by_head_tail h, x
end
