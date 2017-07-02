class Node
  attr_accessor :next, :prev, :value

  def initialize n, p, v
    @prev = p
    @next = n
    @value = v
  end

  def to_s
    @value.to_s
  end

end

class LinkedListQueue

  def initialize
    @front = nil
    @back = nil
  end

  def queue v
    n = Node.new nil, @back, v
    @back.next = n if @back != nil
    @back = n
    @front = @back if @front == nil
    return n
  end

  def dequeue
    if empty?
      raise 'Queue is empty.'
    end
    n = @front
    @front = @front.next
    @front.prev = nil if @front != nil
    @back = nil if @front == nil
    return n
  end

  def peek
    if empty?
      raise 'Queue is empty.'
    end
    return @front
  end

  def empty?
    @front == nil
  end

  def extract n
    nprev = n.prev
    nnext = n.next
    nprev.next = nnext if !!nprev
    @front = nnext if n == @front
    nnext.prev = nprev if !!nnext
    @back = nprev if n == @back
  end

  def to_s
    return '' if empty?
    out = "front <- #{@front.value}"
    h = @front
    while !!h.next
      h = h.next
      out += " <- #{h.value}"
    end
    out += " <- back"
    return out
  end

end

class AdoptionCenter

  def initialize
    @all = LinkedListQueue.new
    @dogs = LinkedListQueue.new
    @cats = LinkedListQueue.new
    @map = Hash.new
  end

  def queue_dog n
    an = @all.queue n
    dn = @dogs.queue n
    @map[an] = [dn, @dogs]
    @map[dn] = [an, @all]
  end

  def queue_cat n
    an = @all.queue n
    cn = @cats.queue n
    @map[an] = [cn, @cats]
    @map[cn] = [an, @all]
  end

  def dequeue q
    puts "q = #{q}"
    n = q.dequeue
    puts "n = #{n}"
    on, oq = @map[n]
    @map.delete n
    @map.delete on
    oq.extract on
    return n.value
  end

  def dequeue_any
    dequeue @all
  end

  def dequeue_dog
    dequeue @dogs
  end

  def dequeue_cat
    dequeue @cats
  end

  def to_s
    out = "all: #{@all}\n"
    out += "cats: #{@cats}\n"
    out += "dogs: #{@dogs}"
    return out
  end

end

$q = AdoptionCenter.new

def qd n
  $q.queue_dog n
  puts "queue dog #{n}"
  puts $q
end

def qc n
  $q.queue_cat n
  puts "queue cat #{n}"
  puts $q
end

def dd
  n = $q.dequeue_dog
  puts "dequeue dog #{n}"
  puts $q
end

def dc
  n = $q.dequeue_cat
  puts "dequeue cat #{n}"
  puts $q
end

def da
  n = $q.dequeue_any
  puts "dequeue any #{n}"
  puts $q
end

qc 'c1'
qc 'c9'
qd 'd3'
qc 'c5'
qd 'd7'
dc
dd
da
dd
