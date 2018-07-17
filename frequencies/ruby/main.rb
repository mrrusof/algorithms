#!/usr/bin/env ruby

class Trie
  def initialize
    @data = {}
  end

  def insert word, &block
    do_insert @data, word, 0, &block
  end

  def each &block
    do_each @data, '', &block
  end

  private

  def do_insert node, word, pos, &block
    if word == nil || pos == word.length
      node[:v] = yield node[:v]
    elsif
      node[word[pos]] ||= {}
      do_insert node[word[pos]], word, (pos + 1), &block
    end
  end

  def do_each node, word, &block
    if node[:v] != nil
      yield word, node[:v]
    end
    node.each do |key, child|
      next if key == :v
      do_each child, (word + key), &block
    end
  end
end

def main ww
  t = Trie.new
  ww.each do |w|
    t.insert(w) { |v| (v || 0) + 1 }
  end
  t.each do |w, v|
    puts "#{w} -> #{v}"
  end
end

main %w( hola mundo hola mundo hello goto mundo )
