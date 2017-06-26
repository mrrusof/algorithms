class Node

  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    out = "#{@value}"
    c = self
    while c.next != nil
      c = c.next
      out += " #{c.value}"
    end
    return out
  end

end

def kth_to_last h, k # k >= 0
  return nil if h == nil
  c = h
  n = 1
  while c.next != nil
    c = c.next
    n += 1
  end
  c = h
  i = 1
  while i != n - k
    c = c.next
    i += 1
  end
  return c.value
end

while true
  k = readline.to_i rescue break
  nn = readline.strip.split(' ') rescue break
  h = c = Node.new nil, nn[0]
  nn[1..-1].each do |n|
    c = c.next = Node.new nil, n
  end
  puts kth_to_last h, k
end
