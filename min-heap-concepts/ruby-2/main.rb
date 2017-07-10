#!/usr/bin/env ruby

class MinHeap

  class Node
    attr_accessor :value, :parent, :left, :right

    def initialize v
      @value = v
    end

    def to_ll
      vstr = @value.to_s
      vlen = vstr.length
      llright = []
      if !!@right
        llright = @right.to_ll.map { |l| (' ' * vlen) + ' |' + l }
      end
      llleft = []
      if !!@left
        llleft = @left.to_ll.map { |l| (' ' * vlen) + ' |' + l }
      end
      unless llright.empty? and llleft.empty?
        vstr += ' |'
      end
      return llright + [vstr] + llleft
    end

    def to_s
      to_ll.join "\n"
    end

  end

  def initialize
    @root = nil
    @put = nil
  end

  def to_s
    if !!@root
      @root.to_s
    else
      '<empty>'
    end
  end

  def put v
    n = Node.new v

    if !@root
      @root = n
      @put = n
    elsif !@put.left
      @put.left = n
      n.parent = @put
    else
      @put.right = n
      n.parent = @put
      forward_put
    end

    bubble n

  end

  def forward_put

    while !!@put.parent && @put == @put.parent.right
      @put = @put.parent
    end

    if !!@put.parent
      @put = @put.parent.right
    end

    while !!@put.left
      @put = @put.left
    end

  end

  def bubble n
    while !!n.parent && n.value < n.parent.value
      swap_values n, n.parent
      n = n.parent
    end
  end

  def swap_values a, b
    t = a.value
    a.value = b.value
    b.value = t
  end

  def extract_min

    return nil if !@root

    v = @root.value

    if !@root.left
      @root = nil
      @put = nil
      return v
    end

    if !@put.left
      backwards_put
      @root.value = @put.right.value
      @put.right = nil
    else
      @root.value = @put.left.value
      @put.left = nil
    end

    sink @root

    return v

  end

  def backwards_put

    while !!@put.parent && @put == @put.parent.left
      @put = @put.parent
    end

    if !!@put.parent
      @put = @put.parent.left
    end

    while !!@put.right.right
      @put = @put.right
    end

  end

  def sink r

    while !!r.left

      if !r.right || r.left.value < r.right.value
        min = r.left
      else
        min = r.right
      end

      break if r.value <= min.value

      swap_values r, min
      r = min

    end

  end


end

def put v
  puts "$mh.put #{v}"
  $mh.put v
  puts $mh
  puts
end

def min
  v = $mh.extract_min
  puts "$mh.extract_min -> #{v}"
  puts $mh
  puts
end

def test
  $mh = MinHeap.new
  put 9
  put 10
  put 5
  put 7
  put 2
  put 1
  min
  min
  min
  min
  min
  min
  min
end

test
