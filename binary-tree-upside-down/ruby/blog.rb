#!/usr/bin/env ruby

def flip r, pp
  nr = r
  npp = {}
  while !!pp[r]
    nr = pp[r][0]
    npp[nr] = [pp[r][1], r]
    r = nr
  end
  return nr, npp
end

def main
  pp = {}
  r = readline.strip rescue return
  while true
    i = readline.strip.split ' ' rescue break
    pp[i[0]] = i[1..2]
  end
  nr, npp = flip r, pp
  puts nr
  npp.each { |k, v| puts "#{k} #{v[0]} #{v[1]}" }
end

main
