#!/usr/bin/env ruby

def e l, r, s, e_n
  if l > 0
    e (l - 1), (r + 1), (s + '('), e_n
  end
  if r > 0
    e l, (r - 1), (s + ')'), e_n
  end
  if l == 0 and r == 0
    e_n << s
  end
  return e_n
end

# while true
#   n = readline.strip.to_i rescue break
#   puts e n, 0, '', []
# end

[ [0, ['']],
  [1, ['()']],
  [2, ['()()', '(())']],
  [3, ['()()()', '()(())', '(())()', '(()())', '((()))']],
  [4, ['()()()()', '()()(())', '()(())()', '()(()())', '()((()))',
       '(())()()', '(())(())',
       '(()())()', '((()))()',
       '(()()())', '(()(()))', '((())())', '((()()))', '(((())))']]
].each do |n, exp|
  exp.sort!
  a = e(n, 0, '', []).sort
  if a == exp
    print 'PASS '
  else
    print 'FAIL '
  end
  puts "e #{n} = #{a}"
  if a != exp
    puts "     e #{n} = #{exp}"
  end
end
