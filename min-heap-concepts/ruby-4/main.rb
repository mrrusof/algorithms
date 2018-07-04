class MinHeap
  def initialize
    @data = []
  end

  def push v
    @data.push v
    bubble(@data.length - 1)
  end

  def pop
    n = @data.pop
    return n if @data.empty?
    v = @data.first
    @data[0] = n
    sink 0
    return v
  end

  def peek
    @data.first
  end

  private

  def bubble i
    while 0 < i
      p = parent i
      return if @data[p] <= @data[i]
      swap p, i
      i = p
    end
  end

  def parent i
    (i - 1) / 2
  end

  def left i
    i * 2 + 1
  end

  def right i
    left(i) + 1
  end

  def swap i, j
    t = @data[i]
    @data[i] = @data[j]
    @data[j] = t
  end

  def sink i
    while true
      l = left i
      return if l >= @data.length
      r = right i
      if r >= @data.length || @data[l] < @data[r]
        min = l
      else
        min = r
      end
      return if @data[i] <= @data[min]
      swap i, min
      i = min
    end
  end

  def to_s
    @data.inspect
  end
end

def push v
  puts "$mh.push #{v}"
  $mh.push v
  puts $mh
  puts
end

def pop
  v = $mh.pop
  puts "$mh.pop -> #{v}"
  puts $mh
  puts
end

def test
  $mh = MinHeap.new
  push 9
  push 10
  push 5
  push 7
  push 2
  push 1
  pop
  pop
  pop
  pop
  pop
  pop
  pop
end

test
