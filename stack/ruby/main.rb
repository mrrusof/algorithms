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

class Stack

  def initialize
    @h = nil
  end

  def push e
    @h = Node.new @h, e
  end

  def pop
    if !!@h
      v = @h.value
      @h = @h.next
      return v
    else
      raise 'Stack is empty.'
    end
  end

  def peek
    if !!@h
      return @h.value
    else
      raise 'Stack is empty.'
    end
  end

  def empty?
    !!@h
  end

  def to_s
    if !!@h
      "head: #{@h.to_s}"
    else
      "head:"
    end
  end

end

s = Stack.new
puts s
s.push 1
s.push 2
puts s
puts s.peek
s.pop
puts s
s.pop
puts s
