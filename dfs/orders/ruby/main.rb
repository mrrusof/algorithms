#!/usr/bin/env ruby

def dfs_pre_order n
  print "#{n.v} "
  dfs_pre_order n.l if !!n.l
  dfs_pre_order n.r if !!n.r
end

def it_dfs_pre_order n
  w = [n]
  while !w.empty?
    n = w.pop
    print "#{n.v} "
    w.push n.r if !!n.r
    w.push n.l if !!n.l
  end
end

def dfs_in_order n
  dfs_in_order n.l if !!n.l
  print "#{n.v} "
  dfs_in_order n.r if !!n.r
end

def it_dfs_in_order n
  roots = [n]
  curr = n.l
  while !roots.empty?
    if !!curr
      roots.push curr
      curr = curr.l
    else
      curr = roots.pop
      print "#{curr.v} "
      curr = curr.r
      if !!curr
        roots.push curr
        curr = curr.l
      end
    end
  end
end

def dfs_post_order n
  dfs_post_order n.l if !!n.l
  dfs_post_order n.r if !!n.r
  print "#{n.v} "
end

def it_dfs_post_order n
  prev = n
  roots = [n]
  curr = n.l
  while !roots.empty?
    if !!curr
      roots.push curr
      curr = curr.l
    else
      curr = roots.pop
      if !!curr.r && curr.r != prev
        roots.push curr
        curr = curr.r
      else
        print "#{curr.v} "
        prev = curr
        curr = nil
      end
    end
  end
end

class Node
  attr_accessor :v, :l, :r

  def initialize v, l=nil, r=nil
    @v = v
    @l = l
    @r = r
  end
end

t = Node.new('a',
             Node.new('b'),
             Node.new('c',
                      Node.new('d', Node.new('e'), Node.new('f')),
                      Node.new('g', Node.new('h', Node.new('i')))))

puts "pre order"
dfs_pre_order(t)
puts
it_dfs_pre_order(t)
puts

puts "in order"
dfs_in_order(t)
puts
it_dfs_in_order(t)
puts

puts "post order"
dfs_post_order(t)
puts
it_dfs_post_order(t)
puts
