#!/usr/bin/env ruby

def escape_spaces s, l
  spaces = 0
  i = 0
  while i < l
    spaces += 1 if s[i] == ' '
    i += 1
  end

  last_pos = l + spaces * 2

  while 0 < l and spaces > 0
    l -= 1
    if s[l] == ' '
      s[last_pos - 1] = '0'
      s[last_pos - 2] = '2'
      s[last_pos - 3] = '%'
      last_pos -= 3
      spaces -= 1
    else
      last_pos -= 1
      s[last_pos] = s[l]
    end
  end
end

while true
  s = readline.strip rescue break
  l = readline.to_i rescue break
  puts s, l
  escape_spaces s, (l + 1)
  puts s
end
