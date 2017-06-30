class Node

  attr_accessor :next, :value

  def initialize n, v
    @next = n
    @value = v
  end

  def to_s
    out = "#{@value} -> "
    h = self
    while !!h.next
      h = h.next
      out += "#{h.value} -> "
    end
    return out
  end

end

class Queue

  def initialize
    @b = nil
    @f = nil
  end

  def queue v
    if !!@f
      @b.next = Node.new nil, v
      @b = @b.next
    else
      @b = Node.new nil, v
      @f = @b
    end
  end

  def dequeue
    if !@f
      raise 'Queue is empty.'
    end
    v = @f.value
    @f = @f.next
    return v
  end

  def peek
    if !@f
      raise 'Queue is empty.'
    end
    return @f.value
  end

  def empty?
    @f == nil
  end

  def to_s
    "front -> #{@f}back"
  end

end

def qp q, v
  q.queue v
  puts q
end

def dp q
  q.dequeue
  puts q
end

q = Queue.new
qp q, 1
qp q, 2
qp q, 3
dp q
dp q
dp q
qp q, 4
qp q, 5
dp q
dp q
