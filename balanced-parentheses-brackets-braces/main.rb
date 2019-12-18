def are_brackets_balanced? s
  pos = 0
  brackets = []
  left_to_right = {
    '(' => ')',
    '[' => ']',
    '{' => '}'
  }
  while pos < s.length
    case s[pos]
    when '(', '[', '{'
      brackets.push s[pos]
    when ')', ']', '}'
      return false if brackets.empty?
      left = brackets.pop
      right = left_to_right[left]
      return false if right != s[pos]
    end
    pos += 1
  end
  return brackets.empty?
end

while true
  line = readline.strip rescue break
  puts are_brackets_balanced? line
end
