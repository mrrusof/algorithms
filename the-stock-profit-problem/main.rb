#!/usr/bin/env ruby

def alg_g(a)
  min = (a && a[0]) || 0
  max = 0
  a.each do |a_i|
    if a_i < min
      min = a_i
    elsif a_i - min > max
      max = a_i - min
    end
  end
  return max
end

puts alg_g STDIN.read.split("\n").map { |a_i| a_i.to_i }
