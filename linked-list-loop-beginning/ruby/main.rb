class Node

  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    out = "#{value}"
    h = self
    while !!h
      h = h.next
      out += "#{h.value}"
    end
    return out
  end

end

def loop_beginning h
  visited = Hash.new
  while !!h
    if visited.has_key? h
      return h
    end
    visited[h] = 1
    h = h.next
  end
  return nil
end

def n val, succ
  Node.new succ, val
end

def n_to_s n
  return n.value if !!n
  return 'nil'
end

a = n(1, b = n(2, n(3, d = n(4, nil))))
d.next = b

[ [a, b],
  [n(1, n(2, nil)), nil]
].each do |h, exp|
  act = loop_beginning h
  if act == exp
    puts "PASS #{n_to_s exp} == #{n_to_s act}"
  else
    puts "FAIL #{n_to_s exp} != #{n_to_s act}"
  end
end
