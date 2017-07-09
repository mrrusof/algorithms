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

  def balanced_binary_tree?
    return false unless binary_tree?
    bal?(@root).first
  end

  def bal? r
    return [true, 0] if !r
    lbal, lhei = bal? r.children.first
    rbal, rhei = bal? r.children.snd
    unless lbal and rbal
      return [false, nil]
    end
    max = [lhei, rhei].max
    min = [lhei, rhei].min
    return [max - min < 2, max + 1]
  end

  def complete_binary_tree?
    return true if height == 0
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

  def full_binary_tree?
    fbt? @root
  end

  def fbt? r
    cc = r.children.length
    if cc != 2 and cc != 0
      return false
    end
    return r.children.all? { |c| fbt? c }
  end

  def perfect_binary_tree?
    return false unless full_binary_tree?
    pbt? @root, height
  end

  def pbt? r, h
    return h == 0 if r.children.empty?
    return r.children.all? { |c| pbt? c, (h - 1) }
  end

end

def test
  t = Tree.new 1
  t.add_edge 1, 2
  t.add_edge 2, 11
#  t.add_edge 2, 13
#  t.add_edge 1, 3
#  t.add_edge 3, 4
#  t.add_edge 3, 14
#  t.add_edge 1, 5
#  t.add_edge 4, 6
#  t.add_edge 4, 7
#  t.add_edge 4, 8
#  t.add_edge 5, 9
#  t.add_edge 5, 10
#  t.add_edge 8, 12
  puts t
  puts "t.binary_tree? = #{t.binary_tree?}"
  puts "t.balanced_binary_tree? = #{t.balanced_binary_tree?}"
  puts "t.complete_binary_tree? = #{t.complete_binary_tree?}"
  puts "t.full_binary_tree? = #{t.full_binary_tree?}"
  puts "t.perfect_binary_tree? = #{t.perfect_binary_tree?}"
end

test
