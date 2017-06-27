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
  n = 0
  while !!h
    h = h.next
    n += 1
  end
  return n
end

def skip h, n
  while n > 0
    h = h.next
    n -= 1
  end
  return h
end

def find_first_equal a, b
  while !!a
    if a == b
      return a
    end
    a = a.next
    b = b.next
  end
  return nil
end

def intersection a, b
  lena = length a
  lenb = length b
  if lena < lenb
    b = skip b, lenb - lena
  else
    a = skip a, lena - lenb
  end
  return find_first_equal a, b
end

def a_to_l a, l = nil
  a.reverse.each do |e|
    l = Node.new l, e
  end
  return l
end

tail = a_to_l [4, 5]

[ [ a_to_l([1, 2], tail), a_to_l([3], tail), tail],
  [ a_to_l([1, 2]), a_to_l([3]), nil],
].each do |a, b, exp|
  act = intersection a, b
  if exp == act
    print "PASS #{exp} == "
  else
    print "FAIL #{exp} != "
  end
  puts "#{act}"
end
