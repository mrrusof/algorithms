class Ahnentafel

  def initialize a
    @array = a
  end

  def to_s
    if @array.empty?
      return '<empty>'
    else
      to_ll(0).join "\n"
    end
  end

  def to_ll r
    if r >= @array.length
      return []
    end
    root = @array[r].to_s
    rlen = root.length
    left = to_ll(left_index r).map { |l| (' ' * (rlen + 1)) + '|' + l }
    right = to_ll(right_index r).map { |l| (' ' * (rlen + 1)) + '|' + l }
    unless left.empty? and right.empty?
      root += ' |'
    end
    return right + [root] + left
  end

  def left_index i
    i * 2 + 1
  end

  def right_index i
    i * 2 + 2
  end

end

def test
  t = Ahnentafel.new [1,2,3,4,5,6,7]
  puts t
end

test
