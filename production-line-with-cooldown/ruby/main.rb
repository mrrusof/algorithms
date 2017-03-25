#!/usr/bin/env ruby

def process wl, cd
  time = 0
  last = Hash.new
  wl.chars.each do |w|
    if last[w] != nil and time - last[w] <= cd
      time += cd - (time - last[w])
    end
    time += 1
    last[w] = time
  end
  return time
end

while true
  cd = readline.strip.to_i rescue break
  wl = readline.strip rescue break
  puts process wl, cd
end
