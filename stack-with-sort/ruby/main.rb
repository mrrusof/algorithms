class StackWithSort
  def initialize
    @values = Array.new
  end

  def push v
    @values.push v
  end

  def pop
    raise 'Stack is empty.' if empty?
    return @values.pop
  end

  def empty?
    @values.empty?
  end

  def peek
    raise 'Stack is empty.' if empty?
    return @values[-1]
  end

  def sort
    temp = Array.new
    while not empty?
      e = @values.pop
      while (not temp.empty?) and temp[-1] > e
        @values.push temp.pop
      end
      temp.push e
    end
    while not temp.empty?
      @values.push temp.pop
    end
  end

  def to_s
    return '' if empty?
    @values.map(&:to_s).join(' <- ')
  end

end

def pp s, v
  s.push v
  puts "push #{v}"
  puts s
end

def po s
  v = s.pop
  puts "pop #{v}"
  puts s
end

def sp s
  s.sort
  puts "sort"
  puts s
end

def test s
  pp s, 2
  pp s, 4
  pp s, 1
  pp s, 3
  sp s
  po s
  po s
end

s = StackWithSort.new
puts "StackWithSort"
test s
