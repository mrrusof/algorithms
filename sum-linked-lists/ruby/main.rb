class Node
  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    out = "#{value}"
    h = self
    while h.next != nil
      h = h.next
      out += " #{h.value}"
    end
    return out
  end
end

def sum l, r
  carried = 0
  h = c = Node.new nil, 0
  while l != nil or r != nil or carried > 0
    if l != nil
      lv = l.value
      l = l.next
    else
      lv = 0
    end
    if r != nil
      rv = r.value
      r = r.next
    else
      rv = 0
    end
    sum = carried + lv + rv
    c.next = Node.new nil, (sum % 10)
    c = c.next
    carried = sum / 10
  end
  return h.next
end

def read_linked_list
  nn = readline.strip.split(' ').map(&:to_i)
  return nil if nn.empty?
  h = c = Node.new nil, nn[0]
  nn[1..-1].each do |n|
    c = c.next = Node.new nil, n
  end
  return h
end

while true
  l = read_linked_list rescue break
  r = read_linked_list rescue break
  puts "l = #{l}"
  puts "r = #{r}"
  puts "s = #{sum l, r}"
end
