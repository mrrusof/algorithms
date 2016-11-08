#!/usr/bin/env ruby

def max x, y
  return x if x >= y
  return y
end

def sliding_window_maximum nn, k
  return [] if nn.length == 0
  m1 = nn[0]
  p1 = 0
  m2 = nil
  p2 = nil
  for i in 1..(k-1)
    if nn[i] >= m1
      m1 = nn[i]
      p1 = i
    end
  end
  for i in (p1+1)..(k-1)
    if m2 == nil or nn[i] >= m2
      m2 = nn[i]
      p2 = i
    end
  end
  # puts "max\tnn"
  # puts "---\t----------------------------------------"
  # puts "#{m1}\t[#{nn[0..k-1].join('  ')}] #{nn[k+1..-1].join('  ')}"
  mm = [m1]
  for i in 0..(nn.length - k - 1)
    # contract
    if p1 == i
      m1 = m2
      p1 = p2
      m2 = nil
      p2 = nil
    end
    # expand
    if m1 == nil or nn[i + k] >= m1
      m1 = nn[i + k]
      p1 = i + k
      m2 = nil
      p2 = nil
    elsif m2 == nil or nn[i + k] >= m2
      m2 = nn[i + k]
      p2 = i + k
    end
#    puts "#{m1}\t #{nn[0..i].join('  ')} [#{nn[i+1..i+k].join('  ')}] #{nn[i+k+1..-1].join('  ') if nn[i+1+k+1..-1]}"
    mm << m1
  end
  return mm
end

def main
  while true
    # assume k > 0
    k = readline.to_i rescue break
    # assume nn.length > 0
    nn = readline.split.map(&:to_i) rescue break
    # puts "k = #{k}"
    # puts "nn = #{nn}"
    mm = sliding_window_maximum nn, k
    if mm.length > 0
      puts mm.join(' ')
    else
      puts 'empty'
    end
  end
end

main
