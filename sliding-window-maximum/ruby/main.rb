#!/usr/bin/env ruby

def max x, y
  return x if x >= y
  return y
end

def sliding_window_maximum nn, k
  return [] if nn.length == 0
  mmpp = []
  mm = []
  for i in 0..(k-1)
    while mmpp.last and mmpp.last[0] <= nn[i]
      mmpp.pop
    end
    mmpp << [nn[i], i]
  end
  mm << mmpp.first[0]
  for i in 0..(nn.length - k - 1)
    # contract
    if mmpp.first and mmpp.first[1] == i
      mmpp.delete_at(0)
    end
    # expand
    while mmpp.last and mmpp.last[0] <= nn[i + k]
      mmpp.pop
    end
    mmpp << [nn[i + k], i + k]
    mm << mmpp.first[0]
  end
  return mm
end

def main
  while true
    # assume k > 0 when nn.length > 0
    k = readline.to_i rescue break
    nn = readline.split.map(&:to_i) rescue break
    mm = sliding_window_maximum nn, k
    if mm.length > 0
      puts mm.join(' ')
    else
      puts 'empty'
    end
  end
end

main
