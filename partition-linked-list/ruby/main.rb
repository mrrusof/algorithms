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

def partition h, x
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

while true
  x = readline.to_i rescue break
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  h = c = Node.new nil, nn[0]
  nn[1..-1].each do |n|
    c = c.next = Node.new nil, n
  end
  partition h, x
  puts h
end
