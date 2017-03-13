#!/usr/bin/env ruby

def dominant_palindromes_complicated s
  ll = Array.new(s.length, nil)
  rr = Array.new(s.length, nil)
  pc = 0
  left = 0
  (0...s.length).each do |right|
    if left < right - 2                    # Continue a palindrome.
      if left >= 0 and s[left] == s[right] # Sides match.
        pc -= 1 if ll[pc - 1] == left
        left -= 1
        next
      else                                 # Sides do not match.
        ll[pc] = left  + 1
        rr[pc] = right - 1
        pc += 1
      end
    end
    if right - 2 >= 0 and s[right - 2] == s[right]    # Found center of length 3.
      pc -= 1 if ll[pc - 1] == right - 2
      left = right - 3
    elsif right - 1 >= 0 and s[right - 1] == s[right] # Found center of length 2.
      left = right - 2
    else                                              # Found a single char palindrome.
      left = right
    end
  end
  if left < s.length - 2
    ll[pc] = left + 1
    rr[pc] = s.length - 1
    pc += 1
  end
  (0...pc).map { |i| puts s[ll[i]..rr[i]] }
end

def dominant_palindromes s
  ss = Array.new(s.length, nil)
  left = 0
  (0...s.length).each do |right|
    if left < right - 2 and left >= 0 and s[left] == s[right]
      ss[right - 1] = nil
      ss[right] = left
      left -= 1
    elsif (left = right - 2) >= 0 and s[left] == s[right]
      ss[right - 1] = nil if ss[right - 1] == left
      ss[right] = left
      left -= 1
    elsif (left = right - 1) >= 0 and s[left] == s[right]
      ss[right] = left
      left -= 1
    else
      left = right
    end
  end
  ss.each_with_index { |left, right| if !!left then puts s[left..right] end }
end

while true
  s = readline.strip rescue break
  puts s
  dominant_palindromes s
  puts
end
