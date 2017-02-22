#!/usr/bin/env ruby

# def max_subarray k, nn
#   return -1 if nn.length == 0
#   max = 0
#   sp = nn.map { |_| -1 }   # starting position
#   iz = 0                   # index of value zero
#   nn.each_with_index do |n, i|

#     m = n % k

#     # store m and increment value of each starting position
#     sp[iz] = i             # remember starting position for value m
#     iz -= m                # shift index of zero
#     iz += k if iz < 0      # wraparound index of zero

#     # find maximum value of subarray that ends in position i
#     v = k - 1              # candidate value is maximum possible
#     j = iz - 1             # index of candidate value w/o wraparound
#     j = k - 1 if j == -1   # wraparound index of candidate value
#     while j != iz and max < v
#       if 0 <= sp[j]        # is there a starting pos for candidate value?
#         max = v
#         return max if max = k - 1
#         break
#       end
#       v -= 1               # try next candidate value
#       j = k - 1 if (j -= 1) == -1
#     end
#   end
#   return max
# end

def max_subarray k, nn
  return -1 if nn.length == 0
  max = 0
  dd = []
  nn.each_with_index do |n, i|
    dd.map! { |d| (d + n) % k }
    dd.select! { |d| d != 0 }
    dd << n % k
    dd.uniq!
    max = [max, dd.max].max
  end
  return max
end

# def max_subarray k, nn
#   return -1 if nn.length == 0
#   # puts "k = #{k}"
#   # puts "nn = #{nn}"
#   nn.map! { |n| n % k }
#   max = 0
#   prefix_start = 0
#   prefix_value = 0
#   # puts "nn = #{nn}"
#   nn.each_with_index do |n, i|
#     max_prefix_value = k - 1 - n
#     while max_prefix_value < prefix_value
#       prefix_value -= nn[prefix_start]
#       prefix_start += 1
#     end
#     prefix_value += n
#     # actual                                          1801979803
#     # k                                               1804289384
#     puts "i = #{i}"
#     puts "prefix_value = #{prefix_value}"
#     if i == 3
#       puts 'analysis of bug'
#       puts "nn[0..3] = #{nn[0..3]}"
#       puts "sum(nn[0..3]) % k = #{nn[0..3].reduce(0, &:+) % k}"
#       puts "sum(nn[1..3]) % k = #{nn[1..3].reduce(0, &:+) % k} <-- correct value"
#       puts "sum(nn[2..3]) % k = #{nn[2..3].reduce(0, &:+) % k}"
#       puts "sum(nn[3..3]) % k = #{nn[3..3].reduce(0, &:+) % k}"
#     end
#     max = [max, prefix_value].max
#     return max if max == k - 1
#   end
#   return max
# end

# def max_subarray k, nn
#   return -1 if nn.length == 0
#   max = 0
#   (0...nn.length).each do |i|
#    puts "i = #{i}"
#    puts "nn[0..i] = #{nn[0..i]}"
#     pv = nn[0..i].reduce(0, &:+)
# #    puts "pv = #{pv}"
#     max_here = [max, pv % k].max
#     nn[0...i].each do |m|
#       pv -= m
# #      puts "m = #{m}"
# #      puts "pv = #{pv}"
#       max_here = [max_here, pv % k].max
#     end
#     puts "max_here = #{max_here}"
#     max = [max, max_here].max
#   end
#   return max
# end

# while true
#   k = readline.strip.to_i rescue break
#   nn = readline.strip.split(' ').map(&:to_i) rescue break
#   puts max_subarray k, nn
# end

_ = readline
while true
  _, k = readline.strip.split(' ').map(&:to_i) rescue break
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  puts max_subarray k, nn
end
