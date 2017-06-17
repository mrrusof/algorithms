#!/usr/bin/env ruby

def count_common a, b

  count = 0
  pos_a = pos_b = 0
  n = a.length

  while pos_a < n and pos_b < n

    if a[pos_a] > b[pos_b]
      pos_b += 1
    elsif a[pos_a] == b[pos_b]
      puts "a[pos_a] = #{a[pos_a]}"
      count += 1
      pos_a += 1
      pos_b += 1
    else
      pos_a += 1
    end

  end

  return count

end


while true
  a = readline.strip.split(' ').map(&:to_i) rescue break
  b = readline.strip.split(' ').map(&:to_i) rescue break
  puts count_common a, b
end
