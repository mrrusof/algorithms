class Node

  attr_accessor :next, :prev, :value

  def initialize v
    @next = nil
    @prev = nil
    @value = v
  end

  def to_s
    out = "#{value}"
    c = h = self
    while !!c.next and c.next != h
      c = c.next
      out += " #{c.value}"
    end
    return out
  end

end

class Cache

  attr_accessor :cache, :stale

  def initialize cap
    @cache = {}
    @fresh_map = {}
    @fresh = nil
    @stale = nil
    @cap = cap
  end

  def put k, v
    if @cache.size == @cap
      stale = dequeue
      sk = stale.value
      @cache.delete sk
      @fresh_map.delete sk
    end
    if !@cache.has_key? k
      fresh = Node.new k
      @fresh_map[k] = fresh
      queue fresh
    else
      fresh = @fresh_map[k]
      extract fresh
      queue fresh
    end
    @cache[k] = v
  end

  def get k
    return nil if !@cache.has_key? k
    fresh = @fresh_map[k]
    if @stale == fresh
      dequeue
      queue fresh
    elsif @fresh != fresh
      extract fresh
      queue fresh
    end
    return @cache[k]
  end

  def queue n
    if @fresh == nil
      @fresh = @stale = n
    else
      @fresh.next = n
#      n.next = nil # not necessary
      n.prev = @fresh
      @fresh = n
    end
  end

  def dequeue
    stale = @stale
    @stale = @stale.next
    return stale
  end

  def extract c
    p = c.prev
    n = c.next
    p.next = n if p != nil
    n.prev = p if n != nil
  end

end


c = Cache.new 3

c.put 'a', 1
c.put 'b', 2
c.put 'c', 3

puts c.cache
puts c.stale

['c', 'b', 'a'].each { |l|
  puts "#{l} -> #{c.get l}"
#  puts c.stale
}

puts c.stale

c.put 'x', -5

puts c.cache
puts c.stale
