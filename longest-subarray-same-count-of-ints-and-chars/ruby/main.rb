#!/usr/bin/env ruby

def longest a
  nn = a.map { |e| if e.is_a? Integer then -1 else 1 end }
  fts = {0 => -1}
  sum = 0
  max_len = 0
  max_begin = 0
  max_end = 0
  nn.each_with_index do |n, i|
    fts[sum += n] ||= i
    len = i - fts[sum]
    if len > max_len
      max_len = len
      max_begin = i - len + 1
      max_end = i
    end
  end
  return [] if max_begin >= max_end
  return a[max_begin .. max_end]
end

def main
  [ [ [], [] ],
    [ ['a'], [] ],
    [ ['a','b'], [] ],
    [ [1], [] ],
    [ [1,2], [] ],
    [ ['a',1], ['a',1] ],
    [ [1,'a'], [1,'a'] ],
    [ ['a',1,'a'], ['a',1] ],
    [ ['a',1,'a',2], ['a',1,'a',2] ]
  ].each do |i, e|
    a = longest i
    print "longest #{i} = #{a} ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end      
end

main
