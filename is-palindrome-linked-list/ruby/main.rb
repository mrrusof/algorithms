class Node
  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    out = "#{value}"
    h = self
    while !!h.next
      h = h.next
      out += " #{h.value}"
    end
    return out
  end
end

def length h
  len = 0
  while !!h
    len += 1
    h = h.next
  end
  return len
end

def skip h, n
  skipped = 0
  while skipped < n
    h = h.next
    skipped += 1
  end
  return h
end

def reverse h
  r = nil
  while !!h
    n = h.next
    h.next = r
    r = h
    h = n
  end
  return r
end

def equal? l, r, n
  while n > 0
    if l.value != r.value
      return false
    end
    l = l.next
    r = r.next
    n -= 1
  end
  return true
end

def palindrome h
  n = length h
  r = skip h, (n - n / 2)
  r = reverse r
  l = h
  res = equal? l, r, (n / 2)
  reverse r
  return res
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
  puts "           l = #{l}"
  puts "palindrome l = #{palindrome l}"
  puts "           l = #{l}"
end
