class ThreeStacks

  def initialize cap
    @cap = if cap > 1 then cap else 2 end
    @array = Array.new(cap * 3)
    @back = [0, cap, cap * 2]
    @front = @back.map { |b| b - 1 }
  end

  def pushA v
    push 0, v
  end

  def pushB v
    push 1, v
  end

  def pushC v
    push 2, v
  end

  def push s, v
    front = @front[s]
    back = @back[s]
    if front < back
      front = @front[s] = back
    elsif front - back == @cap - 1
      increase_capacity
      front = @front[s] += 1
    else
      front = @front[s] += 1
    end
    @array[front] = v
  end

  def increase_capacity
    new_cap = @cap * 2
    new_array = Array.new(new_cap)
    offsets = [0, @cap, new_cap]
    copy new_array, offsets
    @cap = new_cap
    @array = new_array
  end

  def copy new_array, offsets
    offsets.each_with_index do |o, s|
      (@back[s]..@front[s]).each do |i|
        new_array[o + i] = @array[i]
      end
      @back[s] += o
      @front[s] += o
    end
  end

  def popA
    pop 0
  end

  def popB
    pop 1
  end

  def popC
    pop 2
  end

  def pop s
    front = @front[s]
    back = @back[s]
    if front < back
      raise 'Stack is empty.'
    end
    v = @array[front]
    @front[s] -= 1
    conditional_decrease_capacity
    return v
  end

  def conditional_decrease_capacity
    return if @cap == 2
    @front.each_with_index do |front, s|
      back = @back[s]
      return if front - back + 1 > @cap / 4
    end
    new_cap = @cap / 2
    new_array = Array.new(@cap / 2)
    offsets = [0, -new_cap, -@cap]
    copy new_array, offsets
    @cap = new_cap
    @array = new_array
  end

  def to_s
    out = ""
    ['A', 'B', 'C'].each_with_index do |name, s|
      out += "#{name}: "
      out += stack_to_s s
      out += "\n"
    end
    return out
  end

  def stack_to_s s
    return '' if @front[s] < @back[s]
    out = "#{@array[@back[s]]}"
    (@back[s] +1 .. @front[s]).each do |i|
      out += " #{@array[i]}"
    end
    return out
  end

end

def pup sss, s, v
  sss.push s, v
  puts "pushed #{v} into #{s}"
  puts sss
end

def pop sss, s
  sss.pop s
  puts "poped from #{s}"
  puts sss
end

sss = ThreeStacks.new 2
pup sss, 0, 1
pup sss, 1, 2
pop sss, 0
pup sss, 0, 3
pup sss, 2, 4
pup sss, 1, 5
pup sss, 1, 6
