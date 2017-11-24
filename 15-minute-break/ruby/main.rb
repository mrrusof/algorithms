#!/usr/bin/env ruby

def schedule candidates
  max_on = max_off = 0
  candidates.each do |c|
    max_off_p = max_off
    max_off = [max_on, max_off].max
    max_on = max_off_p + c
  end
  return [max_on, max_off].max
end

def main
  [ [[45, 15, 15, 45], 90],
    [[15, 15, 45, 15, 15, 45], 105],
    [[15, 50, 45, 15, 15, 45], 110]
  ].each do |i, e|
    a = schedule i
    print "schedule #{i} = #{a} ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

main
