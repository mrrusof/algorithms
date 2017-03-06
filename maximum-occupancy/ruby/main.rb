#!/usr/bin/env ruby

def sweep_line ii, oo
  ii.sort!
  oo.sort!
  a = b = 0
  while a < ii.length or b < oo.length
    if b == oo.length or a < ii.length and ii[a] < oo[b]
      puts "check-in on #{ii[a]}"
      a += 1
    else
      puts "check-out on #{oo[b]}"
      b += 1
    end
  end
end

def occupancies ii, oo
  curr_date = 1
  curr_occupancy = 0
  ii.sort!
  oo.sort!
  a = b = 0
  while a < ii.length or b < oo.length
    if b == oo.length or a < ii.length and ii[a] < oo[b]
      if curr_date != ii[a]
        puts "occupancy on #{curr_date} is #{curr_occupancy}"
        curr_date = ii[a]
      end
      curr_occupancy += 1
      a += 1
    else
      if curr_date != oo[b]
        puts "occupancy on #{curr_date} is #{curr_occupancy}"
        curr_date = oo[b]
      end
      curr_occupancy -= 1
      b += 1
    end
  end
  puts "occupancy on #{curr_date} is #{curr_occupancy}"
end

def maximum_occupancy ii, oo
  max = 0
  curr_date = 1
  curr_occupancy = 0
  ii.sort!
  oo.sort!
  a = b = 0
  while a < ii.length or b < oo.length
    if b == oo.length or a < ii.length and ii[a] < oo[b]
      if curr_date != ii[a]
        curr_date = ii[a]
        max = curr_occupancy if max < curr_occupancy
      end
      curr_occupancy += 1
      a += 1
    else
      if curr_date != oo[b]
        curr_date = oo[b]
        max = curr_occupancy if max < curr_occupancy
      end
      curr_occupancy -= 1
      b += 1
    end
  end
  max = curr_occupancy if max < curr_occupancy
  return max
end

while true
  n = readline.strip.to_i rescue break
  ii = []
  oo = []
  while n > 0
    i, o = readline.strip.split(' ').map(&:to_i)
    ii << i
    oo << o
    n -= 1
  end
  sweep_line ii, oo
  occupancies ii, oo
  puts maximum_occupancy ii, oo
end
