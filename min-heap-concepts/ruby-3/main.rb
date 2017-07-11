class MinHeap

  def initialize
    @array = []
  end

  def put v
    @array.push v
    bubble(@array.length - 1)
  end

  def bubble n
    while n > 0
      p = parent n
      break if @array[n] >= @array[p]
      swap_values n, p
      n = p
    end
  end

  def parent n
    if n % 2 == 1
      return (n - 1) / 2
    else
      return (n - 2) / 2
    end
  end

  def extract
    return nil if @array.empty?
    if @array.length == 1
      return @array.pop
    end
    v = @array[0]
    @array[0] = @array.pop
    sink 0
    return v
  end

  def sink n
    li = left_index n
    while li < @array.length
      ri = right_index n
      if ri >= @array.length or @array[li] < @array[ri]
        min = li
      else
        min = ri
      end
      if @array[min] >= @array[n]
        break
      end
      swap_values n, min
      n = min
      li = left_index n
    end
  end

  def left_index i
    i * 2 + 1
  end

  def right_index i
    i * 2 + 2
  end

  def swap_values a, b
    t = @array[a]
    @array[a] = @array[b]
    @array[b] = t
  end

  def to_s
    @array.to_s
  end

end

def put v
  puts "$mh.put #{v}"
  $mh.put v
  puts $mh
  puts
end

def min
  v = $mh.extract
  puts "$mh.extract -> #{v}"
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
