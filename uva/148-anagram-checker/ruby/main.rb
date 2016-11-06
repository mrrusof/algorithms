#!/usr/bin/env ruby

def read_part
  part = []
  while true
    l = readline.strip rescue break
    break if l == '#'
    part << l
  end
  return part
end

# true iff multiset w is included in multiset s
# w: 123
#       |
# s: 1a2b3c
#         |
def msub w, s
  i = 0
  j = 0
  while i < w.length and j < s.length
    i += 1 if w[i] == s[j]
    j += 1
  end
  return i == w.length
end

# multiset difference s - w
def mdif s, w
#  print "mdif(#{s}, #{w}) = "
  s = s.dup
  i = 0
  j = 0
  while i < s.length and j < w.length
    if s[i] == w[j]
      s = s.chars
      s.delete_at(i)
      s = s.join
      j += 1
    else
      i += 1
    end
  end
#  puts s
  return s
end

$cache = {}

def do_et ww, n, p
#  puts "do_et(#{ww}, #{n}, #{p}) ="
  k = "#{ww}-#{n}"
  return $cache[k] if $cache[k]
  return [ [p, []] ] if n == 0
  return [] if ww.empty? or n < 0
  w = ww.first
  ww_tail = ww[1..-1]
  # take the word
  r = do_et(ww_tail, n - w[0].length, p).map { |d, a| [mdif(d, w[1]), a + [w[0]]] }
  # or not
  r += do_et(ww_tail, n, p)
#  puts "do_et(#{ww}, #{n}, #{p}) = #{r}"
  $cache[k] = r
  return r
end

def anagrams ww, p, sp
  r = do_et(ww, sp.length, sp).select { |d, a| d == '' }.map { |_, a| a.sort }
  p = p.split.sort
  return r.reject { |a| a == p }
end

def main
  dict = read_part
#  puts "dict = #{dict}"
  phrs = read_part
#  puts "phrs =  #{phrs}"

  # canonical dict
  dict.map! { |w| [w, w.chars.sort.join] }
#  puts "dict = #{dict}"

  # canonical phrases
  phrs.map! { |p| [p, p.chars.sort.join.strip] }
#  puts "phrs = #{phrs}"

  # for each phrase...
  phrs.each do |p, sp|
    # find the words that fit in the phrase
    ww = dict.select { |_, w| msub w, sp }
#    puts "ww = #{ww}"
    aa = anagrams ww, p, sp
#    puts "aa = #{aa}"
    aa.each { |a| puts "#{p} = #{a.join(' ')}" }
  end
end

main
