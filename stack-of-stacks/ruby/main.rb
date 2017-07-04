class StackOfStacks

  def initialize cap
    @stacks = Array.new
    @cap = cap
  end

  def pop
    pop_at(@stacks.length - 1)
  end

  def empty?
    @stacks.empty?
  end

  def push v
    if empty? or @stacks[-1].length == @cap
      @stacks.push Array.new
    end
    @stacks[-1].push v
  end

  def pop_at i
    if empty?
      raise 'Stack is empty.'
    end
    if i < 0 or @stacks.length <= i
      raise 'Index out of bounds.'
    end
    v = @stacks[i].pop
    if @stacks[i].empty?
      @stacks.delete_at i
    end
    return v
  end

  def to_s
    @stacks.each_with_index.map { |s, i| "#{i}: #{s}" }.join("\n")
  end

end

$s = StackOfStacks.new 3

def pup v
  $s.push v
  puts "pushing #{v}"
  puts $s
end

def pop
  v = $s.pop
  puts "popping #{v}"
  puts $s
end

def popa i
  v = $s.pop_at i
  puts "popping #{v}"
  puts $s
end

def test
  pup 1
  pup 2
  pup 3
  pup 9
  pup 19
  pup 29
  pup 5
  pup 15
  pup 25
  pup 32
  pup 39
  popa 1
  popa 1
  popa 1
  pop
end

test
