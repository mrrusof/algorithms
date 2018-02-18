#!/usr/bin/env ruby

def get_initial_right c, s
  found = 0
  r = 0
  while found < c.length && r < s.length
    if c.has_key? s[r]
      c[s[r]] += 1
      if c[s[r]] == 1
        found += 1
      end
    end
    r += 1
  end
  return -1 if found < c.length
  return r - 1
end

def shortest_substring_that_contains_letters s, allowed

  return s if allowed == []

  c = {}
  allowed.chars.each { |n| c[n] = 0 }
  l = 0
  r = get_initial_right c, s

  return '' if r == -1

  min_len = r - l + 1
  min_l = l
  min_r = r

  while true

    # contract window
    while true
      if c.has_key? s[l]
        if c[s[l]] == 1
          break
        else
          c[s[l]] -= 1
        end
      end
      l += 1
    end

    # update best solution
    len = r - l + 1
    if len < min_len
      min_len = len
      min_l = l
      min_r = r
    end

    # expand window
    r += 1
    break if r == s.length
    if c.has_key? s[r]
      c[s[r]] += 1
    end

  end

  return s[min_l..min_r]

end

# while true
#   a = readline.strip rescue break
#   b = readline.strip rescue break
#   puts shortest_substring_that_contains_letters a, b
# end

def test test_cases, f
  test_cases.each do |s, l, e|
    a = send(f, s, l)
    print "#{f} #{s}, #{l} = #{a} ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

def main
  test_cases = [ ["697581539",
                  "915",
                  "1539"],
                 ["935185796",
                  "915",
                  "9351"],
                 ["917759",
                  "957",
                  "759"],
                 ["917759",
                  "71",
                  "17"],
                 ["917759",
                  "8",
                  ""] ]
  test test_cases, 'shortest_substring_that_contains_letters'
end

main
