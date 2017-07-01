class StackWithMinRubyArray

  def initialize
    @values = Array.new
    @min = Array.new
  end

  def push v
    @values.push v
    if !!self.min
      @min.push [self.min, v].min
    else
      @min.push v
    end
  end

  def pop
    @min.pop
    return @values.pop
  end

  def min
    return @min[-1]
  end

  def to_s
    return '' if @values.empty?
    out = "| #{@values[0]}"
    @values[1..-1].each do |v|
      out += " <- #{v}"
    end
    return out
  end

end

class ArrayStack

  def initialize cap = 2
    @cap = if cap > 1 then cap else 2 end
    @values = Array.new @cap
    @top = -1
  end

  def empty?
    @top == -1
  end

  def push v
    if @top + 1 == @cap
      increase_capacity
    end
    @top += 1
    @values[@top] = v
  end

  def increase_capacity
    new_cap = @cap * 2
    new_array = Array.new new_cap
    copy @values, new_array, @top + 1
    @cap = new_cap
    @values = new_array
  end

  def copy from, to, n
    (0...n).each do |i|
      to[i] = from[i]
    end
  end

  def pop
    v = peek
    @top -= 1
    if @top < @cap / 4 and @cap >= 4
      decrease_capacity
    end
    return v
  end

  def peek
    if empty?
      raise "Stack is empty."
    else
      return @values[@top]
    end
  end

  def decrease_capacity
    new_cap = @cap / 2
    new_array = Array.new new_cap
    copy @values, new_array, @top + 1
    @cap = new_cap
    @values = new_array
  end

  def to_s
    return '' if empty?
    out = "| #{@values[0]}"
    @values[1..@top].each do |v|
      out += " <- #{v}"
    end
    return out
  end
end

class StackWithMinArrayStack

  def initialize
    @values = ArrayStack.new
    @min = ArrayStack.new
  end

  def push v
    @values.push v
    begin
      @min.push [self.min, v].min
    rescue
      @min.push v
    end
  end

  def pop
    @min.pop
    return @values.pop
  end

  def min
    return @min.peek
  end

  def to_s
    @values.to_s
  end

end

def pp s, v
  mb = s.min rescue nil
  s.push v
  ma = s.min rescue nil
  puts "push #{v}, min before #{mb}, min after #{ma}"
  puts s
end

def po s
  mb = s.min rescue nil
  v = s.pop
  ma = s.min rescue nil
  puts "pop #{v}, min before #{mb}, min after #{ma}"
  puts s
end

def test s
  pp s, 2
  pp s, 4
  pp s, 1
  pp s, 3
  po s
  po s
end

s = StackWithMinRubyArray.new
puts "StackWithMinRubyArray"
test s
s = StackWithMinArrayStack.new
puts
puts "StackWithMinArrayStack"
test s
