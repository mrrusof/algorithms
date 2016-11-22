#!/usr/bin/env ruby

def full_justify ww, m
  ll = []
  l = [ww.first]
  c = ww.first.length
  ww[1..-1].each do |w|
    if c + 1 + w.length <= m
      l << w
      c += 1 + w.length
    else
      ll << [l, c - (l.length - 1)]
      l = [w]
      c = w.length
    end
  end
  ll << [l, c - (l.length - 1)]
  o = ll[0..-2].map do |l, c|
    seps = l.length - 1
    blanks = m - c
    if l.length == 1
      l.first + (' ' * blanks)
    else
      base_blanks = blanks / seps
      left_blanks = blanks % seps
      l[1..-1].reduce(l.first) do |acc, w|
        if left_blanks > 0
          left_blanks -= 1
          acc + (' ' * (base_blanks + 1)) + w
        else
          acc + (' ' * base_blanks) + w
        end
      end
    end
  end
  l, c = ll[-1]
  o << l.join(' ') + (' ' * (m - c - (l.length - 1)))
  puts "#{o}"
  return o
end

[ [ [ "This", "is", "an",
      "example", "of", "text",
      "justification." ],
    16,
    [ "This    is    an",
      "example  of text",
      "justification.  " ] ],
  [ [ "a","b","c","d","e"],
    1,
    [ "a","b","c","d","e"] ],
  [ [ "Listen",
      "to",
      "many,",
      "speak",
      "to","a",
      "few."],
    6,
    [ "Listen",
      "to    ",
      "many, ",
      "speak ",
      "to   a",
      "few.  " ] ],
  [ [ "What","must","be",
      "shall","be."],
    12,
    [ "What must be",
      "shall be.   "]
  ],
  [ [ "My","momma","always",
      "said,","\"Life","was","like",
      "a","box","of","chocolates.",
      "You","never","know","what",
      "you're","gonna","get."],
    20,
    [ "My    momma   always",
      "said, \"Life was like",
      "a box of chocolates.",
      "You  never know what",
      "you're gonna get.   "]
  ],
  [ [ "Listen",
      "to",
      "many,",
      "speak",
      "to","a",
      "few."],
    6,
    [ "Listen",
      "to    ",
      "many, ",
      "speak ",
      "to   a",
      "few.  "] ],
  [ [ "Don't","go","around","saying","the",
      "world","owes","you","a","living;","the",
      "world","owes","you","nothing;","it","was",
      "here","first."],
    30,
    [ "Don't  go  around  saying  the",
      "world  owes  you a living; the",
      "world owes you nothing; it was",
      "here first.                   " ] ],
  [ [ "But","soft!","What","light","through","yonder","window","breaks?","It","is","the","East,","and","Juliet","is","the","sun!","Arise,","fair","sun,","and","kill","the","envious","moon,","who","is","already","sick","and","pale","with","grief","That","thou","her","maid","art","far","more","fair","than","she."],
    20,
    [ "But soft! What light",
      "through       yonder",
      "window breaks? It is",
      "the East, and Juliet",
      "is  the  sun! Arise,",
      "fair  sun,  and kill",
      "the   envious  moon,",
      "who  is already sick",
      "and  pale with grief",
      "That  thou  her maid",
      "art  far  more  fair",
      "than she.           " ],
    [ "But soft! What light",
      "through       yonder",
      "window breaks? It is",
      "the East, and Juliet",
      "is   the sun! Arise,",
      "fair   sun, and kill",
      "the   envious  moon,",
      "who  is already sick",
      "and  pale with grief",
      "That   thou her maid",
      "art  far  more  fair",
      "than she.           " ] ]
].each do |ww, m, exp|
  act = full_justify ww, m
  if act == exp
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " #{ww} -> #{act}"
end
