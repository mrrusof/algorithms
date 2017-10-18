#!/usr/bin/env ruby

def path_count r, g, target, zero, sums
  sums[zero] ||= 0
  sums[zero] += 1
  zero -= r
  count = (sums[zero + target] || 0)
  (g[r] || []).each do |c|
    count += path_count c, g, target, zero, sums
  end
  zero += r
  sums[zero] -= 1
  sums.delete zero if sums[zero] == 0
  return count
end

def main
  r, s = readline.strip.split(' ').map(&:to_i) rescue return
  n = readline.strip.to_i rescue return
  g = {}
  while (n -= 1) >= 0
    a, b = readline.strip.split(' ').map(&:to_i) rescue return
    g[a] ||= []
    g[a] << b
  end
  puts path_count r, g, s, 0, {}
end

main
