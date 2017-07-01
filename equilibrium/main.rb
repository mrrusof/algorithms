#!/usr/bin/env ruby

def equilibrium_index nn
  return -1 if nn.length == 0
  return 0 if nn.length == 1
  ls = 0
  rs = nn[1..-1].reduce(0, &:+)
  return 0 if rs == 0
  nn[1..-1].each_with_index do |n, i|
    ls += nn[i]
    rs -= n
    return i + 1 if ls == rs
  end
  return -1
end

while true
  nn = readline.strip.split(' ').map(&:to_i) rescue break
  puts equilibrium_index nn
end

# Yes/No version
#
# readline
# while true
#   readline rescue break
#   nn = readline.strip.split(' ').map(&:to_i) rescue break
#   if -1 == equilibrium_index(nn)
#     puts 'NO'
#   else
#     puts 'YES'
#   end
# end
