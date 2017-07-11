class Tree

  class Node

    attr_accessor :value, :left, :right

    def initialize v, l, r
      @value = v
      @left = l
      @right = r
    end

    def to_s
      to_ll.join "\n"
    end

    def to_ll
      root = @value.to_s
      rlen = root.length
      out = []
      if !!@right
        out += @right.to_ll.map { |l| (' ' * rlen) + ' |' + l }
      end
      if !!@right or !!@left
        root += ' |'
      end
      out << root
      if !!@left
        out += @left.to_ll.map { |l| (' ' * rlen) + ' |' + l }
      end
      return out
    end

  end

  def initialize t
    @root = load_ahnentafel t, 0
  end

  def load_ahnentafel t, r
    if r >= t.length
      return nil
    end
    left = load_ahnentafel t, index_left(r)
    right = load_ahnentafel t, index_right(r)
    return Node.new t[r], left, right
  end

  def index_left i
    i * 2 + 1
  end

  def index_right i
    i * 2 + 2
  end

  def to_s
    return '<empty>' if !@root
    return @root.to_s
  end

end


def test
  t = Tree.new [1,2,3,4,5,6,7]
  puts t
end

test
