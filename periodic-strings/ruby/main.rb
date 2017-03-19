#!/usr/bin/env ruby

def period s
  k = 1
  while k <= s.length / 2
    if s.length % k != 0
      k += 1
      next
    end
    i = k
    while i < s.length
      j = 0
      while j < k and s[j] == s[i + j]
        j += 1
      end
      break if j < k
      i += k
    end
    return s[0...k] if i == s.length
    k += 1
  end
  return nil
end

def is_periodic? s
  s != nil
end

while true
  s = readline.strip rescue break
#  puts "is_periodic? #{s} = #{is_periodic? s}"
  puts "period #{s} = #{period s}"
end
