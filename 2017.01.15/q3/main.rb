#!/usr/bin/env ruby

nn = readline.strip.split(' ').map(&:to_i)


p = nn.delete_at(0)
s = p
nn.map! do |n|
  d = n - p
p = n
  if d.abs > 127
    d = [-128, d]
  end
  d
end

puts "#{s} #{nn.flatten.join(' ')}"
