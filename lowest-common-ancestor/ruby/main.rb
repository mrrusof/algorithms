#!/usr/bin/env ruby

=begin

Given a binary tree, find the lowest common ancestor (LCA) of two
given nodes in the tree.

According to the definition of LCA on Wikipedia: “The lowest common
ancestor is defined between two nodes v and w as the lowest node in T
that has both v and w as descendants (where we allow a node to be a
descendant of itself).”

        _______3______
       /              \
    ___5__          ___1__
   /      \        /      \
   6      _2       0       8
         /  \
         7   4

For example, the lowest common ancestor (LCA) of nodes 5 and 1 is
3. Another example is LCA of nodes 5 and 4 is 5, since a node can be a
descendant of itself according to the LCA definition.

=end

def path r, n
  return nil if r == nil
  return [r[:v]] if r[:v] == n
  p = path(r[:l], n) || path(r[:r], n)
  return [r[:v]] + p if p != nil
  return nil
end

def lca r, n1, n2
  p1 = path r, n1
  p2 = path r, n2
  i = 0
  i += 1 until p1[i] != p2[i] or i == p1.length
  return p1[i - 1]
end

def tree_node_to_t tn
  return nil if tn == nil
  return { v: tn.val, l: tree_node_to_t(tn.left), r: tree_node_to_t(tn.right) }
end

def lowest_common_ancestor(root, p, q)
  r = tree_node_to_t root
  n1 = tree_node_to_t p
  n2 = tree_node_to_t q
  return lca r, n1, n2
end

t = { v: 3, l: { v: 5, l: { v: 6 }, r: { v: 2, l: { v: 7 }, r: { v: 4 } } }, r: { v: 1, l: { v: 0 }, r: { v: 8 } } }

[ [ t, 5, 1, 3 ],
  [ t, 5, 4, 5 ]
].each do |t, n1, n2, exp|
  act = lca t, n1, n2
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " lca t, #{n1}, #{n2} = #{act} (#{exp})"
end
