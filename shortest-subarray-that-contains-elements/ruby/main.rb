#!/usr/bin/env ruby

def shortest_subarray s, l
  return nil if s.empty?
  left = 0
  right = -1
  sc = {}
  s.each { |n| sc[n] = 0 }
  remain = s.length
  min_len = min_l = min_r = nil
  while true
    right +=1
    while right < l.length && !sc[l[right]]
      right += 1
    end
    break if right == l.length
    remain -= 1 if sc[l[right]] == 0
    sc[l[right]] += 1
    while true
      if !sc[l[left]]
        left += 1
      elsif sc[l[left]] > 1
        sc[l[left]] -= 1
        left += 1
      else
        break
      end
    end
    if remain == 0
      if min_len == nil || min_len > right - left + 1
        min_len = right - left + 1
        min_l = left
        min_r = right
      end
    end
  end
  if min_len == nil
    return nil
  else
    return l[min_l..min_r]
  end
end

def main
  [ [[9, 5, 7],
     [9, 10, 7, 7, 5, 9],
     [7, 5, 9]],
    [[7, 10],
     [9, 10, 7, 7, 5, 9],
     [10, 7]],
    [[11],
     [9, 10, 7, 7, 5, 9],
     nil]
  ].each do |s, l, e|
    a = shortest_subarray s, l
    print "shortest_subarray #{s}, #{l} = #{a} ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

main
