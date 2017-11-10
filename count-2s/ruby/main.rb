#!/usr/bin/env ruby

def digit n, i
  n / (10 ** i) % 10
end

def count_order n, i
  d = digit n, i
  a = n / (10 ** (i + 1)) * (10 ** i)
  if d == 2
    return a + n % (10 ** i) + 1
  elsif d > 2
    return a + (10 ** i)
  else
    return a
  end
end

def count_2s n
  c = 0
  i = 0
  m = n
  while m > 0
    c += count_order n, i
    m = m / 10
    i += 1
  end
  return c
end

def main
  puts count_2s 29  # 13
  puts count_2s 119 # 22
  puts count_2s 121 # 24
  puts count_2s 122 # 26
  puts count_2s 123 # 27
end

main
