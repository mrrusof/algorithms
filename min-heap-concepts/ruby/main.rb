#!/usr/bin/env ruby

class Array
  def snd
    self[1]
  end
end

class Tree

  class Node

    attr_accessor :value, :children

    def initialize v, cc=[]
      @value = v
      @children = cc
    end

    def to_ll
      if @children.length == 0
        s = @value.to_s
        return [s + if s.length % 2 == 0 then ' ' else '' end]
      end
      cols = @children.map(&:to_ll)
      max_lines = cols.map(&:length).max
      cols.map! do |col|
        width = col.first.length
        tail_len = max_lines - col.length
        col + Array.new(tail_len, ' ' * width)
      end
      ll = Array.new max_lines do [] end
      cols.each do |col|
        col.each_with_index do |l, i|
          ll[i] << l
        end
      end
      ll.map! { |l| l.join ' ' }
      width = ll.first.length
      ll = ['-' * width] + ll
      root = @value.to_s
      root += ' ' if root.length % 2 == 0
      margin = (width - root.length) / 2
      if margin > 0
        root = (' ' * margin) + root + (' ' * margin)
      elsif margin < 0
        ll.map! { |l| (' ' * margin) + l + (' ' * margin) }
      end
      return [root] + ll
    end

    def to_s
      to_ll.join "\n"
    end

  end

  def initialize r
    @root = Node.new r
    @nodes = { r => @root }
  end

  def add_edge from, to
    unless @nodes.has_key? from
      raise "There is no node #{from}"
    end
    if @nodes.has_key? to
      raise "The edge #{from}->#{to} would form a cycle."
    end
    node_to = Node.new to
    node_from = @nodes[from]
    node_from.children << node_to
    @nodes[to] = node_to
  end

  def to_s
    @root.to_s
  end

  def binary_tree?
    bin? @root
  end

  def bin? r
    if r.children.length > 2
      return false
    end
    return r.children.all? { |c| bin? c }
  end

  def complete_binary_tree?
    return true if height <= 0
    return false unless binary_tree?
    levels = (0...height).map { |_| [] }
    collect_levels @root, levels, 0
    unless levels.each_with_index.all? { |l, i| l.length == 2 ** i }
      return false
    end
    levels.last.reduce(false) do |gap, n|
      cc = n.children.length
      if gap and cc > 0
        return false
      end
      cc < 2
    end
    return true
  end

  def height
    return -1 if !@root
    h @root
  end

  def h r
    (r.children.map { |c| h c }.max || -1) + 1
  end

  def collect_levels r, levels, i
    if levels.length == i
      return
    end
    levels[i] << r
    r.children.each { |c| collect_levels c, levels, (i + 1) }
  end

  def min_heap?
    return true if !@root
    unless complete_binary_tree?
      raise 'Tree is not complete binary.'
      #return false
    end
    nodes_smaller_than_children @root
  end

  def nodes_smaller_than_children r
    r.children.all? { |c| r.value < c.value } and
      r.children.all? { |c| nodes_smaller_than_children c }
  end

  def insert_min_heap v
    if !@root
      @root = Node.new v
    else
      p = add_lll(@root, height - 1, v) || add_nll(@root, v)
      bubble p
    end
  end

  def add_lll r, d, v
    if d > 0
      r.children.each { |c|
        p = add_lll c, (d - 1), v
        return p << r if !!p
      }
    else
      unless r.children.length > 1
        n = Node.new v
        r.children << n
        return [n, r]
      end
    end
    return nil
  end

  def add_nll r, v
    if r.children.empty?
      n = Node.new v
      r.children << n
      return [n, r]
    else
      return add_nll(r.children.first, v) << r
    end
  end

  def bubble p
    i = 0
    while i + 1 < p.length
      return if p[i].value >= p[i + 1].value
      swap_values p[i], p[i + 1]
      i += 1
    end
  end

  def swap_values a, b
    t = a.value
    a.value = b.value
    b.value = t
  end

  def extract_min_heap
    if !@root
      raise 'No root'
    elsif height == 0
      v = @root.value
      @root = nil
      return v
    end
    v = @root.value
    n = extract_bottommost_rightmost
    @root.value = n.value
    sink @root
    return v
  end

  def extract_bottommost_rightmost
    p, n = ebr nil, @root, height
    p.children.pop
    return n
  end

  def ebr p, r, h
    if h == 0
      [p, r]
    elsif !!r
      r.children.reduce(nil) { |curr, c|
        ebr(r, c, h - 1) || curr
      }
    end
  end

  def sink r
    left = r.children.first
    right = r.children.snd
    if !!left and !!right
      if left.value < right.value
        conditional_sink r, left
      else
        conditional_sink r, right
      end
    elsif !!left
      conditional_sink r, left
    end
  end

  def conditional_sink p, c
    return if p.value <= c.value
    swap_values p, c
    sink c
  end

  def alternative_sink r
    return if r.children.empty?
    min = r.children.map(&:value).min
    return if r.value <= min
    c = r.children.select { |c| c.value == min }
    swap_values r, c
    sink c
  end

end

def insert v
  puts
  puts "$t.insert_min_heap #{v}"
  $t.insert_min_heap v
  puts $t
  puts "$t.min_heap? = #{$t.min_heap?}"
end

def extract
  puts
  puts "$t.extract_min_heap = #{$t.extract_min_heap}"
  puts $t
  puts "$t.min_heap? = #{$t.min_heap?}"
end

def test
  $t = Tree.new 5
  $t.add_edge 5, 8
  $t.add_edge 5, 13
#  $t.add_edge 5, 3
  $t.add_edge 8, 109
  $t.add_edge 8, 147
#  $t.add_edge 13, 69
  $t.add_edge 13, 14
#  $t.add_edge 69, 59
  puts $t
  puts "$t.min_heap? = #{$t.min_heap?}"
  insert 9
  insert 3
  extract
  extract
  extract
  extract
  extract
  extract
  extract
  extract
end

test
