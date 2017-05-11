#!/usr/bin/env ruby

$balanced_hash = {}

def balanced n
  if n == 0
    return ['']
  elsif $balanced_hash.has_key? n
    return $balanced_hash [n]
  end

  r = []
  a_len = 0
  b_len = n - 1
  while b_len >= 0
    aa = balanced a_len
    bb = balanced b_len
    aa.each do |a|
      bb.each do |b|
        r << "(#{a})#{b}"
      end
    end
    a_len += 1
    b_len -= 1
  end
  $balanced_hash[n] = r
  return r
end

[ [0, ['']],
  [1, ['()']],
  [2, ['()()', '(())']],
  [3, ['()()()', '()(())', '(())()', '(()())', '((()))']],
  [4, ['()()()()', '()()(())', '()(())()', '()(()())', '()((()))',
       '(())()()', '(())(())',
       '(()())()', '((()))()',
       '(()()())', '(()(()))', '((())())', '((()()))', '(((())))']]
].each do |n, e|
  a = balanced n
  if a == e
    print 'PASS '
  else
    print 'FAIL '
  end
  puts "balanced #{n} = #{a}"
  if a != e
    puts "     balanced #{n} = #{e}"
  end
end
