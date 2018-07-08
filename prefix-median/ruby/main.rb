#!/usr/bin/env ruby

class BaseHeap
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

  def size
    @data.length
  end

  def to_s
    inspect
  end

  def inspect
    @data.inspect
  end

  private

  def bubble i
    while 0 < i
      p = parent i
      return if invariant(p, i)
      swap p, i
      i = p
    end
  end

  def sink i
    while true
      l = left i
      return if l >= @data.length
      r = right i
      if r >= @data.length || invariant(l, r)
        pivot = l
      else
        pivot = r
      end
      return if invariant(i, pivot)
      swap i, pivot
      i = pivot
    end
  end

  def parent i
    (i - 1) / 2
  end

  def left i
    (i * 2) + 1
  end

  def right i
    left(i) + 1
  end

  def swap i, j
    t = @data[i]
    @data[i] = @data[j]
    @data[j] = t
  end
end

class MinHeap < BaseHeap
  def invariant i, j
    @data[i] <= @data[j]
  end
end

class MaxHeap < BaseHeap
  def invariant i, j
    @data[i] >= @data[j]
  end
end

class PrefixMedian
  def initialize
    @left = MaxHeap.new
    @right = MinHeap.new
  end

  def push v
    if @left.size == 0
      @left.push v
      return
    end
    if @left.peek < v
      @right.push v
    else
      @left.push v
    end
    balance
  end

  def median
    if @left.size == 0 || @left.size != @right.size
      @left.peek.to_f
    else
      (@left.peek + @right.peek) / 2.0
    end
  end

  private

  def balance
    if @left.size < @right.size
      @left.push @right.pop
    elsif @left.size > @right.size + 1
      @right.push @left.pop
    end
  end
end

def test input
  pm = PrefixMedian.new
  # input.each do |v|
  #   pm.push v
  #   puts "#{v} -> #{pm.median}"
  # end
  output = input.map do |v|
    pm.push v
    pm.median
  end
  puts output.join(' ')
end

#test [1, 7, 6, 8, 9, 4]

while true
  input = readline.strip.split(' ').map(&:to_i) rescue break
  pm = PrefixMedian.new
  input.each_with_index do |v, i|
    pm.push v
    print pm.median
    print ' ' if i < input.length - 1
  end
  puts
end
