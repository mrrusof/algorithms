#!/usr/bin/env ruby

class Node

  attr_accessor :v, :n

  def initialize v, n=nil
    @v = v
    @n = n
  end

  def to_s
    n = self
    out = "#{n.v}"
    while !!n.n
      n = n.n
      out += " #{n.v}"
    end
    return out
  end

  def clone
    h = Node.new @v
    cp = h
    o = self
    while !!o.n
      cp.n = Node.new o.n.v
      cp = cp.n
      o = o.n
    end
    return h
  end

end


def dedup_quad n
  while !!n
    c = n
    while !!c.n
      if c.n.v == n.v
        c.n = c.n.n
      else
        c = c.n
      end
    end
    n = n.n
  end
end

def dedup n
  return if !n
  h = {n.v => true}
  while !!n.n
    if h[n.n.v]
      n.n = n.n.n
    else
      h[n.n.v] = true
      n = n.n
    end
  end
end

while true
  vv = readline.strip.split(' ').map(&:to_i) rescue break
  next if vv.length == 0
  h = c = Node.new vv[0]
  vv[1..-1].each do |v|
    c = c.n = Node.new v
  end
  h2 = h.clone
  puts h
  dedup_quad h
  puts h
  puts h2
  dedup h2
  puts h2
end
