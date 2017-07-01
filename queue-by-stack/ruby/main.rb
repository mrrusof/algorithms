class QueueByStack

  def initialize
    @dequeue = Array.new
    @queue = Array.new
    @reay_for_dequeue = false
  end

  def queue v
    if @ready_for_dequeue
      dump @dequeue, @queue
      @ready_for_dequeue = false
    end
    @queue.push v
  end

  def dequeue
    if not @ready_for_dequeue
      dump @queue, @dequeue
      @ready_for_dequeue = true
    end
    raise 'Queue is empty.' if @dequeue.empty?
    return @dequeue.pop
  end

  def dump from, to
    while not from.empty?
      to.push from.pop
    end
  end

  def to_s
    out  = '  queue:' + @queue.map(&:to_s).join(' ') + "\n"
    out += 'dequeue:' + @dequeue.map(&:to_s).join(' ')
    return out
  end

end

class QueueByStackBetterSolution

  def initialize
    @dequeue = Array.new
    @queue = Array.new
  end

  def queue v
    @queue.push v
  end

  def dequeue
    conditional_dump
    raise 'Queue is empty' if @dequeue.empty?
    return @dequeue.pop
  end

  def conditional_dump
    if @dequeue.empty?
      while not @queue.empty?
        @dequeue.push @queue.pop
      end
    end
  end

  def to_s
    out  = '  queue:' + @queue.map(&:to_s).join(' ') + "\n"
    out += 'dequeue:' + @dequeue.map(&:to_s).join(' ')
    return out
  end

end

def qp q, v
  q.queue v
  puts "queue   #{v} into \n#{q}\n"
end

def dp q
  v = q.dequeue
  puts "dequeue #{v} from \n#{q}\n"
end

def test q
  qp q, 8
  qp q, 6
  dp q
  qp q, 9
  qp q, 10
  dp q
  dp q
  dp q
  begin
    dp q
  rescue => e
    puts e
  end
end

q = QueueByStack.new
test q
puts
q = QueueByStackBetterSolution.new
test q
