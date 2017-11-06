#!/usr/bin/env ruby

def add_wo_plus a, b
  c = 0
  r = 0
  pb = 1
  while a > 0 or b > 0
    ba = 1 & a
    bb = 1 & b
    if ba == 1
      if bb == 1
        if c == 1
          r = r | pb
        else
          c = 1
        end
      else
        if c == 1
          c = 1
        else
          r = r | pb
        end
      end
    else
      if bb == 1
        if c == 1
          c = 1
        else
          r = r | pb
        end
      else
        if c == 1
          r = r | pb
          c = 0
        end
      end
    end
    a = a >> 1
    b = b >> 1
    pb = pb << 1
  end
  if c == 1
    r = r | pb
  end
  return r
end

def main
  (0..100).each do |x|
    (0..100).each do |y|
      s = add_wo_plus x, y
      print "#{x} + #{y} = #{s} ... "
      if s != x + y
        puts "FAIL"
        break
      end
      puts "PASS"
    end
  end
end

main
