#!/usr/bin/env ruby

def trie ww
  r = {}
  ww.each do |w|
    t = r
    w.chars.each do |c|
      t[c] ||= {}
      t = t[c]
    end
    t[:eow] = true
  end
  return r
end

def wic w, i, r, tried
  return true if w.length == i
  return false if !!tried[i]
  t = r
  while i < w.length
    c = w[i]
    return false if !t[c]
    t = t[c]
    if !!t[:eow] && wic(w, i+1, r, tried)
      return true
    end
    i += 1
  end
  tried[i] = true
  return false
end

def word_is_concat w, r
  wic w, 0, r, {}
end

def longest ww
  return nil if ww.empty?
  maxl = ww[0].length
  maxw = ww[0]
  i = 1
  while i < ww.length
    len = ww[i].length
    if len > maxl
      maxl = len
      maxw = ww[i]
    end
    i += 1
  end
  return maxw
end

def longest_concat ww
  t = trie ww
  ww = ww.select { |w| word_is_concat w, t }
  return longest ww
end

def main
  [ [ ['what','whatsoever','where','ever','so','whatever','wherever'],
      'whatsoever' ]
  ].each do |i, e|
    a = longest_concat i
    print "longest_concat #{i} = #{a} ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

main
