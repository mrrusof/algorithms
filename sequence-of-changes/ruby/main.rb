#!/usr/bin/env ruby

class Node
  attr_reader :value, :neighbors

  def initialize value
    @value = value
    @neighbors = []
  end
end

def hamming w1, w2
  diff = 0
  w1.chars.each_with_index do |c, i|
    diff += 1 if c != w2[i]
  end
  return diff
end

def graph from, to, words
  from_node = to_node = nil
  nodes = words.map { |w| Node.new(w) }
  nodes.each_with_index do |n1, i|
    nodes[i+1..-1].each do |n2|
      if hamming(n1.value, n2.value) == 1
        n1.neighbors << n2
        n2.neighbors << n1
      end
    end
  end
  nodes.each do |n|
    from_node = n if n.value == from
    to_node = n if n.value == to
  end
  return [from_node, to_node]
end

def path from, to
  wl = [ [from, Node.new(from.value)] ]
  seen = { from => true }
  while !wl.empty?
    curr, path = wl.shift # cost of this is O(1) amortized
    return path if curr == to
    curr.neighbors.each do |n|
      if !seen[n]
        new_path = Node.new(n.value)
        new_path.neighbors << path
        wl.push([n, new_path])
        seen[n] = true
      end
    end
  end
end

def print_path path
  while path
    print "#{path.value} "
    path = path.neighbors[0]
  end
  puts
end

def main from, to, dict
  from_node, to_node = graph from, to, dict
  sol = path from_node, to_node
  print_path sol
end

main 'pine', 'pony', %w(pine wine puny nine pony pain pune)
main 'damp', 'like', %w(lamp damp limp lump like lime limb)
