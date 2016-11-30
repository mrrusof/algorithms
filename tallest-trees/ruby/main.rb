#!/usr/bin/env ruby

=begin

You are given a list of people and a parent-child relation.
Your task is to find the tallest family trees.

**Input.**
The input file consists of a list of people ids and a list of pairs
`[parent, child]`.
The list of pairs indicates the parent-child relation, e.g. `[1,2]`
means that person with id `1` is the parent of person with id `2`.

The first line of input consists of a sequence of integers separated by a
single space, the list of people ids.
The remaining lines consist each of a pair of integers separated
by a single space.
The input is terminated by an EOF character.

The following is an sample input file.

{% highlight asciidoc %}
1 2 3 4 5 6
1 2
4 3
3 5
2 6
{% endhighlight %}

**Output.**

The output consists of all the roots of the tallest family
trees, sorted.
The roots are to be given in a single line, separated by a single space.

For example, the following is the output for the previous sample
input.

{% highlight asciidoc %}
1 4
{% endhighlight %}

=end

def height g, v
  return g[v][:c].reduce(1){ |a, i| [a, height(g, i) + 1].max }
end

def tallest_trees g
  md = 0
  dt = []
  g.each do |k, v|
    if not !!v[:p]
      d = height g, k
      if d > md
        md = d
        dt = [k]
      elsif d == md
        dt << k
      end
    end
  end
  return dt.sort
end

def main
  ids = readline.split(' ').map(&:to_i) rescue abort('Could not read ids.')
  g = ids.map { |i| [i, { :p => nil, :c => [] }] }.to_h
  while true
    p = readline.split(' ').map(&:to_i) rescue break
    g[p[0]][:c] << p[1]
    g[p[1]][:p] = p[0]
  end
  puts tallest_trees(g).join(' ')
end

main
