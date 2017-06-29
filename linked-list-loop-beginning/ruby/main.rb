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

def loop_beginning_linear_space h
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

def length_of_cycle n
  c = n.next
  l = 1
  while c != n
    c = c.next
    l += 1
  end
  return l
end

def any_node_in_cycle h
  s = f = Node.new h, 0
  while true
    (1..2).each do |_|
      f = f.next
      return nil if !f
    end
    s = s.next
    return s if s == f
  end
end

def loop_beginning_constant_space h
  n = any_node_in_cycle h
  return nil if !n
  l = length_of_cycle n
  f = h
  skipped = 0
  while skipped < l
    f = f.next
    skipped += 1
  end
  s = h
  while s != f
    s = s.next
    f = f.next
  end
  return s
end

def fast_meets_slow_at_double_slow_distance_from_beginning h
  s = f = h
  while !!f and !!f.next
    s = s.next
    f = f.next.next
    return s if s == f
  end
  return nil
end

def step_until_equal a, b
  while a != b
    a = a.next
    b = b.next
  end
  return a
end

def loop_beginning_constant_space_simple h
  n = fast_meets_slow_at_double_slow_distance_from_beginning h
  return nil if !n
  return step_until_equal h, n
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
  act = loop_beginning_constant_space_simple h
  if act == exp
    puts "PASS #{n_to_s exp} == #{n_to_s act}"
  else
    puts "FAIL #{n_to_s exp} != #{n_to_s act}"
  end
end
