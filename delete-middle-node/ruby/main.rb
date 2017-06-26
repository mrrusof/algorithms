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

def delete_middle_node c
  return if c.next == nil
  c.value = c.next.value
  c.next = c.next.next
end

while true
  d = readline.to_i rescue break
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  h = c = Node.new nil, nn[0]
  nn[1..-1].each do |n|
    c = c.next = Node.new nil, n
    d = c if d == n
  end
  delete_middle_node d
  puts h
end
