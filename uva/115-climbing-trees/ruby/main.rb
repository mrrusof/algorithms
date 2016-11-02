#!/usr/bin/env ruby

def min(x,y)
  return x if x < y
  return y
end

def max(x,y)
  return y if x < y
  return x
end

def path_to_root(p, n)
  return [n] if p[n] == nil
  return [n] + path_to_root(p, p[n])
end

def closest_ancestor(p1, p2)
  p1 = p1.clone
  p2 = p2.clone
  ca = nil
  while p1 and p2
    n1 = p1.pop
    n2 = p2.pop
    break if n1 != n2
    ca = n1
  end
  return ca
end

def main
  parent = {}
  while true do
    begin
      l = readline
    rescue EOFError => err
      break
    end
    l = l.split
    break if l.length != 2 or l[0] == 'no.child'

#    puts "l[0] = '#{l[0]}'"
#    puts "l[1] = '#{l[1]}'"

    # l[1] is parent of l[0]
    parent[l[0]] = l[1]
  end
#  parent.each { |k,v| puts "#{k} -> #{v}" }
  while true do
    begin
      l = readline
    rescue EOFError => err
      break
    end
    l = l.split
    # n1: node 1
    n1 = l[0]
    n2 = l[1]
#    puts "n1 = #{n1}"
#    puts "n2 = #{n2}"
    # p1: path to root for node 1
    p1 = path_to_root(parent, n1)
    p2 = path_to_root(parent, n2)
#    puts "p1 = #{p1}"
#    puts "p2 = #{p2}"
    # ca: closest ancestor
    ca = closest_ancestor(p1, p2)
#    puts "ca = #{ca}"
    # is n1 ancestor of n2?
    if ca == n1
      # is n1 parent of n2?
      if parent[n2] == n1
        puts 'parent'
      # n1 is n-ancestor of n2
      else
        dist = p2.index(n1) - 2
        puts "#{'great ' * dist}grand parent"
      end
    # is n2 ancestor of n1?
    elsif ca == n2
      # is n2 parent of n1?
      if parent[n1] == n2
        puts 'child'
      else
        dist = p1.index(n2) - 2
        puts "#{'great ' * dist}grand child"
      end
    # n1 and n2 have a common ancestor
    elsif ca
      # n1 and n2 have ca as parent
      if parent[n1] == ca and parent[n2] == ca
        puts 'sibling'
      # n1 and n2 are cousins
      else
        d1 = p1.index(ca) - 1
        d2 = p2.index(ca) - 1
        k = min(d1, d2)
        j = max(d1 - d2, d2 - d1)
        if j > 0
          puts "#{k} cousin removed #{j}"
        else
          puts "#{k} cousin"
        end
      end
    else
      puts 'no relation'
    end
  end
end

main
