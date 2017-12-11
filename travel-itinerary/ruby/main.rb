#!/usr/bin/env ruby

def find_origin_and_dest legs
  origin = {}
  not_origin = {}
  dest = {}
  not_dest = {}

  legs.each do |o, d|

    if !not_origin[o]
      origin[o] = true
    end
    not_origin[d] = true
    origin.delete d

    if !not_dest[d]
      dest[d] = true
    end
    not_dest[o] = true
    dest.delete o

  end

  return origin.keys.first, dest.keys.first
end

def main
  n = readline.to_i
  legs = []
  while n > 0
    legs << readline.split(' ')
    n -= 1
  end
  puts find_origin_and_dest(legs).join(' ')
end

main
